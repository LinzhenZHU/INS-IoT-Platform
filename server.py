import socket
import threading
import re

# Server configuration
server_ip = '0.0.0.0'
server_port = 8866

# Create a socket object
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Enable SO_REUSEADDR option to allow the reuse of local addresses
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# Bind the socket to the specified IP address and port
server_socket.bind((server_ip, server_port))

# Set the socket to listen for incoming connections
server_socket.listen()
print(f"Listening on {server_ip}:{server_port}...")

# Define a function to handle client connections
def handle_client_connection(client_socket):
    buffer = ""  # Initialize a buffer to accumulate incoming data
    try:
        while True:
            # Receive data from the client
            data = client_socket.recv(1024).decode('utf-8')
            if not data:
                break  # Exit the loop if no data is received
            buffer += data  # Append received data to the buffer
            while '\n' in buffer:  # Process each message if a newline character is present
                message, buffer = buffer.split('\n', 1)  # Split the buffer at the newline
                message = message.strip()
                if message:  # Proceed if the message is not empty
                    device_identifier = message[0]  # Extract the device identifier (A, B, or C)
                    if device_identifier in ['A', 'B', 'C']:
                        file_path = f'{device_identifier}.txt'
                        # Remove all alphabetical characters, retaining only numbers and other characters
                        filtered_message = re.sub(r'[A-Za-z]', '', message[1:])
                        with open(file_path, 'a') as file:
                            file.write(filtered_message + '\n')
                            file.flush()
    finally:
        client_socket.close()  # Ensure the client socket is closed

# Main loop to accept and handle incoming connections
while True:
    client_socket, client_address = server_socket.accept()
    print(f"Connected by {client_address}")
    client_thread = threading.Thread(target=handle_client_connection, args=(client_socket,))
    client_thread.start()
