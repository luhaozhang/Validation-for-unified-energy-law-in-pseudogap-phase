

%I. Aim predict the PG gap
clf
clear

hold on

%II.parameter
%A. Fundamental constant 
hbar=1.05*10^(-34);     % plank constant
me=9.1*10^(-31);        % electron mass 
ee=1.6*10^(-19);
kb=1.38*10^(-23);       % Boltzman constant
%B. sample parameter
a0=5.36*10^(-10);  % a axis lattice constant of Bi2201
b0=5.37*10^(-10);  % b axis lattice constant of Bi2201
c0=2.46*10^(-9);   %几乎是上限，总体变化不大，在0.06的量级
a0T=a0/sqrt(2);
%C. Data
%gap
hold on
readdata
UD25X=data{1}(:,[1,2]);
l(1)=plot(UD25X(:,2),UD25X(:,1),'g^','MarkerFaceColor','g','MarkerSize',6)
UD25Y=data{1}(:,[1,3]);
plot(UD25Y(:,2),UD25Y(:,1),'g^','MarkerFaceColor','g','MarkerSize',6)
UD32X=data{2}(:,[1,2]);
l(2)=plot(UD32X(:,2),UD32X(:,1),'ks','MarkerFaceColor','k','MarkerSize',6)
UD32Y=data{2}(:,[1,3]);
plot(UD32Y(:,2),UD32Y(:,1),'ks','MarkerFaceColor','k','MarkerSize',6)
OP35X=data{3}(:,[1,2]);
l(3)=plot(OP35X(:,2),OP35X(:,1),'ro','MarkerFaceColor','r','MarkerSize',6)
OP35Y=data{3}(:,[1,3]);
plot(OP35Y(:,2),OP35Y(:,1),'ro','MarkerFaceColor','r','MarkerSize',6)
OD15Y=data{4}(:,[1,3]);
l(4)=plot(OD15Y(:,2),OD15Y(:,1),'cd','MarkerFaceColor','c','MarkerSize',6)


load DstarTstardata

%III.calculation 

%fit
Qpre=0:0.001:0.4;
QprePhy=Qpre*2*pi/a0T;
meffpre=2.7*me;
Dpre=0.135*(hbar^2.*QprePhy.^2./(meffpre))*1000/ee;
l(5)=plot(Qpre,Dpre,'b-','MarkerSize',8,'LineWidth',1.5);

%Gap pre
Qpre=0.22:0.03:0.28;
QprePhy=Qpre*2*pi/a0T;
meffpre=2.7*me;
Dpre=0.135*(hbar^2.*QprePhy.^2./(meffpre))*1000/ee;

%AF Gap
QAF=0.5;
QAFPhy=QAF*2*pi/a0T;
meffpre=2.2*me;
DAFpre=0.135*(hbar^2.*QAFPhy.^2./(meffpre))*1000/ee;


%Comparisoon with Fermiology
load QDeltaComin2014
load QANQAFZBDelta

l(6)=plot(QANQAFZBDelta(:,1),QANQAFZBDelta(:,3),'k--','MarkerSize',8,'LineWidth',1.5);
l(7)=plot(QANQAFZBDelta(:,2),QANQAFZBDelta(:,3),'k-.','MarkerSize',8,'LineWidth',1.5);

axis([0 0.3 0 150 ])
xlabel('$Q_{\rm CDW}(2\pi/a_0)$','interpreter','latex')
ylabel('$\Delta({\rm meV})$','interpreter','latex')
set(gca,'FontSize',16)
box on
L1=legend(l([1,2,3,4]),'p=0.128','p=0.145','p=0.160','p=0.209','Location','northwest');
set(L1,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
L2=legend(ah,l([5,6,7]),'Eq. (3),$\gamma_{\Delta}=0.135$','Fermiology: AN','Fermiology: AFZB ');
set(L2,'FontSize',14,'interpreter','latex')
legend('boxoff')
box on
