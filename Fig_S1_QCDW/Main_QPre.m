
clf
clear
hold on


%Hg-2201
load Data1_QCDWHg2201Tabis2017  % Tabis2017 Campi2015
pCO=QCDWdata(:,1);
QCO=QCDWdata(:,2); 
l(1)=plot(pCO,QCO,'bs','MarkerFaceColor','b','MarkerSize',8,'LineWidth',1)
myfunc = @(beta,x)(beta(1)*x+beta(2));
beta0 = [1,1];
pCOHgB1=[pCO;];
QCOHgB1=[QCO;];
beta = nlinfit(pCOHgB1,QCOHgB1,myfunc,beta0)
x1=0:0.001:0.3;
y1=myfunc(beta,x1);
l(2)=plot(x1,y1,'b','LineWidth',1.5);


%Bi-2212
load Data2_QCDWBi2212Fujita2014  %2014scienceFujita  
%pCDWBi2212B=[0.0607833;0.0812321;0.101336;0.141197;0.170508;];           
%QCDWBi2212B=[0.308598;0.270919;0.254584;0.242965;0.225771;];
pCDWBi2212B=QCDWBi2212Fujita2014(:,1);
QCDWBi2212B=QCDWBi2212Fujita2014(:,2);
l(3)=plot(pCDWBi2212B,QCDWBi2212B,'kd','MarkerFaceColor','k','MarkerSize',8,'LineWidth',1);
beta = nlinfit(pCDWBi2212B,QCDWBi2212B,myfunc,beta0);
x1=0:0.001:0.3;
y1=myfunc(beta,x1);
l(4)=plot(x1,y1,'k','LineWidth',1.5);

%Bi-2201
load('Data3_QCDWBi2201Cai2016Comin2014Peng2018')
x=QoloBLSCOCai2016Comin2014Peng2018(:,1);
y=QoloBLSCOCai2016Comin2014Peng2018(:,2);
yr=QoloBLSCOCai2016Comin2014Peng2018(:,3);
l(5)=errorbar(x,y,yr,'ro','MarkerFaceColor','r','MarkerSize',6,'LineWidth',1);
myfunc = @(beta,x)(beta(1)*(1-(x/beta(2)).^beta(3)));
beta0 = [1,1,1];
beta = nlinfit(x,y,myfunc,beta0);
x1=0:0.001:0.3;
y2=myfunc(beta,x1);
l(6)=plot(x1,y2,'r','LineWidth',1.5);


%Style
axis([0 0.3 0 0.5])
set(gca,'FontSize',16)
xlabel('$p$','interpreter','latex','fontsize',16)
ylabel('$Q_{\rm CDW}(2\pi/a_0)$','interpreter','latex','fontsize',16)
box on
L1=legend(l([1,3,5]),'Hg-2201','Bi-2212','Bi-2201','location','northwest');
set(L1,'FontSize',14,'interpreter','latex')
legend('boxoff')
ah=axes('position',get(gca,'position'),'visible','off');
L2=legend(ah,l([2,4,6]),'$0.343-0.699p$','$0.334-0.662p$','$0.269[1-({p/ 0.261})^{3.79}]$');
set(L2,'FontSize',14,'interpreter','latex')
legend('boxoff')
box on

