%%%%%%%%%%%%%%%%%%%%%%%%%
%电子测量技术第一次实验
%梁家祥
%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('data.txt');
if fid < 0
    display('open file failed.');
    break;
end
text = textscan(fid, '%n%s');
fclose(fid);
data_o = text{1,1}(:);%%根据记录文件的格式提取出第一列数据。

datasize = data_o(1, 1);
data = data_o(2:size(data_o),1);

if datasize ~= size(data) %%如果读入的数据长度与声明的长度不相符。
    display('size of data unmatch.');
    break;
end

display(data);

x_mean = mean(data); %平均值
display(['arithmetic mean :', num2str(x_mean)]);
    
k = 0;
for i=1:datasize
    k = k + power((data(i, 1) - x_mean),2); 
end
sigma = sqrt(k / (datasize - 1));
sigma = sigma / sqrt(datasize);
%%求均方差sigma

StandardDeviation = sqrt(k / datasize);
display(['Standard deviation :', num2str(StandardDeviation)]);
%%均方差

Gsigma = 2.56 * sigma; %%格拉布斯准测 查表得n=20 p=0.95时 G=2.56.


for i=1:datasize
   if abs(data(i,1) - x_mean) < Gsigma
      data(i,2) = i; %%标记出好值
   end
end

cnt = 1;
data_a = [20,1];
for i=1:datasize %%把标记出的坏值打印出来。 有效值则拷贝到data_a。
    if data(i,2) ~= 0
        data_a(cnt,:) = data(i,:);
        cnt = cnt + 1;
    else
        display(['bad value found. NO.',num2str(i),' Value:',num2str(data(i,1))]);
    end
end

if cnt == datasize %%如果数据全部是好值
    display('No bad value.');
end

datasize_a = size(data_a);

if rem(datasize_a,2) == 0
    delta = sum(data_a(1:datasize_a/2,1)) - sum(data_a(datasize_a/2:datasize_a,1));
else 
    delta = sum(data_a(1:(datasize_a+1)/2,1)) - sum(data_a((datasize_a+1)/2:datasize_a,1));
end
display(['Marley Kopf criterion delta:', num2str(delta)]);
hold on;
plot(data_a(:,2),data_a(:,1));
x = 1:datasize;
scatter(x,data(:,1));
hold off;


    