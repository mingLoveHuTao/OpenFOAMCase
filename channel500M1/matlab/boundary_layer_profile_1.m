% plot z+ - u+ from singleGraph
clear
case_name=regexp(pwd,'\/\w*$','match');
case_name=case_name{1};
case_name(1)=[];
% draw figure control
fig1=figure;
fig2=figure;
% .m file name
script_name='BoundaryLayer';
% import data
for t=[1.0 3.0 5.0 7.0 8.0 9.0 10.0]
file=importdata(['postProcessing/singleGraph/',num2str(t),'/line2_U_UMean.xy']);
data=file;
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer2_U_UMean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer3_U_UMean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer4_U_UMean.xy']);
% data=[data;file];
% data(:,1)=data(:,1)-data(1,1);

% draw Ux - z
figure_name='';
figure(fig1);hold on
plot(data(:,5),data(:,1),'DisplayName',['t = ',num2str(t),' s'])
xlabel('U_x / m/s')
ylabel('z / m')
% savefig(fig1,['matlab/',case_name,script_name,figure_name,'.fig'])

%% draw U+ - z+
figure_name='Normalized';
% get yplus average of WALL_WALL
% yp_file=importdata(['postProcessing/yPlus/0/yPlus.dat']);
% yp_all=yp_file.data;
% yplus1=yp_all(2*t-1,2);
% % get utao of WALL_WALL
% taow_file='postProcessing/wallShearStress/0/wallShearStress.dat';
% fid=fopen(taow_file,'r');
% for line_count=1:(2+2*t-1)
%     tline = fgetl(fid);
% end
% num=regexp(tline,'-?\d+(\.\d+)?(e-\d+)?','match');
% taow=str2num(num{5});
% calculate deltaniu
mu=0.000999158079418904;
rho=998.184810175838;
niu=mu/rho;
% taow=(data(2,2)-data(2,1))/(data(2,1)-data(1,1))*mu;
k=polyfit(data(1:5,1),data(1:5,2),1);
taow=-38;%k(1)*mu;
utao=sqrt(abs(taow)/rho); % friction velocity
deltaniu=niu/utao; %viscousity length 按照摩擦雷诺数算应该是1e-5

figure(fig2);
endindex=floor(length(data(:,1))/2);
plot(data(1:endindex,1)/deltaniu,data(1:endindex,5)/utao,'DisplayName',['t = ',num2str(t),' s'],'Marker','+')
hold on
% hold off
box on
xlabel('z^+')
ylabel('u^+')
% title(['t = ',num2str(t),' s'])
set(gca,'XScale','log','YScale','linear')
lgd=legend;
set(lgd,'location','best')
% savefig(fig,['matlab/',case_name,script_name,figure_name,'1.fig'])
% pause()
end
figure(fig2);
hold on
% draw analytical solution
y=linspace(0,20,100);
u1=y;%u+ = y+
plot(y,u1,'linestyle','--','displayname','u^+ = y^+')
y=linspace(8,1e3,100);
u2=1/0.4*log(y)+5.5;%u+ = 1/0.4 * ln(y+) + 5.5 
semilogx(y,u2,'linestyle','--','displayname','u+ = 1/0.4 * ln(y+) + 5.5')
% lgd=legend;
% set(lgd,'location','best')
% line([5 5],[0 20],'linestyle','-.')
% line([30 30],[0 20],'linestyle','-.')