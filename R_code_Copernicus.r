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

# And we plot them using mako, because is kinda cute to see the snow cover
ggplot() + geom_raster(snow, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) + scale_fill_viridis(option="mako")

# And if we want to work only with data from Europe, for example, we can cut the map with certain coordinates
# We have to put in a variable our minimum and maximum cordinates
ext <- c(-20, 70, 20, 75)
# We use the function "crop()" and we save our new image
snowEurope <- crop(snow, ext)
# And we plot only Europe
ggplot() + geom_raster(snowEurope, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) + scale_fill_viridis(option="inferno")

