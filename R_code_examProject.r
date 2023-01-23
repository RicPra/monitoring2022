# My exam project xdxd

library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

temp2010 <- raster("c_gls_LST_201001180000_GLOBE_GEO_V1.2.1.nc", varname="LST")

temp2014 <- raster("c_gls_LST_201412100100_GLOBE_GEO_V1.2.1.nc", varname="LST")

temp2021 <- raster("c_gls_LST_202101181300_GLOBE_GEO_V1.2.1.nc", varname="LST")



p1 <- ggplot() + geom_raster(temp2010, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p2 <- ggplot() + geom_raster(temp2014, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p3 <- ggplot() + geom_raster(temp2021, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")


# I have no idea what I have done
