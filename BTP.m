clear all;fclose all;clc;clear;close all
a1='/MATLAB Drive/zmla_Eday_CESM2_amip_r1i1p1f1_gn_19500101-19591231.nc'; %%% daily data
a2 ='/MATLAB Drive/zmla_Eday_INM-CM5-0_amip_r1i1p1f1_gr1_19790101-19881231.nc';
%C = load('coast');



%%% daily data
la=ncread(a2,'lat');
lo=ncread(a2,'lot');
zt=ncread(a2,'average');
%p_val = ncread(a2,'p_value')
%a=z
%%sath=ncread(a1,'zmla');
%%sath=sath(:,:,1)

%%display(sath)
la = double(la);
lo = double(lo);
z = double(zt);
%p_v = double(p_val')
%%display(class(z))
%%z2=z(:,:,1);
z3=flipud(z);
%p3=flipud(p_v)

%%%%%%%%%%%%%Gridding data to 1x1 deg grid

[xq,yq] = meshgrid(0:1:359, -90:1:89);

vq = griddata(lo,la,z3',xq,yq);
%p_value = griddata(lo,la,p3',xq,yq)


z4=[vq(:,181:end) vq(:,1:180)];
%p4=[p_value(:,181:end) p_value(:,1:180)];

%%%%%%%%%%%masking data 
z1=load('india_mask_360x180_89.5S-90N.dat');
lon=z1(:,1)-180;lat=z1(:,2);
lo1=reshape(lon,180,360);
la1=reshape(lat,180,360);
da1=reshape(z1(:,3),180,360);
da2=[da1(:,181:end) da1(:,1:180)];

fd3=z4.*da2;fd3(fd3==0)=NaN;
%pd3=p4.*da2;pd3(pd3==0)=NaN;
%indices = find(pd3 < 0.1);



fd1=vq.*da1; 

fd=[fd1(:,146:end) fd1(:,1:145)];
fd(fd==0)=NaN;
rlo=-180:1:179;rla=-90:1:89;

% Load "india" variable from input file
%india = ncread('input_file.nc', 'india');

% Create new NetCDF file
%ncid = netcdf.create('output_file.nc', 'NC_WRITE');

% Add "india" variable to new file
%varid = netcdf.defVar(ncid, 'india', 'double', [180,360]);
%netcdf.putVar(ncid, varid, fd3);

% Close both files
%netcdf.close(ncid);


figure(1)
title('Sine Wave')
%%%%%%%
subplot(211)
pcolor(rlo,rla,z4);shading interp;colormap('jet(60)');colorbar;caxis([0 1500])
hold on;
numel(rlo)
%for i = 1:numel(rla)
  %  for j=1:numel(rlo)
        %disp('x is zero');
    %    if pd3(i,j)< 0.1
       %   disp('x is zero');
       %   text(j, i, '+', 'Color', 'red', 'FontSize', 14);
        %else
           % text(i, j, '.', 'Color', 'red', 'FontSize', 14);

      %  end
    %end
%end
%hold off;

subplot(212)
custom_map = [linspace(1, 0, 64)', linspace(0, 0.5, 64)', linspace(0, 1, 64)']; % Red to green to blue colormap
%colormap(custom_map); % Set the colormap to the custom_map
pcolor(rlo,rla,fd3);shading interp;colormap('jet');colorbar;caxis([0 1500])
%xticks(65:5:100); % Set the x-axis tick values with spacing of 2
%yticks(0:2:40); % Set the y-axis tick values with spacing of 50
xlim([65 100]);ylim([5 40])
hold on
%scatter(lo1(indices), la1(indices),5,'filled', 'MarkerFaceColor','red');

%pcolor(rlo,rla,pd3);shading interp;colormap('jet(2)');colorbar;caxis([0 1])
%xlim([60 100]);ylim([0 40])

%hold on ;text(2,24, '.', 'Color', 'red', 'FontSize', 14);
%hold off;
average = nanmean(fd3(:));

% Display the average
disp(average);

sgtitle('total average')
saveas(gcf,'sss.png');

