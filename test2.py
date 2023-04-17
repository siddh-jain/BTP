# open avg .nc file and read data

import netCDF4 as nc
import numpy as np
import matplotlib.pyplot as plt

# open correct .nc file present in the same folder
ds = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.nc')

# read zmla data
zmla = ds['zmla'][:]
print(zmla.shape)

# plot average zmla shading
plt.figure(figsize=(10,10))
plt.pcolormesh(zmla, cmap='jet')
plt.colorbar()

# save plot as a .png file
plt.savefig('zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.png')
