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
for t=1.6%2.2:0.2:5.4
file=importdata(['postProcessing/singleGraph/',num2str(t),'/line1_UPrime2Mean.xy']);
data=file;
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer2_UPrime2Mean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer3_UPrime2Mean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer4_UPrime2Mean.xy']);
% data=[data;file];
% data(:,1)=data(:,1)-data(1,1);

% draw statics - z
% figure_name='';
% fig=figure;
% plot(data(:,2),data(:,1))
% xlabel('U_x / m/s')
% ylabel('z / m')
% savefig(fig,['matlab/',case_name,script_name,figure_name,'.fig'])

% calculate deltaniu
mu=0.000999158079418904;
rho=998.184810175838;
niu=mu/rho;
file=importdata(['postProcessing/singleGraph/',num2str(t),'/line1_U_UMean.xy']);
datau=file;
% taow=(datau(2,2)-datau(2,1))/(datau(2,1)-datau(1,1))*mu;
k=polyfit(datau(1:10,1),datau(1:10,2),1);
taow=k(1)*mu;
utao=sqrt(abs(taow)/rho); % friction velocity
deltaniu=niu/utao; %viscousity length

%% rms figure
figure_name='uvwRms';
zplus=data(:,1)/deltaniu;
k=0.5*(data(:,2)+data(:,5)+data(:,7));

axes(sub1)
cla
hold on
plot(data(:,1),k,'DisplayName','k')
xlabel('z')
ylabel('k')
title(['t = ',num2str(t),' s'])
box on
hold off

axes(sub2)
cla
hold on
plot(zplus,data(:,2)./k,'DisplayName','u_{rms}')
plot(zplus,data(:,5)./k,'DisplayName','v_{rms}')
plot(zplus,data(:,7)./k,'DisplayName','w_{rms}')
xlabel('z^+')
ylabel('rms of u,v,w / k')
title(['t = ',num2str(t),' s'])
box on
hold off

% savefig(fig,['matlab/',case_name,script_name,figure_name,'t=',num2str(t),'.fig'])
% pause()
end
% close all