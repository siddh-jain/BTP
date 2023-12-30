clear all;fclose all;clc;clear;close all
a1='/MATLAB Drive/season_trends/SON_trends/zmla_Eday_IPSL-CM6A-LR'; %%% daily data
a2='/MATLAB Drive/IPSL-CM6A-LR.nc'
la=double(ncread(a2,'lat'));
lo=double(ncread(a2,'lot'));
z1=double(ncread(a1,'average'));z1=z1';
pvalue=double(ncread(a1,'p_value'));pvalue=pvalue';




% figure(1)
% subplot(211)
% pcolor(lo,la,z1);shading interp;colormap('jet(20)');colorbar;caxis([0 1500])
% hold on; load coast;plot(long,lat,'-k')


ms1=load('Precp_mask.dat');ms2=ms1(:,2:end);
ms2(ms2==-99.90)=NaN;
ms2(ms2==0)=1;
[xq,yq] = meshgrid(0:1:359, -90:1:89);
plo=66.50:0.25:100;
pla=6.50:0.25:38.50;
gg = griddata(plo,pla,ms2,xq,yq);
vq=griddata(lo,la,double(z1),xq,yq);
pv=griddata(lo,la,double(pvalue),xq,yq);
gr=gg.*vq;
pr=gg.*pv;




gr1=[gr(:,181:end) gr(:,1:180)];
pvalue1=[pr(:,181:end) pr(:,1:180)];
rlo=-180:1:179;rla=-90:1:89;

p_value_threshold = 0.2;
[row_indices, col_indices] = find(pvalue1 < p_value_threshold);

% lo1 = rlo(indices);
% la1 = rla(indices);
% % 

maxValue = max(gr1(:));
minValue = min(gr1(:));

ma=load('India_outline.DAT');

figure(3)
subplot(221)
pcolor(rlo,rla,gr1);shading interp;colormap('jet(20)');colorbar;caxis([minValue maxValue])
hold on;plot(ma(:,1),ma(:,2),'-k')
xlim([60 100]);ylim([0 40])
hold on;
scatter(rlo(col_indices), rla(row_indices),1,'filled', 'MarkerFaceColor','black');
%scatter(rlo(col_indices), rla(row_indices),'.');
hold off;
% 
%sgtitle('Total Average', 'Position', [0.5, 43]);
%saveas(gcf,'zmla_Eday_EC-Earth3-Veg-LR_jja.jpg');
