%I.Aim prediction of rho0 

%II. Formula


%III.program
%clf
clc
clear
subplot(1,2,2)
text(0.05+0.2*(0.7/10),500*(5.5/6),'(b)','FontSize',16)

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
a0=3.89*10^(-10);  % a axis lattice constant of Hg2201
b0=3.88*10^(-10);  % b axis lattice constant of Hg2201
c0=0.955*10^(-9);
layer=1;
sigmaquan=(ee^2/(2*pi*hbar*(c0)));

%3. Fit QCO
load Data3_QCDWTabis2017  % Tabis2017 Campi2015
pCO=QCDWdata(:,1);
QCO=QCDWdata(:,2); 
hold on
myfunc = @(beta,x)(beta(1)*x+beta(2));
beta0 = [1,1];
beta = nlinfit(pCO,QCO,myfunc,beta0);
x1=0:0.001:0.3;
y1=myfunc(beta,x1);
pCDWBi2212B=[0.0607833;0.0812321;0.101336;0.141197;0.170508;];             %2014scienceFujita         
QCDWBi2212B=[0.308598;0.270919;0.254584;0.242965;0.225771;];


%predictions
mstar=2.45;
gamma=(0.11/2.5);
GapPre=((1000/ee)*gamma.*hbar^2.*(y1*2*pi/a0).^2/(mstar*me)).*(1.6*10^(-22))/kb;
L3(2)=plot(x1,GapPre,'b-','MarkerSize',8,'LineWidth',1.5);
gamma=(0.11/2.5).*(1-(x1/0.25).^10);
GapPre=((1000/ee)*gamma.*hbar^2.*(y1*2*pi/a0).^2/(mstar*me)).*(1.6*10^(-22))/kb;
L3(3)=plot(x1,GapPre,'b--','MarkerSize',8,'LineWidth',1.5);

hold on
load Data5_Bi2212Tstar
L1(1)=errorbar(Bi2212Tstar(:,1),Bi2212Tstar(:,2),Bi2212Tstar(:,3),'ro','MarkerFaceColor','r','MarkerSize',8,'LineWidth',1);
L1(2)=errorbar(Bi2212Tstar(:,4),Bi2212Tstar(:,5),Bi2212Tstar(:,6),'g^','MarkerFaceColor','g','MarkerSize',8,'LineWidth',1);
L1(3)=errorbar(Bi2212Tstar(:,7),Bi2212Tstar(:,8),Bi2212Tstar(:,9),'cs','MarkerFaceColor','c','MarkerSize',8,'LineWidth',1);
load Data4_Hg2201Tstar
L3(1)=errorbar(Hg2201Tstar(:,1),Hg2201Tstar(:,2),Hg2201Tstar(:,3),'kd','MarkerFaceColor','k','MarkerSize',8,'LineWidth',1);

xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('$ T^*(\rm K)$','interpreter','latex','fontsize',16)
set(gca,'FontSize',16)
axis([0.05 0.25 0 500])
box on

LA=legend(L1(1:3),'Bi-2212 (Tunnel) ','Bi-2212 (Raman)','Bi-2212 (ARPES)');
set(LA,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LB=legend(ah,L3(1),'Hg-1201 (Neutron, Raman) ','Eq. (5), $\gamma_{T}=0.11/2.5$','Eq. (5), $\gamma_{T}={0.11\over2.5}[1-(p/0.25)^10](\gamma_{\Delta}/2.3)$ ');
set(LB,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LC=legend(ah,L3(2:3),'Eq. (4), $\gamma_{T}=0.11/2.5$','Eq. (4), $\gamma_{T}={0.11\over2.5}[1-({p\over 0.25})^{10}]$ ','Location','southwest');
set(LC,'FontSize',14,'interpreter','latex')
legend('boxoff')







