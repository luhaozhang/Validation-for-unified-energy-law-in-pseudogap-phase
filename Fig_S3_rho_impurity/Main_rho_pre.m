

clear
clc
clf
subplot(1,2,1)
hold on
text(0.1+0.1*0.85,600*0.9,'(a)','FontSize',16)
axis([0.1 0.2 0 600])
set(gca,'FontSize',16)
xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('$\rho(T_{\rm sf})({\rm \mu\Omega cm})$','interpreter','latex','fontsize',16)
box on 
hold on

%constant
ee=1.6*10^(-19);
hbar=1.05*10^(-34);        % plank constant
kb=1.38*10^(-23);       % Boltzman constant
me=9.1*10^(-31);        % electron mass 
%Data
a0=5.36*10^(-10);  % a axis lattice constant of Bi2201
b0=5.37*10^(-10);  % b axis lattice constant of Bi2201
c0=2.46*10^(-9);   %几乎是上限，总体变化不大，在0.06的量级
layer=1;
cell=2;
cite=2;
s=c0/cell;
Slat=a0.*b0./cite;   %格点面积
load('Data1_rhoTSHOno2000')
load('Data2_rhoTSHAndo2004')
load('Data3_QCDWBi2201Cai2016Comin2014Peng2018')
load Data4_TsfWen2009
load Data5_p_rho_XJZhou

%3. exp data
errorbar(rhoTSHAndo2004(:,1),rhoTSHAndo2004(:,2)*100,rhoTSHAndo2004(:,3)*100,'rO','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1)
errorbar(rhoTSHOno2000(:,1),rhoTSHOno2000(:,2)*100,rhoTSHOno2000(:,3)*100,'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1)
errorbar(xinter(:,1),xinter(:,2),xinter(:,3),'md','MarkerFaceColor','m','MarkerSize',6,'LineWidth',1)

%4.predictions
gamma=0.11;
%QCDW fit data and commensuration
myfunc = @(beta,x)(beta(1)*(1-(x/beta(2)).^beta(3)));
beta=[ 0.2692    0.2605    3.7937];  %QCDWFit-Pb-Bi2201 to 0.23
x1=transpose(0:0.001:0.3);
y1=myfunc(beta,x1);
rhoIntPre=RGlQP(layer,a0,b0,cite,x1,y1,0.01*x1./x1,gamma);
plot(x1,rhoIntPre(:,2)*s*10^8,'b-','MarkerFaceColor','b','MarkerSize',6,'LineWidth',1.5)

%5 comparison to AF 
dopingAF=transpose(0:0.01:0.3);
pRGlAF=RGlQP(layer,a0,b0,cite,dopingAF,0.5*dopingAF./dopingAF,0*dopingAF./dopingAF,gamma);
% plot(dopingAF,pRGlAF(:,2)*s*10^8,'k-','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1.5)

L1=legend('data, Ref.[4]','data, Ref.[3]','data, Ref.[6]','Eq.(5) $l_o=l_{\rm CDW}$', 'Eq.(4) $l_{\rm DW}=2a_{0}$','interpreter','latex','fontsize',16);
set(L1,'FontSize',14,'Location','NorthEast','interpreter','latex')
legend('boxoff')
box on 


%6 Residual rho
x2=xinter(:,1);
y2=myfunc(beta,x2);
rhoIntPre=RGlQP(layer,a0,b0,cite,x2,y2,0.01*x2./x2,gamma);
Residual=xinter(:,2)-rhoIntPre(:,2)*s*10^8;
nc=layer.*x2./(Slat*s);                 %hole density 
mstar=2.7*me;
Gamma=(Residual*10^(-8).*nc*ee^2*(hbar)/mstar)/(ee/1000);
Gamma_o=(1/(2*pi))*(gamma*(2*pi*hbar)^2./(mstar*(Slat./(y1.^2))))/(ee/1000);

subplot(1,2,2)
hold on
plot(xinter(1:6,1),Gamma(1:6,1),'md','MarkerFaceColor','m','MarkerSize',6,'LineWidth',1.5)

text(0.1+0.1*0.08,20*0.9,'(b)','FontSize',16)
axis([0.1 0.2 0 20])
set(gca,'FontSize',16)
xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('Scattering rate(meV)','interpreter','latex','fontsize',16)
box on 
legend('$\hbar/\tau_{\rm imp}$, Eq. (S2)','interpreter','latex','fontsize',14)
legend('boxoff')


function outputdata=RGlQP(layer,a0,b0,cite,doping,Qom,Qoer,gamma) 
ee=1.6*10^(-19);
hbar=1.05*10^(-34);        % plank constant
Slat=a0.*b0./cite;                       %格点面积
%prediction
nh=layer.*doping./Slat;                 %hole density 
loL=sqrt(Slat)./(Qom+Qoer);              %平均序长度下限
GoL=(1/gamma).*(loL.^2).*nh*ee^2/(2*pi*hbar); %电导下限
RoH=1./GoL;                              %电阻上限
loH=sqrt(Slat)./(Qom-Qoer);              %平均序长度上限
GoH=(1/gamma).*(loH.^2).*nh*ee^2/(2*pi*hbar); %电导上限
RoL=1./GoH;                              %电阻下限
lom=(loH+loL)/2;
loer=(loH-loL)/2;
Gom=(GoH+GoL)/2;
Goer=(GoH-GoL)/2;
Rom=(RoH+RoL)/2;
Roer=(RoH-RoL)/2;
outputdata=[doping,Rom,Roer,Gom,Goer,lom,loer,Qom,Qoer];
end