function test7
% �ڶ���--�����ɢԪ��ģ��
% ���Ǿ�Ⱥ�侺������
    % ����ÿ�־����������־��־�������������
    % ����������n/N
% ���־�˿--���港ֳ��
% ����dN/dt

clear,clc,close all
% Ԫ���Զ�����С
m = 500;
n = 500;
[E,I1,R,I2,I3] = deal(1,2,3,4,5);
% E : δ��Ⱦ : 1
% I1 : ����Ⱦ1 : 2
% I2 : ����Ⱦ2 : 4
% I3 : ����Ⱦ3 : 5
% R : ���ֽ� : 3
%% �����趨
rhoI1 = 0.0002; % ��ʼ��Ⱦ�ܶ�
p1 = 0.3; % ��Ⱦ����
T1 = 20;% ƽ���ֽ�ʱ��
rhoI2 = 0.0002; % ��ʼ��Ⱦ�ܶ�
p2 = 0.4; % ��Ⱦ����
T2 = 50;% ƽ���ֽ�ʱ��
rhoI3 = 0.0002; % ��ʼ��Ⱦ�ܶ�
p3 = 0.2; % ��Ⱦ����
T3 = 20;% ƽ���ֽ�ʱ��
P4 = 0.3; % ��Ҷ����
%% 
X = ones(m,n);
c1 = rhoI1*(1-rhoI2)*(1-rhoI3);
c2 = rhoI2*(1-rhoI1)*(1-rhoI3);
c3 = rhoI3*(1-rhoI2)*(1-rhoI1);
c4 = (1-rhoI1)*(1-rhoI2)*(1-rhoI3);
ifr = rand(m,n);
X(ifr<=c1/(c1+c2+c3+c4)) = I1;
X(ifr>c1/(c1+c2+c3+c4) & ifr<=(c1+c2)/(c1+c2+c3+c4)) = I2;
X(ifr>(c1+c2)/(c1+c2+c3+c4) & ifr<=(c1+c2+c3)/(c1+c2+c3+c4)) = I3;
XX = zeros(m+2,n+2);
XX(2:m+1,2:n+1) = X;
time1 = zeros(m,n); % ��ʱ�����ڼ���ֽ�ʱ��
time2 = zeros(m,n); % ��ʱ�����ڼ���ֽ�ʱ��
time3 = zeros(m,n); % ��ʱ�����ڼ���ֽ�ʱ��

% ÿ��Ԫ���ֽ�ʱ�������̬�ֲ�
Tmn1 = normrnd(T1,T1/2,m,n);
Tmn2 = normrnd(T2,T2/2,m,n);
Tmn3 = normrnd(T3,T3/2,m,n);
%% ͼ�λ�չʾ
figure('position',[50,50,1200,400])
subplot(1,2,1)
h1 = imagesc(X);
colormap(jet(5))
labels = {'δ��Ⱦ','����Ⱦ1','���ֽ�','����Ⱦ2','����Ⱦ3'};
lcolorbar(labels);

subplot(1,2,2)
h2 = plot(0,[0,0,0]);
% axis([0,200,0,m*n]);
legend('����Ⱦ1','����Ⱦ2','����Ⱦ3');

