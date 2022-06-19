# server
import base64
from ast import List
from base64 import decode
from codecs import utf_8_decode
from encodings import utf_8
from itertools import count
import socket
import time
import numpy as np
import cv2

targetfile = 'C:\\Users\\bblow\\AppData\\Local\\Programs\\Python\\Python310\\tcp'
targetname = 'python_receive_result.jpg'

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

sock.bind(('192.168.11.5', 54378))  # bind(host,port)
sock.listen(1)
ans = 1
strstore = []
totalstr = ""
while 1:

    if ans == 2:
        print("break in")
        break
    print("waiting for sendmessage...")
    connection, address = sock.accept()  # return con,addr
    print("client ip is:", address)

    while 1:

        buf = connection.recv(65536)
        recvstring = buf.decode('utf-8')
        strstore.append(recvstring)

        if len(buf) == 0:
            connection.close()
            print("connect fail...")

        if len(recvstring) < 65536:
            print("in2")  # testing point
            for i in range(len(strstore)):
                totalstr = totalstr+strstore[i]
            image_64_decode = base64.b64decode(totalstr)

            with open(targetfile+'\\'+targetname, 'wb') as fh:
                fh.write(image_64_decode)

            print("send sucessful...")
            strstore = [""]
            ans = input("1.keep recv\t2.dont recv:")
            ans = int(ans)
            break
sock.close()
