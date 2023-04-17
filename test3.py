# open all the .nc files in the folder and store the average zmla in a another .nc file

import netCDF4 as nc
import numpy as np
import matplotlib.pyplot as plt
import glob

# open all the .nc files in the folder
files = glob.glob('*.nc')

# create a new .nc file to store the average zmla
ds_out = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.nc', 'w', format='NETCDF4')
ds_out.createDimension('lat', 192)
ds_out.createDimension('lon', 288)
ds_out.createVariable('zmla', 'f4', ('lat', 'lon'))
ds_out.variables['zmla'][:] = 0
ds_out.close()

# loop over all the files
for file in files:
    # check if the file is the new .nc file
    if file == 'zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.nc':
        continue

    ds = nc.Dataset(file)

    # read zmla data
    zmla = ds['zmla'][:,:,:].mean(axis=0)
    # add the average zmla to the new .nc file
    ds_out = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.nc', 'a', format='NETCDF4')
    ds_out.variables['zmla'][:] += zmla
    ds_out.close()

# divide the sum of all the zmla by the number of files to get the average
ds_out = nc.Dataset('zmla_Eday_CESM2_amip_r1i1p1f1_gn_avg.nc', 'a', format='NETCDF4')
ds_out.variables['zmla'][:] /= len(files)
ds_out.close()

# # plot average zmla shading
# plt.figure(figsize=(10,10))
# plt.pcolormesh(ds_out.variables['zmla'][:], cmap='jet')
# plt.colorbar()
# plt.show()
