clear all;fclose all;clc;clear;close all
a1='/MATLAB Drive/avg_season/SON_avg/zmla_Eday_INM-CM4-8.nc'; %%% daily data
la=double(ncread(a1,'lat'));
lo=double(ncread(a1,'lon'));
z1=double(ncread(a1,'average'));z1=z1';

ma=load('India_outline.DAT');

ms1=load('Precp_mask.dat');ms2=ms1(:,2:end);
ms2(ms2==-99.90)=NaN;
ms2(ms2==0)=1;

[xq,yq] = meshgrid(0:1:359, -90:1:89);
% converting cmip6 mean to 1X1 over whole globe
vq=griddata(lo,la,double(z1),xq,yq);
% extracting the region between lat 5 to 40 and 66 to 100 lon which is 1X1
subset=vq([5:40],[66:100]);

[xq1,yq1] = meshgrid(66:1:100, 5:1:40);
plo=66:1:100;
pla=5:1:40;

% for era5
a2='/MATLAB Drive/season_avg_data_files_era5/SON/era5_mean.nc'; %%% daily data
la1=double(ncread(a2,'lat'));
lo1=double(ncread(a2,'lon'));
z2=double(ncread(a2,'average'));z2=z2';
% converting era5 mean to 1X1 between 66 to 100 lon and 5 to 40 latitude
gg2 = griddata(lo1,la1,double(z2),xq1,yq1);

% converting the mask to 1X1 grid
po=66.50:0.25:100;
pa=6.50:0.25:38.50;
sath = griddata(po,pa,ms2,xq1,yq1);

% gg3 is era5 indian mean,gg4 is cmip6 mean
gg3=sath.*gg2;
gg4=sath.*subset;

% subtracting the values of cmpi6 from era5
final=gg3-gg4;
maxValue = max(final(:));
minValue = min(final(:));
disp(minValue);
disp(maxValue);


% plotting the difference
figure(3)
subplot(222)
pcolor(plo,pla,final);shading interp;colormap('jet(20)');colorbar;caxis([minValue maxValue])
hold on;plot(ma(:,1),ma(:,2),'-k')
xlim([60 100]);ylim([0 40])



