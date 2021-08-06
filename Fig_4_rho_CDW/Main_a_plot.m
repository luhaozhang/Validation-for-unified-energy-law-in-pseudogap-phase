%I.Determination of Tsf rhosf Rsf with error bars

%II. Formula

%III.program
clear
clc
clf
subplot(1,2,1)
hold on
text(20+80*0.08,300*0.9,'(a)','FontSize',16)

%A. data
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
Slat=a0.*b0./cite;                       %格点面积

%B. data plot
Main_a_readdata
p011=data{2};
p012=data{3};
p013=data{4};
p014=data{5};
p015=data{6};
p016=data{7};
p017=data{8};
p018=data{9};

hold on
%plot(p013(:,1),p013(:,2),'rO-','MarkerFaceColor','r','MarkerSize',4)
plot(p014(:,1),p014(:,2)*100,'ro-','MarkerFaceColor','r','MarkerSize',6)
%plot(p015(:,1),p015(:,2),'k^-','MarkerFaceColor','k','MarkerSize',6)
plot(p016(:,1),p016(:,2)*100,'k^-','MarkerFaceColor','k','MarkerSize',6)
%plot(p017(:,1),p017(:,2),'cd-','MarkerFaceColor','c','MarkerSize',6)
% plot(p018(:,1),p018(:,2),'gs-','MarkerFaceColor','g','MarkerSize',6)


a=1.8;
y=a:0.01:a+0.3;
%plot(44.5*y./y,y,'k--',54.2*y./y,y+0.22,'k--','LineWidth',1)
plot(40.9*y./y,(y-0.62)*100,'k-',49.5*y./y,(y-0.37)*100,'k-','LineWidth',1)
%plot(40.8*y./y,y-0.93,'k--',48.4*y./y,y-0.72,'k-','LineWidth',1)
plot(45.9*y./y,(y-1.23)*100,'k-',52.1*y./y,(y-1.0)*100,'k-','LineWidth',1)
% plot(35.2*y./y,y-1.22,'k--',37*y./y,y-1.22,'k--','LineWidth',1)

axis([20 100 0 300])
set(gca,'FontSize',16)
xlabel('$T({\rm K})$','interpreter','latex','fontsize',16)
ylabel('$\rho({\rm \mu\Omega m})$','interpreter','latex','fontsize',16)
box on 
hold on

L1=legend('p=0.14','p=0.16','$T_{sf}$ error bars');
set(L1,'FontSize',13,'Location','NorthWest','interpreter','latex')
legend('boxoff')
