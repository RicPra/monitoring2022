# My exam project xdxd

library(ncdf4)
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

temp2010 <- raster("c_gls_LST_201007031300_GLOBE_GEO_V1.2.1.nc", varname="LST")

temp2015 <- raster("c_gls_LST_201507031300_GLOBE_GEO_V1.2.1.nc", varname="LST")

temp2020 <- raster("c_gls_LST_202007031300_GLOBE_GEO_V1.2.1.nc", varname="LST")



p1 <- ggplot() + geom_raster(temp2010, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p2 <- ggplot() + geom_raster(temp2015, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p3 <- ggplot() + geom_raster(temp2020, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")


ext <- c(-2, 10, 20, 30)
temp2020europe <- crop(temp2020, ext)
# I have no idea what I have done

