#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cJSON.h"
#include <math.h> // For ceil function

#ifdef _WIN32
#include <winsock2.h>
#include <ws2tcpip.h>
#pragma comment(lib, "ws2_32.lib")

WSADATA wsaData;
#define close closesocket
#else
#include <unistd.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#endif

#define CHUNK_SIZE 4096

int server_socket, client_socket;
struct sockaddr_in server_addr, client_addr;

void start_server(int port);
void stop_server();
void send_data(const cJSON *data);
void receive_data(cJSON **data);
int handshake();
void send_large_data(const cJSON *data);
cJSON* receive_large_data(int max_attempts);

void start_server(int port) {
#ifdef _WIN32
    if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0) {
        fprintf(stderr, "WSAStartup failed.\n");
        exit(EXIT_FAILURE);
    }
#endif

    server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket < 0) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;
    server_addr.sin_port = htons(port);

    if (bind(server_socket, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }

    if (listen(server_socket, 1) < 0) {
        perror("Listen failed");
        exit(EXIT_FAILURE);
    }

    int addrlen = sizeof(client_addr);
    client_socket = accept(server_socket, (struct sockaddr*)&client_addr, (socklen_t*)&addrlen);
    if (client_socket < 0) {
        perror("Accept failed");
        exit(EXIT_FAILURE);
    }

}

void stop_server() {
    if (client_socket) {
        close(client_socket);
    }
    close(server_socket);

#ifdef _WIN32
    WSACleanup();
#endif
    printf("Server has stopped\n");
    //exit(EXIT_SUCCESS);
}

void send_data(const cJSON *data) {
    char *serialized_data = cJSON_PrintUnformatted(data);
    char buffer[CHUNK_SIZE];
    snprintf(buffer, sizeof(buffer), "%s\n", serialized_data);
    if (send(client_socket, buffer, strlen(buffer), 0) < 0) {
        perror("Send failed");
        stop_server();
    }
    free(serialized_data);
}

void receive_data(cJSON **data) {
    char buffer[CHUNK_SIZE];
    int bytes_received = recv(client_socket, buffer, CHUNK_SIZE - 1, 0);
    if (bytes_received < 0) {
        perror("Receive failed");
        stop_server();
    }
    buffer[bytes_received] = '\0';
    printf("receive_data = %s\n", buffer);
    cJSON *parsed_json = cJSON_Parse(buffer);
    if (parsed_json == NULL) {
        fprintf(stderr, "Failed to parse JSON\n");
        stop_server();
    }
    *data = parsed_json;
}

int handshake() {
    char buffer[CHUNK_SIZE] = {0};
    int bytes_received;
    bytes_received = recv(client_socket, buffer, CHUNK_SIZE, 0);
    if (bytes_received < 0) {
        perror("Receive failed");
        return 0;
    }
    buffer[bytes_received] = '\0';

    if (strcmp(buffer, "HELLO SERVER") == 0) {
        send(client_socket, "HELLO CLIENT", strlen("HELLO CLIENT"), 0);
        memset(buffer, 0, CHUNK_SIZE);
        bytes_received = recv(client_socket, buffer, CHUNK_SIZE, 0);
        if (bytes_received < 0) {
            perror("Receive failed");
            return 0;
        }
        buffer[bytes_received] = '\0';

        if (strcmp(buffer, "OK") == 0) {
            return 1;
        }
    }
    return 0;
}

void send_large_data(const cJSON *data) {
    char *serialized_data = cJSON_PrintUnformatted(data);
    int data_len = strlen(serialized_data);
    int num_chunks = (int)ceil((double)data_len / CHUNK_SIZE);
    
    for (int i = 0; i < num_chunks; i++) {
        int start_idx = i * CHUNK_SIZE;
        int end_idx = start_idx + CHUNK_SIZE;
        if (end_idx > data_len) end_idx = data_len;

        cJSON *chunk_obj = cJSON_CreateObject();
        cJSON_AddItemToObject(chunk_obj, "chunk", cJSON_CreateString(serialized_data + start_idx));  // Adjusted for chunked data
        cJSON_AddNumberToObject(chunk_obj, "index", i);
        cJSON_AddNumberToObject(chunk_obj, "total", num_chunks);

        send_data(chunk_obj);
        printf("Chunk number %d sent\n", i);

        cJSON *response;
        receive_data(&response);
        printf("Server answered: %s\n", cJSON_Print(response));
        cJSON_Delete(response);

        cJSON_Delete(chunk_obj);
    }
    free(serialized_data);
}

