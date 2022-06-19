clc
clear

targetfile="C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp";   %target file
targetname="matlab_receive_result.jpg"; %output img name
myip='192.168.11.5';        %your local ip


tcpservo = tcpserver(myip, 54378);
counter=0;
totalstr={''};
while 1

    counter=counter+1;
    recv=read(tcpservo,65536,"char");
    strstore{counter}=recv;
    if isempty(recv)
        fprintf("fail..");
        break;
    end
    if length(recv)<65536
        for i=1:length(strstore)
            totalstr=append(totalstr,strstore{i});
        end
        fprintf("length:%d\n",strlength(string(totalstr)));
        
        counter=0;
        raw = matlab.net.base64decode(string(totalstr));
        fid = fopen(strcat(strcat(targetfile,"\"),targetname),'wb');
        fwrite(fid,raw,'uint8');            
        fclose(fid);
        break;
    end
end
delete(tcpservo)
f=imread(strcat(strcat(targetfile,"\"),targetname));
imshow(f);
