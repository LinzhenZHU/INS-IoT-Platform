import socket
import threading
import re

# 服务器配置
server_ip = '0.0.0.0'
server_port = 8866

# 创建socket对象
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 设置SO_REUSEADDR选项
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

# 绑定IP地址和端口号
server_socket.bind((server_ip, server_port))

# 监听连接
server_socket.listen()
print(f"Listening on {server_ip}:{server_port}...")

# 定义处理连接的函数
def handle_client_connection(client_socket):
    buffer = ""  # 定义一个字符串缓冲区
    try:
        while True:
            # 接收数据
            data = client_socket.recv(1024).decode('utf-8')
            if not data:
                break  # 没有数据，退出循环
            buffer += data  # 将接收到的数据添加到缓冲区
            while '\n' in buffer:  # 检查缓冲区中是否有换行符
                message, buffer = buffer.split('\n', 1)  # 分割缓冲区内容
                message = message.strip()
                if message:  # 如果message不为空
                    device_identifier = message[0]  # 获取标识符A、B或C
                    if device_identifier in ['A', 'B', 'C']:
                        file_path = f'/Users/nextop/Downloads/Localization/{device_identifier}.txt'
                        # 使用正则表达式去除所有字母，只保留数字和其他字符
                        filtered_message = re.sub(r'[A-Za-z]', '', message[1:])
                        with open(file_path, 'a') as file:
                            file.write(filtered_message + '\n')
                            file.flush()
    finally:
        client_socket.close()

# 主循环接受连接
while True:
    client_socket, client_address = server_socket.accept()
    print(f"Connected by {client_address}")
    client_thread = threading.Thread(target=handle_client_connection, args=(client_socket,))
    client_thread.start()
