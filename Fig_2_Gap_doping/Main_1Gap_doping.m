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
hbar=1.05*10^(-34);     % plank constant
c=3*10^8;               % light velocity  
%1000cm^-1 wavenumber to 0.1237eV
Invcm2eV=2*pi*hbar*c*10^2/ee;

%2. Data
a0=3.89*10^(-10);  % a axis lattice constant of Hg2201
b0=3.88*10^(-10);  % b axis lattice constant of Hg2201
c0=0.955*10^(-9);
layer=1;
sigmaquan=(ee^2/(2*pi*hbar*(c0)));

%3. Fit QCO
load Data1_QCDWTabis2017  % Tabis2017 Campi2015
pCO=QCDWdata(:,1);
QCO=QCDWdata(:,2); 
hold on
myfunc = @(beta,x)(beta(1)*x+beta(2));
beta0 = [1,1];
beta = nlinfit(pCO,QCO,myfunc,beta0);
x1=0:0.0001:0.3;
y1=myfunc(beta,x1);
pCDWBi2212B=[0.0607833;0.0812321;0.101336;0.141197;0.170508;];             %2014scienceFujita         
QCDWBi2212B=[0.308598;0.270919;0.254584;0.242965;0.225771;];

hold on
mstar=2.7;
gamma=0.11;
GapPre=(1000/ee)*gamma*hbar^2*(y1*2*pi/a0).^2/(mstar*me);
L1(4)=plot(x1,GapPre,'b-','MarkerSize',6,'LineWidth',1.5);
gamma=0.11.*(1-(x1/0.25).^10);
GapPre=((1000/ee)*gamma.*hbar^2.*(y1*2*pi/a0).^2/(mstar*me));
L1(5)=plot(x1,GapPre,'b--','MarkerSize',6,'LineWidth',1.5);
GapPre=(1000/ee)*0.11*hbar^2*(0.25*2*pi/a0).^2/(2.45*me);

%Bi-2212Data
load Data2_Bi2212GapData
L1(1)=errorbar(D_PG(:,1),(1/2)*D_PG(:,2)*Invcm2eV*500,(1/2)*D_PG(:,3)*Invcm2eV*500,'ro','MarkerSize',6,'LineWidth',1);
L1(2)=errorbar(D_CDW(:,1),D_CDW(:,2)*Invcm2eV*500,D_CDW(:,3)*Invcm2eV*500,'gs','MarkerSize',6,'LineWidth',1);
L1(3)=errorbar(D_ANSC(:,1),1.3*D_ANSC(:,2)*Invcm2eV*500,1.3*D_ANSC(:,3)*Invcm2eV*500,'k^','MarkerSize',6,'LineWidth',1);

load Data3_Hg2201GapData
L2(1)=errorbar(D_PG(:,1),(1/2)*D_PG(:,2)*Invcm2eV*500,(1/2)*D_PG(:,3)*Invcm2eV*500,'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);
L2(2)=errorbar(D_CDW(:,1),D_CDW(:,2)*Invcm2eV*500,D_CDW(:,3)*Invcm2eV*500,'gs','MarkerFaceColor','g','MarkerSize',6,'LineWidth',1);
L2(3)=errorbar(D_ANSC(:,1),1.3*D_ANSC(:,2)*Invcm2eV*500,1.3*D_ANSC(:,3)*Invcm2eV*500,'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1);

load Data4_Bi2212Dstar
L3(1)=plot(Dstar1999PRLhump(:,1),Dstar1999PRLhump(:,2)/3.5,'c^','MarkerFaceColor','c','MarkerSize',6,'LineWidth',1);
L3(2)=plot(Dstar1999PRLpeak(:,1),Dstar1999PRLpeak(:,2),'mp','MarkerFaceColor','m','MarkerSize',6,'LineWidth',1);
L3(3)=errorbar(Dstar2016PRB(:,1),Dstar2016PRB(:,2),Dstar2016PRB(:,3),'yd','MarkerFaceColor','y','MarkerSize',6,'LineWidth',1);

xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('$\Delta(\rm meV)$','interpreter','latex','fontsize',16)
set(gca,'FontSize',16)
axis([0.05 0.25 0 150])
box on

text(0.15,100,'Bi-2212','FontSize',16,'FontSize',16,'interpreter','latex')
text(0.20,100,'Hg-2201','FontSize',16,'FontSize',16,'interpreter','latex')
text(0.15,80,'Raman','FontSize',16,'FontSize',15,'interpreter','latex')
text(0.20,80,'Raman','FontSize',16,'FontSize',15,'interpreter','latex')
text(0.20,60,'ARPES','FontSize',16,'FontSize',15,'interpreter','latex')

LA=legend(L1(1:3),'$\rm \Delta_{PG}/2$','$\rm \Delta_{CDW}$','$\rm 1.3\Delta^{AN}_{SC}$','Location','northwest');
set(LA,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LB=legend(ah,L2(1:3),'$\rm \Delta_{PG}/2$','$\rm \Delta_{CDW}$','$\rm 1.3\Delta^{AN}_{SC}$','Location','northeast');
set(LB,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LC=legend(ah,L3(1:3),'$ \Delta^*/3.5$ hump','$\Delta^*$ peak','$\Delta^*$ hump or peak');
set(LC,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
LD=legend(ah,L1(4:5),'Eq. (3), $\gamma_{\Delta}=0.11$ ','Eq. (3), $\gamma_{\Delta}=0.11[1-({p\over 0.25})^{10}]$ ','Location','southwest');
set(LD,'FontSize',14,'interpreter','latex')
legend('boxoff')