%% ѭ����ʼ
M = 1e3;
for t = 1 : M
    XX = zeros(m+2,n+2);
    XX(2:m+1,2:n+1) = X;
    Sd = XX;
    % �ھ��и�Ⱦ��Ԫ��
    N1=(Sd(1:n,2:n+1)==I1)+(Sd(3:n+2,2:n+1)==I1)+(Sd(2:n+1,1:n)==I1)+(Sd(2:n+1,3:n+2)==I1)+(Sd(1:n,1:n)==I1)+(Sd(3:n+2,1:n)==I1)+(Sd(1:n,3:n+2)==I1)+(Sd(3:n+2,3:n+2)==I1);  % �ھ�֮��
    N2=(Sd(1:n,2:n+1)==I2)+(Sd(3:n+2,2:n+1)==I2)+(Sd(2:n+1,1:n)==I2)+(Sd(2:n+1,3:n+2)==I2)+(Sd(1:n,1:n)==I2)+(Sd(3:n+2,1:n)==I2)+(Sd(1:n,3:n+2)==I2)+(Sd(3:n+2,3:n+2)==I2);  % �ھ�֮��
    N3=(Sd(1:n,2:n+1)==I3)+(Sd(3:n+2,2:n+1)==I3)+(Sd(2:n+1,1:n)==I3)+(Sd(2:n+1,3:n+2)==I3)+(Sd(1:n,1:n)==I3)+(Sd(3:n+2,1:n)==I3)+(Sd(1:n,3:n+2)==I3)+(Sd(3:n+2,3:n+2)==I3);  % �ھ�֮��
    % �ֱ��ҳ�״̬
    isR = (X == R);
    isE = (X == E);
    isI1 = (X == I1);
    isI2 = (X == I2);
    isI3 = (X == I3);
    % �Ա���Ⱦ�Ľ��м�ʱ
    time1(isI1) = time1(isI1) + 1;
    time2(isI2) = time2(isI2) + 1;
    time3(isI3) = time3(isI3) + 1;
    time1(~isI1) = 0;
    time2(~isI2) = 0;
    time3(~isI3) = 0;
    
    if t == 1
        [P1,P2,P3] = deal(p1,p2,p3);
    end
    %% �жϹ���
    % ����һ�����δ��Ⱦ���ھ���N��Ⱦ���ģ������Ը���N*P��ɱ���Ⱦ
    % ���ڶ���������Թ�һ����ĸ������ж�
    ifc = rand(m,n);% �趨�������ڹ�һ���жϸ���
    % ��Ⱦ1�ĸ���
    c1 = (N1*P1)./(N1*P1+N2*P2+N3*P3).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    % ��Ⱦ2�ĸ���
    c2 = (N2*P2)./(N1*P1+N2*P2+N3*P3).*(1-N1*P1./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    % ��Ⱦ3�ĸ���
    c3 = (N3*P3)./(N1*P1+N2*P2+N3*P3).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N1*P1./(N1*P1+N2*P2+N3*P3));
    % ����Ⱦ�ĸ���
    c4 = (1-N1*P1./(N1*P1+N2*P2+N3*P3)).*(1-N2*P2./(N1*P1+N2*P2+N3*P3)).*(1-N3*P3./(N1*P1+N2*P2+N3*P3));
    ifE_I1 = (ifc <= c1./(c1+c2+c3+c4));
    ifE_I2 = (ifc > c1./(c1+c2+c3+c4) & ifc <= c1+c2./(c1+c2+c3+c4));
    ifE_I3 = (ifc > c1+c2./(c1+c2+c3+c4) & ifc <= c1+c2+c3./(c1+c2+c3+c4));
    ifE_I4 = (ifc > c1+c2+c3./(c1+c2+c3+c4));
    Rule1 = I1 * (isE & ifE_I1) + I2 * (isE & ifE_I2) + I3 * (isE & ifE_I3) + E * (isE & ifE_I4);
    time1(isE & ifE_I1) = 0;
    time2(isE & ifE_I2) = 0;
    time3(isE & ifE_I3) = 0;
    
    % ��������������Ⱦ�ߵ���ֽ�ʱ�䣬��תΪ���ֽ�
    %1
    ifI1_R = time1 > Tmn1;
    Rule2_1 = R * (isI1 & ifI1_R) + I1 * (isI1 & ~ifI1_R);
    %2
    ifI2_R = time2 > Tmn2;
    Rule2_2 = R * (isI2 & ifI2_R) + I2 * (isI2 & ~ifI2_R);
    %3
    ifI3_R = time3 > Tmn3;
    Rule2_3 = R * (isI3 & ifI3_R) + I3 * (isI3 & ~ifI3_R);
    
    % ���������Ѿ����ֽ�ģ���һ������תΪδ��Ⱦ
    ifR_E = rand(m,n) < P4;
    Rule3 = E * (isR & ifR_E) + R * (isR & ~ifR_E);
    
    % ���ӹ���
    X = Rule1 + Rule2_1 + Rule2_2 + Rule2_3 + Rule3;
    
    % ������������
    NN = sum(isI1(:)) + sum(isI2(:)) + sum(isI3(:));
    P1 = (1-sum(isI2(:))/NN)*(1-sum(isI3(:))/NN)*p1;
    P2 = (1-sum(isI1(:))/NN)*(1-sum(isI3(:))/NN)*p2;
    P3 = (1-sum(isI1(:))/NN)*(1-sum(isI2(:))/NN)*p3;
    
    % ������״̬��Ԫ�������浽 Y��  
    Y(t,:) = sum([isR(:) isE(:) isI1(:) isI2(:) isI3(:)]);
    if t > 1
        YY(t,:) = Y(t,:) - Y(t-1,:);
    else
        YY(t,:) = Y(t,:);
    end
    figure(1)
    set(h1,'CData',X);
    for i = 3:5
        set(h2(i-2), 'XData', 1:t, 'YData', YY(1:t,i)); 
    end
    drawnow
end