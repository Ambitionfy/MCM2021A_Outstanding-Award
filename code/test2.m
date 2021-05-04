function test2
% �����ɢԪ��ģ��
% ľ����ά
clear,clc,close all
% Ԫ���Զ�����С
m = 500;
n = 500;
[E,I,R] = deal(1,2,3);
% E : δ��Ⱦ : 1
% I : ����Ⱦ : 2
% R : ���ֽ� : 3
%% �����趨
rhoI = 0.1; % ��ʼ��Ⱦ�ܶ�
P1 = 0.6; % ��Ⱦ����
T = 100;% ƽ���ֽ�ʱ��
%% 
X = ones(m,n);
X(rand(m,n)<rhoI) = I;
time = zeros(m,n); % ��ʱ�����ڼ���ֽ�ʱ��
% �ھӷ�λ
d = {[1,0],[0,1],[-1,0],[0,-1]};
% ÿ��Ԫ���ֽ�ʱ�������̬�ֲ�
Tmn = normrnd(T,T/2,m,n);

%% ͼ�λ�չʾ
figure('position',[50,50,1200,400])
subplot(1,2,1)
h1 = imagesc(X);
colormap(jet(3))
labels = {'δ��Ⱦ','����Ⱦ','���ֽ�'};
lcolorbar(labels);

subplot(1,2,2)
h2 = plot(0,[0,0,0]);
axis([0,200,0,m*n]);
legend('δ��Ⱦ','����Ⱦ','���ֽ�');

%% ѭ����ʼ
M = 200;
for t = 1 : M
    % �ھ��и�Ⱦ��Ԫ��
    N = zeros(size(X));
    for j = 1 : length(d)
        N = N + circshift(X,d{j}) == I; 
    end
    % �ֱ��ҳ�����״̬
    isR = (X == R);
    isE = (X == E);
    isI = (X == I);
     % ������״̬��Ԫ�������浽 Y��  
    Y(t,:) = sum([isE(:) isI(:) isR(:)]);
    % �Ա���Ⱦ�Ľ��м�ʱ
    time(isI) = time(isI) + 1;
    %% �жϹ���
    % ����һ�����δ��Ⱦ���ھ���N��Ⱦ���ģ������Ը���N*P��ɱ���Ⱦ
    ifE_I = rand(m,n) < (N*P1);
    Rule1 = I * (isE & ifE_I) + E * (isE & ~ifE_I);
    time(isE & ifE_I) = 0;
    % ��������������Ⱦ�ߵ���ֽ�ʱ�䣬��תΪ���ֽ�
    ifI_R = time > Tmn;
    Rule2 = R * (isI & ifI_R) + I * (isI & ~ifI_R);
    % ���������Ѿ����ֽ�ģ����ַֽ�
    Rule3 = R * isR;
%     time(time > Tmn) = 0;
    % ���ӹ���
    X = Rule1 + Rule2 + Rule3;
    figure(1)
    set(h1,'CData',X);
    for i = 1:3
        set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); 
    end
    drawnow
end