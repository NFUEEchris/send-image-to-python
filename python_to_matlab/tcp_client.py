# client
from http import client
import socket
import numpy as np
import cv2
import base64
file_location = "C:\\Users\\bblow\\AppData\\Local\\Programs\\Python\\Python310\\tcp"
img_name = "222.jpg"
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect(('192.168.11.5', 54378))
with open(file_location+"\\"+img_name, "rb") as img_file:
    data = base64.b64encode(img_file.read())
print(len(data))
sock.sendall(data)
