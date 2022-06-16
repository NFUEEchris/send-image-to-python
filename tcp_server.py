# server
import base64
from ast import List
from base64 import decode
from codecs import utf_8_decode
from encodings import utf_8
from itertools import count
import socket
import time
from typing import Counter
import numpy as np
import cv2
# IPV4,TCP
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

sock.bind(('192.168.11.5', 54378))  # bind(host,port)

sock.listen(1)
ans = 1
counter = 0
strstore = ["", "", "", "", "", ""]
while 1:

    if ans == 2:
        print("break in")
        break
    connection, address = sock.accept()  # return con,addr
    print("client ip is:", address)

    while 1:

        counter = counter+1
        buf = connection.recv(65536)
        recvstring = buf.decode('utf-8')
        strstore[counter-1] = recvstring

        if len(buf) == 0:
            connection.close()
            print("connect fail...")

        """ elif len(recvstring) > 0:
            print("in1")  # testing point
            img_array = np.frombuffer(image_64_decode, np.uint8)
            img = cv2.imdecode(img_array, cv2.IMREAD_COLOR)
            img = cv2.resize(img, dsize=None, fx=2, fy=2,
                            interpolation=cv2.INTER_AREA)
            cv2.imshow("img", img)

            cv2.waitKey(0) """

        if len(recvstring) < 65536:
            print("in2")  # testing point

            image_64_decode = base64.b64decode(
                strstore[0]+strstore[1]+strstore[2]+strstore[3]+strstore[4]+strstore[5])
            with open('C:\\Users\\bblow\\AppData\\Local\\Programs\\Python\\Python310\\tcp\\aaaa.jpg', 'wb') as fh:
                fh.write(image_64_decode)

            """ img = cv2.imread('aaaa.jpg')
            img = cv2.resize(img, (1920, 1080))
            cv2.imwrite('aaaa.jpg', img) """

            print("sucessful...")
            counter = 0
            ans = input("1.keep recv\t2.dont recv:")
            ans = int(ans)

        if ans == 2:
            print("break in 2")
            break
sock.close()
