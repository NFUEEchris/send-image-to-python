clc
clear

initialfile="C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp";   %initial file
myip='192.168.11.5';        %your local ip
tcpservo = tcpserver(myip, 54378);
counter=0;
totalstr={''};
while 1
    if tcpservo.NumBytesAvailable>0
        counter=counter+1;
        recv=read(tcpservo,65536,"char");
        strstore{counter}=recv;
        
        if length(recv)<65536
            for i=1:length(strstore)
                totalstr=append(totalstr,strstore{i});
            end

            fprintf("length:%d\n",strlength(string(totalstr)));
            counter=0;
            raw = matlab.net.base64decode(string(totalstr));
            fid = fopen("C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp\tcp_result.jpg",'wb');
            fwrite(fid,raw,'uint8');            
            fclose(fid);
            break;
        end
%         fprintf(string(recv));
%         encoder = org.apache.commons.codec.binary.Base64;
%         bytes = encoder.decode(uint8(recv'));
%         fopen('C:\\Users\\bblow\\AppData\\Local\\Programs\\Python\\Python310\\tcp\\aaaa.jpg','wb');
%         write(bytes);
%         fclose('C:\\Users\\bblow\\AppData\\Local\\Programs\\Python\\Python310\\tcp\\aaaa.jpg');
%         break;
    end
end
f=imread("C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp\tcp_result.jpg");
imshow(f);
