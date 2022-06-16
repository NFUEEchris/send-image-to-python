%client
clc
clear
initialfile="C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp";   %initial file
myip='192.168.11.5';        %your local ip
a= dir(strcat(initialfile,"\*.jpg")); %find jpg in file

menumat=cell(1,length(a));
for i=1:length(a)
    menumat(1,i)=cellstr(a(i).name);     %sort filename put into menu
end

m=menu("select img",menumat);      %show menu
menutoutput=string(menumat(1,m));   
pictureinput=strcat(strcat(initialfile,"\"),menutoutput);    %convert select to filename
tcpclient = tcpclient(myip, 54378);

a=imread(pictureinput);      
% j=imresize(a,0.5);
                                    %process img

imwrite(a, 'result.jpg')     
fid = fopen("C:\Users\bblow\AppData\Local\Programs\Python\Python310\tcp\result.jpg",'rb');
bytes = fread(fid);
fclose(fid);
encoder = org.apache.commons.codec.binary.Base64;    
layer1 = char(encoder.encode(bytes))';          %encode img to base64
write(tcpclient,layer1);   %send message
