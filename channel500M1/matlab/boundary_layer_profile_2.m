% plot z+ - u+ from singleGraph
clear
case_name=regexp(pwd,'\/\w*$','match');
case_name=case_name{1};
case_name(1)=[];
% draw figure control
% fig1=figure;
fig2=figure;
% .m file name
script_name='BoundaryLayer';
% import data
for t=[5 6 8 10]*1e3
file=importdata(['graphs/',num2str(t),'/Uf.xy']);
data=file;
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer2_U_UMean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer3_U_UMean.xy']);
% data=[data;file];
% file=importdata(['postProcessing/singleGraph/',num2str(t),'/layer4_U_UMean.xy']);
% data=[data;file];
% data(:,1)=data(:,1)-data(1,1);

% draw Ux - y
% figure_name='';
% figure(fig1);hold on
% plot(data(:,2),data(:,1),'DisplayName',['t = ',num2str(t),' s'])
% xlabel('U_x / m/s')
% ylabel('y / m')
% savefig(fig1,['matlab/',case_name,script_name,figure_name,'.fig'])

%% draw U+ - y+
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
% mu=0.000999158079418904;
% rho=998.184810175838;
niu=2e-5;
re_tao=1000;
h=1;

% friction velocity
%method 1
% utao=re_tao*niu/h;
% method 2
k=polyfit([0 data(1:1,1)],[0 data(1:1,2)],1);
utao=sqrt(niu*k(1))
% method 3 tau_w from paraview
% utao=sqrt(abs(-0.00394607/16))
% % method 4 pressure gradient to tau_w
% pppx=0.000246701;
% utao=sqrt(pppx*h/1.0)

deltaniu=niu/utao; %viscousity length 

figure(fig2);
plot(data(:,1)/deltaniu,data(:,2)/utao,'DisplayName',['t = ',num2str(t),' s'],'Marker','+')
hold on
% hold off
box on
xlabel('y^+')
ylabel('u^+')
% title(['t = ',num2str(t),' s'])
set(gca,'XScale','log','YScale','linear')
% lgd=legend;
% set(lgd,'location','best')
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
u2=1/0.41*log(y)+5.5;%u+ = 1/0.4 * ln(y+) + 5.5 
semilogx(y,u2,'linestyle','--','displayname','u+ = 1/0.4 * ln(y+) + 5.5')

% reference DNS data
file=importdata(['../The JHU Turbulence Databases (JHTDB) turbulent channel flow data set.txt']);
dns=file.data;
plot(dns(:,1),dns(:,2),'DisplayName',['dns JHTDB'])

lgd=legend;
set(lgd,'location','best')
% line([5 5],[0 20],'linestyle','-.')
% line([30 30],[0 20],'linestyle','-.')