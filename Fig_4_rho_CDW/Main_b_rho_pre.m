

clear
clc
% clf
subplot(1,2,2)
hold on
text(0.09+0.16*0.85,1000*0.9,'(b)','FontSize',16)
axis([0.09 0.25 0 1000])
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
load('Data_b_rhoTSHOno2000')
load('Data_b_rhoTSHAndo2004')
load('Data_b_QoloBLSCOCai2016Comin2014Peng2018')
load Data_b_TsfWen2009

%3. exp data
errorbar(rhoTSHAndo2004(:,1),rhoTSHAndo2004(:,2)*100,rhoTSHAndo2004(:,3)*100,'rO','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1)
errorbar(rhoTSHOno2000(:,1),rhoTSHOno2000(:,2)*100,rhoTSHOno2000(:,3)*100,'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1)

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
plot(dopingAF,pRGlAF(:,2)*s*10^8,'k-','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1.5)

%6 comparison to Plankian dissipation
mstar=2.7*me;
nh=layer.*TsfWen2009(:,1)./Slat;                 %hole density 
tauPlanckL=hbar./(kb*TsfWen2009(:,6));
tauPlanckH=hbar./(kb*TsfWen2009(:,5));
RPlanckH=1./(nh.*ee^2.*tauPlanckL./mstar);
RPlanckL=1./(nh.*ee^2.*tauPlanckH./mstar);
RPlanck=[TsfWen2009(:,1) (RPlanckH+RPlanckL)/2 (RPlanckH-RPlanckL)/2 RPlanckL RPlanckH];
errorbar(RPlanck(:,1),RPlanck(:,2)*s*10^8,RPlanck(:,3)*s*10^8,'gs--','MarkerFaceColor','g','MarkerSize',6,'LineWidth',1)
alphapre=[RPlanck(:,1) 2*s*10^8./(nh.*ee^2.*hbar./(kb*mstar))]; %(optimal fit)
load Data_b_alphaBi2201Ando2004
%plot
vq = interp1(TsfWen2009(:,1),TsfWen2009(:,3),alphaBi2201Ando2004(:,1),'linear');
vq2= interp1(TsfWen2009(:,1),TsfWen2009(:,4),alphaBi2201Ando2004(:,1),'linear');

% set(gca,'yscale','log') %将x,y轴上刻度单位设置为对数坐标型
L1=legend('data, Ref.[46]','data, Ref.[48]','Eq.(5) $l_{\rm DW}=l_{\rm CDW}$', 'Eq.(5) $l_{\rm DW}=2a_{0}$','Planckian limit');
set(L1,'FontSize',13,'Location','NorthEast','interpreter','latex')
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