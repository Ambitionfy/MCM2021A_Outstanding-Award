function test16
% ����
% �����ʻ�ͼ
% ��һ��--�����ɢԪ��ģ��
% �����Ǿ�Ⱥ�侺������
% ���־�˿--���港ֳ��
clear,clc,close all
% Ԫ���Զ�����С
m = 450;
n = 450;
[E,I1,I2,I3,R] = deal(1,2,3,4,5);
% E : δ��Ⱦ : 1
% I1 : ����Ⱦ1 : 2
% I2 : ����Ⱦ2 : 3
% I3 : ����Ⱦ3 : 4
% R : ���ֽ� : 5
%% �����趨
% ��������
% T_real = 25.72;
% H_real = 0.8869;
% T_real = 26.22;
% H_real = 0.9169;
% T_real = 25.12;
T_real1 = 28.4;
H_real1 = 0.6945;
% ������������
T = [28 27 26];
H = [0.6 0.67 0.6];
% ��ͬ��Ⱥ��ɢ���ʼ���
Vemax = [6.5 7.6 6.1];   % ��Ҫ����
% Ve = Vemax.*exp(-Vemax/(H_real.*T_real));
Ve = zeros(size(T));
idx1 = T >= T_real1;
idx2 = T < T_real1;
Ve(idx1) = Vemax(idx1).*exp(-Vemax(idx1)/(T_real1*H_real1));
Ve(idx2) = Vemax(idx2).*exp(-Vemax(idx2)./((2*T(idx2)-T_real1)*H_real1));
% Ve(T>=T_real) = Vemax(T>=T_real).*exp(-Vemax(T>=T_real)/(H_real.*T_real));
% Ve(T<T_real & T>=0.5*T_real) = Vemax(T<T_real & T>=0.5*T_real).*exp(-Vemax(T<T_real & T>=0.5*T_real)./((2*T(T<T_real & T>=0.5*T_real)-T_real).*H_real));

% ��ͬ��Ⱥ�ֽ����ʼ���
M = [0.42 0.5 0.57];        % ��Ҫ����
M(2) = H(1)/H(2)*M(1);
M(3) = H(1)/H(3)*M(1);
Vd = T_real1*Ve.^0.5+31.90*1.26.^M-64.80*ones(size(Ve));

% �涨��һ�ֵĲ���
rhoI1 = 0.3; % ��ʼ��Ⱦ�ܶ�
p1 = 0.05; % ��Ⱦ����
T1 = 32;% ƽ���ֽ�ʱ��
% ������ɢ���ʼ����Ⱦ����
p2 = Ve(2)/Ve(1)*p1;
p3 = Ve(3)/Ve(1)*p1;
% ������ɢ���ʼ����ʼ��Ⱦ�ܶ�
rhoI2 = Ve(2)/Ve(1)*rhoI1;
rhoI3 = Ve(3)/Ve(1)*rhoI1;
% ���ݷֽ����ʼ���ֽ�ʱ��
T2 = Vd(1)/Vd(2)*T1;
T3 = Vd(1)/Vd(3)*T1;
% T2 = 22.3;
% T3 = 19.9;
% rhoI2 = 0.2; % ��ʼ��Ⱦ�ܶ�
% P2 = 0.06; % ��Ⱦ����
% T2 = 80;% ƽ���ֽ�ʱ��
% rhoI3 = 0.2; % ��ʼ��Ⱦ�ܶ�
% P3 = 0.05; % ��Ⱦ����
% T3 = 60;% ƽ���ֽ�ʱ��
P4 = 0.1; % ��Ҷ����
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
figure(1)
h2 = plot(0,[0,0,0],'linewidth',2);
xlabel('Day')
title('Arboreal area')
axis([0,100,-inf,inf]);
legend('Trichoderma infection','Fusarium infection','Gibberella infection');
set(gca, 'FontName', 'Times New Roman');

% figure(2)
% h3 = plot(0,[0,0,0],'linewidth',1);
% xlabel('Day')
% title('T = 26.22��C,  H = 91.69%')
% axis([0,60,-5000,40000]);
% legend('Trichoderma infection','Penicillium infection','Aspergillus flavus infection');
% set(gca, 'FontName', 'Times New Roman');
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
    Y(t,:) = sum([isI1(:) isI2(:) isI3(:)]);
    for i = 1:3
        set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); 
    end
    drawnow
    if t== 100
        break; 
    end
%     if t > 1
%         YY(t,:) = Y(t,:) - Y(t-1,:);
%     else
%         YY(t,:) = Y(t,:);
%     end
%     for i = 1:3
%         set(h3(i), 'XData', 1:t, 'YData', YY(1:t,i)); 
%     end
end