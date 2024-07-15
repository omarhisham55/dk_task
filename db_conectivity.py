import socket

host = 'localhost'
port = 5432

try:
    socket.create_connection((host, port))
    print('Connection successful')
except Exception as e:
    print(f'Connection failed: {e}')
    
