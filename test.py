# open .nc file and read data

import netCDF4 as nc
import numpy as np
import matplotlib.pyplot as plt

# open correct .nc file present in the same folder
ds = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19500101-19591231.nc')

# average zmla over the whole time period
zmla = ds['zmla'][:,:,:].mean(axis=0)

# plot average zmla shading
plt.figure(figsize=(10,10))
plt.pcolormesh(zmla, cmap='jet')
plt.colorbar()
plt.savefig('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19500101-19591231_avg.png')


# do the same for the other files
# zmla_Eday_CESM2_amip_r1i1p1f1_gn_19600101-19691231.nc
# zmla_Eday_CESM2_amip_r1i1p1f1_gn_19700101-19791231.nc

# open correct .nc file present in the same folder
ds = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19600101-19691231.nc')

# average zmla over the whole time period
zmla = ds['zmla'][:,:,:].mean(axis=0)

# plot average zmla shading
plt.figure(figsize=(10,10))
plt.pcolormesh(zmla, cmap='jet')
plt.colorbar()
plt.savefig('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19600101-19691231_avg.png')

# open correct .nc file present in the same folder
ds = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19700101-19791231.nc')

# average zmla over the whole time period
zmla = ds['zmla'][:,:,:].mean(axis=0)

# plot average zmla shading
plt.figure(figsize=(10,10))
plt.pcolormesh(zmla, cmap='jet')
plt.colorbar()
plt.savefig('zmla_Eday_CESM2_amip_r1i1p1f1_gn_19700101-19791231_avg.png')


 



