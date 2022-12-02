# Study of the ice melting in Greenland due to increasing temperature

# Packages we need
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)


# We import the data we need, setting the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")
lst_2000 <- raster("lst_2000.tif")

# Now we plot it with ggplot(), using the raster geometry
ggplot() + geom_raster(lst_2000, mapping=aes(x=x, y=y, fill=lst_2000)) + scale_fill_viridis(option="inferno")

