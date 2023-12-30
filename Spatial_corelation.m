clear all;fclose all;clc;clear;close all
a1='era5_Yr_mean.nc'; %%% daily data
ela=double(ncread(a1,'lat'));
elo=double(ncread(a1,'lon'));
e1=double(ncread(a1,'average'));

ms1=load('Precp_mask.dat');ms2=ms1(:,2:end);
ms2(ms2==-99.90)=NaN;
ms2(ms2==0)=1;
plo=66.50:.25:100;
pla=6.50:.25:38.50;

[xq1,yq1] = meshgrid(66:1:100, 5:1:40);
pg1 = griddata(plo,pla,ms2,xq1,yq1);

rlo=66:1:100;
rla=5:1:40;

for i=1:36
    e2=e1(:,:,i);e2=e2';
    eg1 = griddata(elo,ela,e2,xq1,yq1);
    eg2=eg1.*pg1;
    eg3(:,i)=reshape(eg1,1260,1);
    clear eg1 e2 eg2

end



clearvars -except rla rlo e1 eg3

a1='zmla_Eday_INM-CM5-0'; %%% daily data
cla=double(ncread(a1,'lat'));
clo=double(ncread(a1,'lon'));
c1=double(ncread(a1,'syraverage'));

[xq1,yq1] = meshgrid(0:1:359, -90:1:89);
z1=load('india_mask_360x180_89.5S-90N.dat');


lon=z1(:,1)-180;lat=z1(:,2);
lo1=reshape(lon,180,360);
la1=reshape(lat,180,360);
da1=reshape(z1(:,3),180,360);
da2=[da1(:,181:end) da1(:,1:180)];


[xq2,yq2] = meshgrid(66:1:100, 5:1:40);

hla=yq1(:,1);hlo=xq1(1,:)-180;

for i=1:36
    c2=c1(:,:,i);c2=c2';
    cg1 = griddata(clo,cla,c2,xq1,yq1);
    cg2=[cg1(:,181:end) cg1(:,1:180)];
    cg3=cg2.*da2;cg3(cg3==0)=NaN;

    cg4 = griddata(hlo,hla,cg3,xq2,yq2);


    cg5(:,i)=reshape(cg4,1260,1);
    clear cg1 cg2 cg3 cg4

end

clearvars -except rla rlo e1 eg3 cg5


for j=1:1260
    R1=eg3(j,:);R2=cg5(j,:);
    R1(isnan(R2)==1)=NaN;
    R2(isnan(R1)==1)=NaN;
    R1(isnan(R1)==1)=[];
    R2(isnan(R2)==1)=[];

    if isempty(R1)==1
        cr1(j)=NaN;
    else
        [Ra,P] = corrcoef(R1,R2,'rows','complete');
        cr1(j)=Ra(1,2);clear Ra P
    end
    clear R1 R2
end

cr2=reshape(cr1,36,35);
ma=load('India_outline.DAT');

figure(1)
subplot(441)
pcolor(rlo,rla,cr2);shading interp;colormap(jet(20));xlim([60 100]);ylim([5 40]);grid on;box on
text(62,35,'(a)')
set(gca, 'XTicklabels', [])
caxis([-1 1])
hold on 
plot(ma(:,1),ma(:,2),'-k')
