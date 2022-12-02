# Study of the ice melting in Greenland due to increasing temperature

# Packages we need
library("raster")
library("RStoolbox")
library(ggplot2)

# We import the data we need, setting the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")
lst_2000 <- raster("lst_2000.tif")

# Now we plot it with ggplot()
ggplot() + geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) + scale_fill_viridis(option="mako")
