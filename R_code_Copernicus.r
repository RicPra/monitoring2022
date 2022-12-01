# We download and analyse Copernicus data
# In particular we analyse the snow cover

# Copernicus set: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# We need a new package called "ncdf4" to read .nc files
install.packages("ncdf4")
# And we recall all the packages we need
library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)

# Now we import the data, as usual setting our work directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# We use this function called "raster()" from the raster package
snow <- raster("c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")
