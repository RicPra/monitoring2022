# Study of the ice melting in Greenland due to increasing temperature

# Packages we need
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)


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
