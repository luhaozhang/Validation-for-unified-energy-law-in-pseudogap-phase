 %I.Aim prediction of rho0 

%II. Formula

%III.program
clf
clc
clear

%A. Parameters
%1. constant 
kb=1.38*10^(-23);       % Boltzman constant
me=9.1*10^(-31);        % electron mass 
ee=1.6*10^(-19);
phi0=2.07*10^(-15);     % flux quanta 
mu0=4*pi*10^(-7);       % permeability of vacuum 
hbar=1.05*10^(-34);        % plank constant
c=3*10^8;               % light velocity  

%2. Data
a0=5.36*10^(-10);  % a axis lattice constant of Bi2201
b0=5.37*10^(-10);  % b axis lattice constant of Bi2201
c0=2.46*10^(-9);   %几乎是上限，总体变化不大，在0.06的量级

%3. Fit QCO
load('Data1_QoloBLSCOCai2016Comin2014Peng2018')
pCO=QoloBLSCOCai2016Comin2014Peng2018(:,1);
QCO=QoloBLSCOCai2016Comin2014Peng2018(:,2); 
ER=QoloBLSCOCai2016Comin2014Peng2018(:,3); 
%QCDW fit data and commensuration
myfunc = @(beta,x)(beta(1)*(1-(x/beta(2)).^beta(3)));
beta=[ 0.2692    0.2605    3.7937];  %QCDWFit-Pb-Bi2201 to 0.23
x1=transpose(0:0.001:0.3);
y1=myfunc(beta,x1);

%predictions
subplot(1,2,1)
text(0.05+0.2*(0.7/10),500*(5.5/6),'(a)','FontSize',16)
hold on
mstar=2.7;
gamma=(0.11/3)
GapPre=2*(gamma.*hbar^2.*(y1*2*pi/a0).^2/(mstar*me))/kb;
L2(1)=plot(x1,GapPre,'b-','MarkerSize',8,'LineWidth',1.5);
gamma=(0.11/3).*(1-(x1/0.23).^10);
GapPre=2*(gamma.*hbar^2.*(y1*2*pi/a0).^2/(mstar*me))/kb;
L2(2)=plot(x1,GapPre,'b--','MarkerSize',8,'LineWidth',1.5);

load Data2_Bi2201Tstar
L1(1)=plot(Bi2201Tstar(:,1),Bi2201Tstar(:,2),'ro','MarkerFaceColor','r','MarkerSize',8,'LineWidth',1);
L1(2)=plot(Bi2201Tstar(:,3),Bi2201Tstar(:,4),'k^','MarkerFaceColor','k','MarkerSize',8,'LineWidth',1);
L1(3)=plot(Bi2201Tstar(:,5),Bi2201Tstar(:,6),'gs','MarkerFaceColor','g','MarkerSize',8,'LineWidth',1);

xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('$ T^*(\rm K)$','interpreter','latex','fontsize',16)
set(gca,'FontSize',16)
axis([0.05 0.25 0 500])
box on

LA=legend(L1(1:3),'Bi-2201 (ARPES) ','Bi-2201 ($\rho$)','Bi-2201 (NMR)','Location','northeast');
set(LA,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LB=legend(ah,L2(1:2),'Eq. (4), $\gamma_{T}=0.11/3$','Eq. (4), $\gamma_{T}={0.11\over3}[1-({p\over 0.23})^{10}]$ ','Location','southwest');
set(LB,'FontSize',14,'interpreter','latex')
legend('boxoff')
return







