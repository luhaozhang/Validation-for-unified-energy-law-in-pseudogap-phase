

%I. Aim predict the PG gap
clf
clear

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
hold on
load Data_DeltaDisData
plot(DeltaDisData(:,1),DeltaDisData(:,2),'k^','MarkerFaceColor','k','MarkerSize',6,'LineWidth',1.5)
plot(DeltaDisData(:,3),DeltaDisData(:,4),'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1.5)
plot(DeltaDisData(:,5),DeltaDisData(:,6),'md','MarkerFaceColor','m','MarkerSize',6,'LineWidth',1.5)

%D. Gap预测：公度的CDW+涨落的影响

x=0:0.1:100;
Qpre=0.22:0.03:0.28;
QprePhy=Qpre*2*pi/a0T;
meffpre=2.7*me;
Dpre=0.12*(hbar^2.*QprePhy.^2./(meffpre))*1000/ee;
y=exp(-(x-Dpre(2)).^2./(Dpre(3)-Dpre(2)).^2);
%plot(x,y,'g-','MarkerSize',6,'LineWidth',1.5)
y=exp(-(sqrt(x)-sqrt(Dpre(2))).^2./(sqrt(Dpre(3))-sqrt(Dpre(2))).^2);
plot(x,y,'k-','MarkerSize',6,'LineWidth',1.5)

Qpre=0.146:0.020:0.186;
QprePhy=Qpre*2*pi/a0T;
meffpre=2.7*me;
Dpre=0.135*(hbar^2.*QprePhy.^2./(meffpre))*1000/ee;
y=2.1*exp(-(x-Dpre(2)).^2./(Dpre(3)-Dpre(2)).^2);
%plot(x,y,'r-','MarkerSize',6,'LineWidth',1.5)
y=2.1*exp(-(sqrt(x)-sqrt(Dpre(2))).^2./(sqrt(Dpre(3))-sqrt(Dpre(2))).^2);
plot(x,y,'r-','MarkerSize',6,'LineWidth',1.5)

Qpre=0.125:0.018:0.161;
QprePhy=Qpre*2*pi/a0T;
meffpre=2.7*me;
Dpre=0.07*(hbar^2.*QprePhy.^2./(meffpre))*1000/ee;
y=4.1*exp(-(x-Dpre(2)).^2./(Dpre(3)-Dpre(2)).^2);
%plot(x,y,'m-','MarkerSize',6,'LineWidth',1.5)
y=4.1*exp(-(sqrt(x)-sqrt(Dpre(2))).^2./(sqrt(Dpre(3))-sqrt(Dpre(2))).^2);
plot(x,y,'m-','MarkerSize',6,'LineWidth',1.5)

axis([0 100 0 5 ])
xlabel('$\Delta^*$(meV)','interpreter','latex')
ylabel('Count(a.u.)','interpreter','latex')
set(gca,'FontSize',16)
L1=legend('p=0.128','p=0.160','p=0.209','Eq. (S1), $\gamma_{\Delta}=0.120$, $\overline{Q}=0.250$ and $\delta_{Q}=0.030$','Eq. (S1), $\gamma_{\Delta}=0.135$, $\overline{Q}=0.166$ and $\delta_{Q}=0.020$','Eq. (S1), $\gamma_{\Delta}=0.070$, $\overline{Q}=0.143$ and $\delta_{Q}=0.018$','interpreter','latex','FontSize',16);
legend('boxoff')
box on