%%%%%%%%%%%%%%%%%%%%%%%%%
%���Ӳ���������һ��ʵ��
%������
%%%%%%%%%%%%%%%%%%%%%%%
fid = fopen('data.txt');
if fid < 0
    display('open file failed.');
    break;
end
text = textscan(fid, '%n%s');
fclose(fid);
data_o = text{1,1}(:);%%���ݼ�¼�ļ��ĸ�ʽ��ȡ����һ�����ݡ�

datasize = data_o(1, 1);
data = data_o(2:size(data_o),1);

if datasize ~= size(data) %%�����������ݳ����������ĳ��Ȳ������
    display('size of data unmatch.');
    break;
end

display(data);

x_mean = mean(data); %ƽ��ֵ
display(['arithmetic mean :', num2str(x_mean)]);
    
k = 0;
for i=1:datasize
    k = k + power((data(i, 1) - x_mean),2); 
end
sigma = sqrt(k / (datasize - 1));
sigma = sigma / sqrt(datasize);
%%�������sigma

StandardDeviation = sqrt(k / datasize);
display(['Standard deviation :', num2str(StandardDeviation)]);
%%������

Gsigma = 2.56 * sigma; %%������˹׼�� ����n=20 p=0.95ʱ G=2.56.


for i=1:datasize
   if abs(data(i,1) - x_mean) < Gsigma
      data(i,2) = i; %%��ǳ���ֵ
   end
end

cnt = 1;
data_a = [20,1];
for i=1:datasize %%�ѱ�ǳ��Ļ�ֵ��ӡ������ ��Чֵ�򿽱���data_a��
    if data(i,2) ~= 0
        data_a(cnt,:) = data(i,:);
        cnt = cnt + 1;
    else
        display(['bad value found. NO.',num2str(i),' Value:',num2str(data(i,1))]);
    end
end

if cnt == datasize %%�������ȫ���Ǻ�ֵ
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


    