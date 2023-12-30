clear all;fclose all;clc;clear;close all
a1='/MATLAB Drive/season_avg_data_files_era5/SON/era5_mean.nc'; %%% daily data
la=double(ncread(a1,'lat'));
lo=double(ncread(a1,'lon'));
z1=double(ncread(a1,'average'));z1=z1';


[xq1,yq1] = meshgrid(66:1:100, 5:1:40);


rlo=66:1:100;
rla=5:1:40;

gg1 = griddata(lo,la,z1,xq1,yq1);

ms1=load('Precp_mask.dat');ms2=ms1(:,2:end);
ms2(ms2==-99.90)=NaN;
ms2(ms2==0)=1;

plo=66.50:0.25:100;
pla=6.50:0.25:38.50;

gg2 = griddata(plo,pla,ms2,xq1,yq1);

gg3=gg1.*gg2;
ma=load('India_outline.DAT');
maxValue = max(gg3(:));
minValue = min(gg3(:));




figure(1)
% subplot(331)
% pcolor(lo,la,z1);shading interp;colormap('jet(20)');colorbar;caxis([0 1500])
% hold on; load coast;plot(long,lat,'-k')
% 
% subplot(332)
% pcolor(rlo,rla,gg1);shading interp;colormap('jet(20)');colorbar;caxis([0 1500])
% xlim([60 100]);ylim([0 40])
% hold on; load coast;plot(long,lat,'-k')

subplot(333)
pcolor(rlo,rla,gg3);shading interp;colormap('jet(20)');colorbar;caxis([minValue maxValue])
xlim([60 100]);ylim([0 40])
hold on;plot(ma(:,1),ma(:,2),'-k')
% xlim([60 100]);ylim([0 40])
% hold on; load coast;plot(long,lat,'-k')