cJSON* receive_large_data(int max_attempts) {
    cJSON *partial_data_obj = cJSON_CreateArray();
    int attempts = 0;

    while (attempts < max_attempts) {
        printf("Attempts: %d\n", attempts);
        cJSON *chunk_obj;
        receive_data(&chunk_obj);
        if (chunk_obj) {
            const char *chunk_data = cJSON_GetObjectItem(chunk_obj, "chunk")->valuestring;
            int index = cJSON_GetObjectItem(chunk_obj, "index")->valueint;
            int total = cJSON_GetObjectItem(chunk_obj, "total")->valueint;

            cJSON_InsertItemInArray(partial_data_obj, index, cJSON_CreateString(chunk_data));
            cJSON_Delete(chunk_obj);

            cJSON *response_obj = cJSON_CreateObject();
            cJSON_AddStringToObject(response_obj, "data", chunk_data);
            cJSON_AddStringToObject(response_obj, "message", "Chunk received successfully");
            send_data(response_obj);
            cJSON_Delete(response_obj);

            printf("Index = %d / Total = %d\n", index, total - 1);
            if (index + 1 == total) {
                printf("Last chunk received\n");
                char *complete_data = cJSON_PrintUnformatted(partial_data_obj);
                cJSON *result = cJSON_Parse(complete_data);
                free(complete_data);
                cJSON_Delete(partial_data_obj);
                return result;
            }
        } else {
            fprintf(stderr, "Failed to parse chunk\n");
            cJSON_Delete(partial_data_obj);
            return NULL;
        }
        attempts++;
    }
    cJSON_Delete(partial_data_obj);
    return NULL;
}

int main() {
    int port = 8080; // Set your desired port number
    start_server(port);

    if (handshake()) {
        printf("Handshake successful\n");

        // Example to receive large data
        cJSON *received_data = receive_large_data(10);
        printf("Received large data: %s\n", cJSON_Print(received_data));
        cJSON_Delete(received_data);

        // Example data to send
        cJSON *data = cJSON_CreateObject();
        cJSON_AddStringToObject(data, "key", "value");
        send_large_data(data);
        cJSON_Delete(data);
    } else {
        printf("Handshake failed\n");
    }

    stop_server();
    return 0;
}

#ifdef __cplusplus
extern "C" {
#endif

__declspec(dllexport) void sv_start_server(int port) {
    start_server(port);
}

__declspec(dllexport) void sv_stop_server() {
    stop_server();
}

__declspec(dllexport) int sv_handshake() {
    return handshake();
}

__declspec(dllexport) void sv_send_data(const char *json_str) {
    cJSON *data = cJSON_Parse(json_str);
    if (data != NULL) {
        send_data(data);
        cJSON_Delete(data);
    } else {
        fprintf(stderr, "Invalid JSON data\n");
    }
}

__declspec(dllexport) char* sv_receive_data() {
    cJSON *data;
    receive_data(&data);
    if (data != NULL) {
        char *result = cJSON_PrintUnformatted(data);
        cJSON_Delete(data);
        return result;
    }
    return NULL;
}

__declspec(dllexport) void sv_send_large_data(const char *json_str) {
    cJSON *data = cJSON_Parse(json_str);
    if (data != NULL) {
        send_large_data(data);
        cJSON_Delete(data);
    } else {
        fprintf(stderr, "Invalid JSON data\n");
    }
}

__declspec(dllexport) char* sv_receive_large_data(int max_attempts) {
    cJSON *data = receive_large_data(max_attempts);
    if (data != NULL) {
        char *result = cJSON_PrintUnformatted(data);
        cJSON_Delete(data);
        return result;
    }
    return NULL;
}

#ifdef __cplusplus
}
#endif