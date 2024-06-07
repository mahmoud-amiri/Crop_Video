import socket
import json

class SocketClient:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.client_socket = self.start_client()
        self.replacements = {
            '{': '#1*',
            '}': '#2*',
            '[': '#3*',
            ']': '#4*',
            ':': '#5*',
            ',': '#6*',
            '"': '#7*',
            'true': '#8*',
            'false': '#9*',
            'null': '#0*',
            ' ': '#A*',
            '\n': '#B*',
            '\t': '#C*'
        }
        self.reverse_replacements = {v: k for k, v in self.replacements.items()}
    
    def start_client(self):
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.connect((self.host, self.port))
        return client_socket

    def handshake(self):
        self.client_socket.sendall(b"HELLO SERVER")
        response = self.client_socket.recv(4096).decode()
        if response == "HELLO CLIENT":
            self.client_socket.sendall(b"OK")
            return True
        return False

    def send_data(self, data):
        serialized_data = json.dumps(data) + '\n'
        self.client_socket.sendall(serialized_data.encode())

    def receive_data(self):
        buffer = b""
        while True:
            part = self.client_socket.recv(4096)
            buffer += part
            if b'\n' in buffer:
                break
        return json.loads(buffer.decode())

    def send_large_data(self, data):
        serialized_data = json.dumps(data)
        data_len = len(serialized_data)
        chunk_size = 4096
        num_chunks = (data_len + chunk_size - 1) // chunk_size  # ceil(data_len / chunk_size)

        for i in range(num_chunks):
            start_idx = i * chunk_size
            end_idx = min(start_idx + chunk_size, data_len)
            chunk = serialized_data[start_idx:end_idx]
            chunk = self.escape_json_characters(chunk)
            chunk_obj = {
                "chunk": chunk,
                "index": i,
                "total": num_chunks
            }
            self.send_data(chunk_obj)
            response = self.receive_data()
            print("Server answered:", response)

    def receive_large_data(self, max_attempts=10):
        partial_data = []
        attempts = 0

        while attempts < max_attempts:
            chunk_obj = self.receive_data()
            if chunk_obj:
                chunk = chunk_obj["chunk"]
                index = chunk_obj["index"]
                total = chunk_obj["total"]

                while len(partial_data) <= index:
                    partial_data.append(None)
                partial_data[index] = chunk

                self.send_data({"message": "Chunk received successfully"})

                if all(partial_data):
                    complete_data = ''.join(partial_data)
                    return json.loads(self.unescape_json_characters(complete_data))
            else:
                attempts += 1

        return None

    def escape_json_characters(self, json_string):
        for json_char, custom_str in self.replacements.items():
            json_string = json_string.replace(json_char, custom_str)
        return json_string

    def unescape_json_characters(self, escaped_string):
        for custom_str, json_char in self.reverse_replacements.items():
            escaped_string = escaped_string.replace(custom_str, json_char)
        return escaped_string

    def close(self):
        self.client_socket.close()


# if __name__ == "__main__":
#     host = "localhost"
#     port = 8081

#     client = SocketClient(host, port)
#     if client.handshake():
#         print("Handshake successful")

#         # Example data to send
#         data = {"frame": "10", "x": "12", "y": "25", "value": "154", "A": "B"}
#         client.send_large_data(data)

#         # Example to receive data
#         received_data = client.receive_large_data()
#         print("Received large data:", received_data)
#     else:
#         print("Handshake failed")

#     client.close()