clc
clear
initialfile="C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp";   %initial file
myip='192.168.11.5';        %your local ip
tcpclient = tcpclient(myip, 54378);

fid = fopen("C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp\222.jpg",'rb');
bytes = fread(fid);
fclose(fid);
encoder = org.apache.commons.codec.binary.Base64;
base64string = char(encoder.encode(bytes))';
write(tcpclient,base64string);