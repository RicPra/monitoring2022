# We download and analyse Copernicus data

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
