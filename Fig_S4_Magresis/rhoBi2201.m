%I.Aim prediction of rho0 

%II. Formula

%III.program
clc
clear
clf

%A. Parameters
%1. constant 
kb=1.38*10^(-23);       % Boltzman constant
me=9.1*10^(-31);        % electron mass 
ee=1.6*10^(-19);
phi0=2.07*10^(-15);     % flux quanta 
mu0=4*pi*10^(-7);       % permeability of vacuum 
hbar=1.05*10^(-34);        % plank constant

%2. Data
a0=5.36*10^(-10);  % a axis lattice constant of Bi2201
b0=5.37*10^(-10);  % b axis lattice constant of Bi2201
c0=2.46*10^(-9);
layer=1;

%3.data plot
load dataOno


%4.conductivity predictions
pCDWBi2201=0.160;     %cominScience2014, PengPRB2016
QCDWBi2201=0.2304;     %fit datat is 0.231\pm0.01     %4.17-4.56
lCO=(1./QCDWBi2201)*(a0/sqrt(2));
nh=2*pCDWBi2201*(a0*b0).^(-1);  % hole density  
gammaCDW=0.12;
rho0pCDW=gammaCDW*(2*pi*hbar)/((2*nh/c0).*(lCO.^2)*ee^2)
B=0.001:0.1:80;
B0=5;
rhoBpreBi2201=rho0pCDW.*(B./(B0+B));
plot(dataOno2000(:,1),(dataOno2000(:,2)*1000),'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1)
%return

hold on
plot(B,rhoBpreBi2201*10^(8),'b-','MarkerSize',8,'LineWidth',1.5)


axis([0 80 0 150])
xlabel('$B(T)$','FontSize',16,'interpreter','latex')
ylabel('$\rho(\mu\Omega cm)$','FontSize',16,'interpreter','latex')
set(gca,'FontSize',16)
box on
legend('Bi-2201 p=0.16 25 K','Eq. (S3)','interpreter','latex')
legend('boxoff')