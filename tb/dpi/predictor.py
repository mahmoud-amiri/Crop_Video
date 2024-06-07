from client_api import SocketClient

if __name__ == "__main__":
    host = "localhost"
    port = 8081
    data = []
    client = SocketClient(host, port)
    if client.handshake():
        print("Handshake successful")
        while True:
            received_data = client.receive_large_data()
            
            try:
                print(f"received_data = {received_data}")
                s00_axis_tdata = int(received_data["s00_axis_tdata"]) 
                s00_axis_tstrb = int(received_data["s00_axis_tstrb"]) 
                s00_axis_tlast = int(received_data["s00_axis_tlast"]) 
                s00_axis_tvalid = int(received_data["s00_axis_tvalid"]) 
                s00_axis_tuser = int(received_data["s00_axis_tuser"]) 
                s00_axis_tready = int(received_data["s00_axis_tready"]) 
                crop_x = int(received_data["crop_x"]) 
                crop_y = int(received_data["crop_y"])
                crop_width = int(received_data["crop_width"]) 
                crop_height = int(received_data["crop_height"])

                m00_axis_tdata = s00_axis_tdata
                m00_axis_tstrb = s00_axis_tstrb
                m00_axis_tlast = s00_axis_tlast
                m00_axis_tvalid = s00_axis_tvalid
                m00_axis_tuser = s00_axis_tuser
                m00_axis_tready = s00_axis_tready


                data["m00_axis_tdata"] = str(m00_axis_tdata)
                data["m00_axis_tstrb"] = str(m00_axis_tstrb)
                data["m00_axis_tlast"] = str(m00_axis_tlast)
                data["m00_axis_tvalid"] = str(m00_axis_tvalid)
                data["m00_axis_tuser"] = str(m00_axis_tuser)
                data["m00_axis_tready"] = str(m00_axis_tready)


                print("Processed data:", data)
            except ValueError:
                print("Error: received_data['input'] is not a valid integer")
                data["m00_axis_tdata"] = '0'
                data["m00_axis_tstrb"] = '0'
                data["m00_axis_tlast"] = '0'
                data["m00_axis_tvalid"] = '0'
                data["m00_axis_tuser"] = '0'
                data["m00_axis_tready"] = '0'

            client.send_large_data(data)

        # Example to receive data
        
    else:
        print("Handshake failed")

    # client.close()