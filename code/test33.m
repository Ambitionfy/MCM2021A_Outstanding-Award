function test33
% ����ù
% �����ɢԪ��ģ��
% ���־�˿--���港ֳ��
clear,clc,close all
% Ԫ���Զ�����С
m = 500;
n = 500;
[S,E,I,R] = deal(0,1,2,3);
TT = [24.4 26.12 26.63 26.07 28.72];
HH = [29.65 39.63 56.99 69.45 88.69]/100;
for iii = 1 : 5
% S : �յ�   : 0
% E : δ��Ⱦ : 1
% I : ����Ⱦ : 2
% R : ���ֽ� : 3
%% �����趨
T_real = TT(iii);
H_real = HH(iii);
% T_real = 29.4;
% H_real = 0.4665;
Vemax = 8.6;   % ��Ҫ����
% T = 24; % �����¶�
% H = 0.92;
% T = 24.2; % �����¶�
% H = 0.90;
T = 32; % �����¶�
H = 0.8;
if T >= T_real
    Ve = Vemax.*exp(-Vemax/(H_real.*T_real));
else
	Ve = Vemax.*exp(-Vemax/(H_real.*(2*T-T_real)));
end
M = 2*H-1;
% M = 0.7;
Vd = T_real*Ve.^0.5+31.90*1.26.^M-64.80*ones(size(Ve));
P1 = 1/(1+exp(-1/Ve))/10;
% if iii == 1
%     P1 = 1/(1+exp(-1/Ve))/50;
% end

rhoI = 0.06; % ��ʼ��Ⱦ�ܶ�
% P1 = 0.2; % ��Ⱦ����
% T = 30;% ƽ���ֽ�ʱ��
T = Vd;
P2 = 0.1; % ��Ҷ����
%% 
X = ones(m,n);
X(rand(m,n)<rhoI) = I;
time = zeros(m,n); % ��ʱ�����ڼ���ֽ�ʱ��
% �ھӷ�λ
d = {[1,0],[0,1],[-1,0],[0,-1]};
% ÿ��Ԫ���ֽ�ʱ�������̬�ֲ�
Tmn = normrnd(T,T/2,m,n);

%% ͼ�λ�չʾ
% h2 = plot(0,[0],'linewidth',1);
% % axis([0,200,0,m*n]);
% legend('����Ⱦ');

%% ѭ����ʼ
M = 1e3;
NR = 0;
for t = 1 : M
    % �ھ��и�Ⱦ��Ԫ��
    N = zeros(size(X));
    for j = 1 : length(d)
        N = N + circshift(X,d{j}) == I; 
    end
    % �ֱ��ҳ�����״̬
    isS = (X == R);
    isE = (X == E);
    isI = (X == I);
    % �Ա���Ⱦ�Ľ��м�ʱ
    time(isI) = time(isI) + 1;
    time(isE) = 0;
    time(isS) = 0;
    %% �жϹ���
    % ����һ�����δ��Ⱦ���ھ���N��Ⱦ���ģ������Ը���N*P��ɱ���Ⱦ
    ifE_I = rand(m,n) < (N*P1);
    Rule1 = I * (isE & ifE_I) + E * (isE & ~ifE_I);
    time(isE & ifE_I) = 0;
    % ��������������Ⱦ�ߵ���ֽ�ʱ�䣬��תΪ���ֽ�
    ifI_R = time > Tmn;
    Rule2 = R * (isI & ifI_R) + I * (isI & ~ifI_R);
    temp = (isI & ifI_R);
    NR = NR + sum(temp(:));
    % ���������Ѿ����ֽ�ģ���һ������תΪδ��Ⱦ
    ifS_E = rand(m,n) < P2;
    Rule3 = E * (isS & ifS_E) + R * (isS & ~ifS_E);

    % ���ӹ���
    X = Rule1 + Rule2 + Rule3;
    
    % ������״̬��Ԫ�������浽 Y��  

    Y(t,iii) = sum(isI(:));
%     for i = 1:1
%         set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); 
%     end
    if t == 100
       break; 
    end
%     drawnow
end
end
plot(Y,'linewidth',2)
% title('Trichoderma')
title('Aspergillus')
xlabel('Day')
% axis([0,100,0,82000])
legend('Arid area','Semi arid area','Temperate zone','Arboreal area','Tropical rain forest')
