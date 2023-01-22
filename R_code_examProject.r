# My exam project xdxd

library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

temp <- raster("c_gls_LST_201010200000_GLOBE_GEO_V1.2.1.nc")

ggplot() + geom_raster(temp, mapping = aes(x=x, y=y, fill=LST.Error.Bar)) + scale_fill_viridis(option="mako")

# I have no idea what I have done
