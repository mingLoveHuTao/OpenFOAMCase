% plot z+ - k, <uu>, <vv>, <ww> from singleGraph
clear
case_name=regexp(pwd,'\/\w*$','match');
case_name=case_name{1};
case_name(1)=[];
% draw figure control
fig=figure;
sub1=subplot(121);
sub2=subplot(122);
set(gcf,'unit','centimeters')
position=[20 15 14 7.5];
set(gcf,'position',position)
% .m file name
script_name='TurbulentStatistics';
% import data
% zCoordinate XX XY XZ YY YZ ZZ
for t=50000%2.2:0.2:5.4
u=importdata(['graphs/',num2str(t),'/u.xy']);
uu=u(:,2).^2;
v=importdata(['graphs/',num2str(t),'/v.xy']);
vv=v(:,2).^2;
w=importdata(['graphs/',num2str(t),'/w.xy']);
ww=w(:,2).^2;
k=importdata(['graphs/',num2str(t),'/k.xy']);

% draw statics - z
% figure_name='';
% fig=figure;
% plot(data(:,2),data(:,1))
% xlabel('U_x / m/s')
% ylabel('z / m')
% savefig(fig,['matlab/',case_name,script_name,figure_name,'.fig'])

% calculate deltaniu
niu=2e-5;
% taow=(data(2,2)-data(2,1))/(data(2,1)-data(1,1))*mu;
% k=polyfit(data(1:2,1),data(1:2,2),1);
re_tao=1000;
h=1;
utao=re_tao*niu/h;%sqrt(niu*k(1));%re_tao*niu/h; % friction velocity
% utao=sqrt(niu*k(1)); % friction velocity
deltaniu=niu/utao;

%% rms figure
figure_name='uvwRms';
zplus=u(:,1)/deltaniu;

axes(sub1)
cla
hold on
plot(zplus,k(:,2),'DisplayName','k')
xlabel('z')
ylabel('k')
title(['t = ',num2str(t),' s'])
box on
hold off

axes(sub2)
cla
hold on
% plot(zplus,uu./k(:,2),'DisplayName','u_{rms}')
% plot(zplus,vv./k(:,2),'DisplayName','v_{rms}')
% plot(zplus,ww./k(:,2),'DisplayName','w_{rms}')
plot(zplus,uu,'DisplayName','u_{rms}')
plot(zplus,vv,'DisplayName','v_{rms}')
plot(zplus,ww,'DisplayName','w_{rms}')
xlabel('z^+')
ylabel('rms of u,v,w / k')
title(['t = ',num2str(t),' s'])
box on
hold off

% savefig(fig,['matlab/',case_name,script_name,figure_name,'t=',num2str(t),'.fig'])
% pause()
end
% close all