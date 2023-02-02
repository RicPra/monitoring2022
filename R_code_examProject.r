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

# provo a fare la differenza degli anni (?)
diff <- temp2020 - temp2010

ggplot() + geom_raster(diff, mapping = aes(x=x, y=y, fill=layer ))+ scale_fill_viridis(option="mako")



p1 <- ggplot() + geom_raster(temp2010, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p2 <- ggplot() + geom_raster(temp2015, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

p3 <- ggplot() + geom_raster(temp2020, mapping = aes(x=x, y=y, fill=Land.Surface.Temperature )) + scale_fill_viridis(option="mako")

#coordinate marsiglia e vienna
ext <- c(5, 43, 16, 48)
temp2020europe <- crop(temp2020, ext)
# I have no idea what I have done

# forse è meglio usare file tiff, che ci sta più roba su virtuale e magari si può fare qualcosa in più


snow2006 <- raster("c_gls_SWE5K_200603200000_NHEMI_SSMIS_V1.0.2.nc")

#coordinate marsiglia e vienna
ext <- c(5, 43, 16, 48)
snow2006alps <- crop(snow2006, ext)

snow2010 <- raster("c_gls_SWE5K_201003200000_NHEMI_SSMIS_V1.0.2.nc")

#coordinate marsiglia e vienna
ext <- c(5, 43, 16, 48)
snow2010alps <- crop(snow2010, ext)

snow2022 <- raster("c_gls_SWE5K_202203200000_NHEMI_SSMIS_V1.0.2.nc")

#coordinate marsiglia e vienna
ext <- c(5, 43, 16, 48)
snow2022alps <- crop(snow2022, ext)


temp2015 <- raster("c_gls_LST_201507031300_GLOBE_GEO_V1.2.1.nc", varname="LST")

temp2020 <- raster("c_gls_LST_202007031300_GLOBE_GEO_V1.2.1.nc", varname="LST")


# Study of the ice melting in Greenland due to increasing temperature

# Packages we need
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


# We import the data we need, setting the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")
lst_2000 <- raster("lst_2000.tif")

# Now we plot it with ggplot(), using the raster geometry, to see the situation in Greenland in 2000
ggplot() + geom_raster(lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + scale_fill_viridis(option="inferno", direction=-1)
# We can reverse the legend in the map by adding "direction=-1" in the function "scale_fill_viridis()"
# In this map we see the temperature of the area, which is correlated to the ice melting
# We can put also a title with the function "ggtitle()"
ggplot() + geom_raster(lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")
# We changed also the transparency in the plot by adding the argument "alpha=0.8" in the function "scale_fill_viridis()"
# The higher the alpha, the lower will be the transparency

# Now we upload all the data from the other years
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# And we plot all the images
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# But we want to speed up the plotting process, immagine having hundred of data to plot, kinda boring ew
# We make a loop using a function called "lapply()"
# But first of all we have to make the list of the files with the function "list.files()"
# We say to the function a pattern in common in the files that it should search and upload, and save them
rlist <- list.files(pattern="lst")
# Now we can use the "lapply()" function using the list we made, and save in a variable we call "import"
import <- lapply(rlist, raster)
# And we stack all together with a final function called "stack()"
# And we save in a variable called "Temperature of Greenland"
ToG <- stack(import)

# Finally to plot all the data we can simply do like this
plot(ToG)
# Better with ggplot. We can say the name of the element "ToG$lst_2000" or the position "ToG[[1]]"
p1 <- ggplot() + geom_raster(ToG$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")

p2 <- ggplot() + geom_raster(ToG$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")

p1 + p2
# Now we can see the difference in temperature from 2000 to 2015 in Greenland :(
# We kept the legend inverted to see better the correlation with ice

# Let's make the difference between 2015 and 2000, to see the changes, but we maintain the normal legend
dift = ToG[[4]] - ToG[[1]]
p3 <- ggplot() + geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
ggtitle("Difference in temperature from 2000 to 2015")

p1 + p2 + p3


# Finally let's see the plotRGB
plotRGB(ToG, r=1, g=2, b=4, stretch="lin")
# So in a single plot we can stack three layers all together
# If the plot is becoming green/blue it means that now temperature are higher than in the past
