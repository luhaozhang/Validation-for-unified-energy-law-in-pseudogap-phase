

%I. Aim PlatauPre
clf
clear
clc

%A.parameters
%1.Constant
ee=1.6*10^(-19);
kb=1.38*10^(-23);
hbar=1.05*10^(-34);        % plank constant
me=9.11*10^(-31);
mu0=4*pi*10^(-7);
%2.data

%II. PreRhoAF and RAF
RQ=2*pi*hbar/(4*ee^2)
gammaAF=0.11;
RSperCarrier=RQ*gammaAF; %每个载流子的电阻

%A.数据转换，电阻率到层状电阻
rhoPlateau=60*10^(-8);
c0=12.2*10^(-10);
K=2;
RSEXP=(rhoPlateau*K/c0)/(RQ/4);
%B.电阻率和层状电阻预测
gammaAF=0.11;
% p=[1;2;3;4;5;6;];
% K=[2;2;2;4;4;4;];
% c0=[24.6;11.6;13.1;13;13;12.9;]*10^(-10);
% rhoAF_PreM=(gammaAF.*(c0./(p(:,1).*K))*(RQ/4))*10^8;
% rhoAF_PreE=rhoAF_PreM.*p(:,2)./p(:,1);
% rhoAF_Pre=[rhoAF_PreM rhoAF_PreE]
% RPlateauPreM=gammaAF./p(:,1);
% RPlateauPreE=gammaAF.*p(:,2)./p(:,1);


%III. DataPlot

subplot(1,2,1)
hold on

% load Bi2212_Rho_Mandrus1991_0065
% Data=Bi2212_Rho_Mandrus1991_0065;
% % load Bi2212_Rho_Mandrus1991_005
% % Data=Bi2212_Rho_Mandrus1991_005;
% plot(Data(:,1),Data(:,2),'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);

% return
load Data1_Bi2201_Rho_Ono2000_x084_p010
Data=Bi2201_Rho_Ono2000_x084_p010;
plot(Data(:,1),Data(:,2),'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1);

load Data2_YBCO_Rho_Ando2004_y64_p068
Data=YBCO_Rho_Ando2004_y64_p068;
plot(Data(:,1),Data(:,2),'gs','MarkerFaceColor','g','MarkerSize',6,'LineWidth',1);

load Data3_NCCO_Rho_Armitage2010_p014
Data=NCCO_Rho_Armitage2010_p014;
plot(Data(:,1),Data(:,2),'y*','MarkerFaceColor','y','MarkerSize',6,'LineWidth',1);

load Data4_BaFeAsP_Rho_Kasahara2010_x27_p024pm003
Data=BaFeAsP_Rho_Kasahara2010_x27_p024pm003;
plot(Data(:,1),Data(:,2),'r>','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);

T=0:0.01:400;
rhoPlateauA=[872 0; 534 20; 518 0; 122 0; 110 12; 86 2;];
plot(T,rhoPlateauA(1,1)*T./T,'k--','LineWidth',1);
plot(T,rhoPlateauA(2,1)*T./T,'k--','LineWidth',1);
plot(T,252*T./T,'k--','LineWidth',1);
plot(T,rhoPlateauA(4,1)*T./T,'k--','LineWidth',1);

xlabel('$T$({\rm K})','interpreter','latex','fontsize',16)
ylabel('$\rho$(${\rm \mu\Omega}$cm)','interpreter','latex','fontsize',16)
set(gca,'FontSize',16)
box on
L1=legend('Bi-2201','YBCO','NCCO','BaFeAsP','$\rho_{P}$','location','northwest');
set(L1,'FontSize',12,'interpreter','latex')

legend('boxoff')
axis([0  300 0 2000])
set(gca,'yscale','linear')
%text(300*0.08,2000*0.9,'(a)','FontSize',16)


subplot(1,2,2)
hold on

load Data5_RsExp_Error
p=RsExpDopingRsError(:,1);
RPlateauM=RsExpDopingRsError(:,2);
RPlateauE=RsExpDopingRsError(:,3);
yneg = RPlateauE(1:3);
ypos = RPlateauE(1:3);
xneg = [0.008 0 0];
xpos = [0.008 0 0];
l1(1)=errorbar(p(1:3), RPlateauM(1:3),yneg,ypos,xneg,xpos,'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);
l1(2)=errorbar(p(4:6), RPlateauM(4:6), RPlateauE(4:6),'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1);
l1(3)=errorbar(p(7), RPlateauM(7), RPlateauE(7),'gs','MarkerFaceColor','g','MarkerSize',6,'LineWidth',1);
l1(4)=errorbar(p(8),  RPlateauM(8), RPlateauE(8),'md','MarkerFaceColor','m','MarkerSize',6,'LineWidth',1);
l1(5)=errorbar(p(9), RPlateauM(9), RPlateauE(9),'cp','MarkerFaceColor','c','MarkerSize',6,'LineWidth',1);
l1(6)=errorbar(p(10), RPlateauM(10), RPlateauE(10),'y*','MarkerFaceColor','y','MarkerSize',6,'LineWidth',1);
l2(1)=errorbar(p(11),  RPlateauM(11), RPlateauE(11),RPlateauE(11),0.03,0.03,'r>','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);
l2(2)=errorbar(p(12), RPlateauM(12), RPlateauE(12),RPlateauE(12),0.03,0.03,'k<','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1);
l2(3)=errorbar(p(13), RPlateauM(13), RPlateauE(13),'bh','MarkerFaceColor','b','MarkerSize',6,'LineWidth',1);


t=0:0.001:1000;
y=gammaAF./t;
l2(4)=plot(t,y,'b-','LineWidth',1.5);


t=0:0.001:1000;
y=1.*t./t;
l2(5)=plot(t,y,'k--','LineWidth',1);
l2(6)=plot(t,4.*y,'k-.','LineWidth',1);
text(0.3*0.85,5*0.9,'(b)','FontSize',16)
axis([0  0.3 0 5])
xlabel('$p_{\rm c}$','interpreter','latex','fontsize',16)
ylabel('$\rho_{\rm P}K/c_0$($h/4e^2$)','interpreter','latex','fontsize',16)
set(gca,'FontSize',16)
box on
L1=legend(l1(1:6),'Bi-2212','Bi-2201','YBCO','LSCO','LNSCO','LESCO');
set(L1,'FontSize',12,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
L2=legend(ah,l2(1:6),'BaFeAsP','BaFeCoAs','BaFeRuAs','Eq.(6)','Bosonic SIT', 'Fermionic SIT');
set(L2,'FontSize',12,'interpreter','latex')
legend('boxoff')
set(gca,'yscale','linear')


