# Exam project
# Analysis of the snow cover on the Adamello Presanella group on the Italian Alps

# With this work I want to look at the variation of the snow cover 
# of summer from May/August 2001 to May/August 2019.

# The images are from the satellite Landsat 7 which has data avaiable from 1999 to 2023
# The images are a median of the period from the beginning of May to end of August of 2001, 2010, and 2019.


# First of all I recall all the packages I will need for this work
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)

# Now I import the data, setting the work directory
setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

# and saving them using the function brick from the package raster
adamello2001 <- brick("landsat2001Adamello.tif")
adamello2010 <- brick("landsat2010Adamello.tif")
adamello2019 <- brick("landsat2019Adamello.tif")

# I plot the data with the function "plotRGB()" to have a look at the images
plotRGB(adamello2001, r=3, g=2, b=1, stretch="hist")
plotRGB(adamello2010, r=3, g=2, b=1, stretch="hist")
plotRGB(adamello2019, r=3, g=2, b=1, stretch="hist")
# In this case I put r=3, g=2 and b=1 because the data from Landsat 7 have the red, green and blue bands in those positions

# For Landsat 7 the SR_B1 = blue, SR_B2 = green, SR_B3 = red and ST_B6 = surface temperature (which I need it later)

# I want to work only with data of the Adamello Presanella group so I cut the map
# For doing so I have to put in a variable the minimum and maximum cordinates
ext <- c(601875, 641215, 5090355, 5130000)
# I use the function "crop()" and save the new image to work on those
adaPresa2001 <- crop(adamello2001, ext)
adaPresa2010 <- crop(adamello2010, ext)
adaPresa2019 <- crop(adamello2019, ext)

# I save and look at the new images
jpeg("AdamelloPresanella2001.jpeg")
plotRGB(adaPresa2001, r=3, g=2, b=1, stretch="hist", axes=TRUE, main="Adamello Presanella - 2001")
dev.off()

jpeg("AdamelloPresanella2010.jpeg")
plotRGB(adaPresa2010, r=3, g=2, b=1, stretch="hist", axes=TRUE, main="Adamello Presanella - 2010")
dev.off()

jpeg("AdamelloPresanella2019.jpeg")
plotRGB(adaPresa2019, r=3, g=2, b=1, stretch="hist", axes=TRUE, main="Adamello Presanella - 2019")
dev.off()


# QUESTA PARTE NON CREDO ABBIA TROPPO SENSO IN CASO TAGLIARE

# Now, using the surface temperature, I try to see if there were changes in the years of the snow cover
# I make and save the plots
p1 <- ggplot() + geom_raster(adaPresa2001, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + ggtitle("Temperature 2001")
p2 <- ggplot() + geom_raster(adaPresa2010, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + ggtitle("Temperature 2010")
p3 <- ggplot() + geom_raster(adaPresa2019, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + ggtitle("Temperature 2019")

jpeg("Temperature2001.jpeg")
p1
dev.off()

jpeg("Temperature2010.jpeg")
p2
dev.off()

jpeg("Temperature2019.jpeg")
p3
dev.off()

# I now do the difference between the years to see the changes
# Starting from the difference between 2001 and 2010, plotting it and saving it
diff1 <- adaPresa2010$ST_B6 - adaPresa2001$ST_B6
p4 <- ggplot() + geom_raster(diff1, mapping = aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
ggtitle("Difference in temperature from 2001 to 2010")

jpeg("Difference2001-2010.jpeg")
p4
dev.off()

# Then the difference between 2010 and 2019
diff2 <- adaPresa2019$ST_B6 - adaPresa2010$ST_B6
p5 <- ggplot() + geom_raster(diff2, mapping = aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
ggtitle("Difference in temperature from 2010 to 2019")

jpeg("Difference2010-2019.jpeg")
p5
dev.off()

# And then the difference between 2001 and 2019
diff3 <- adaPresa2019$ST_B6 - adaPresa2001$ST_B6
p6 <- ggplot() + geom_raster(diff3, mapping = aes(x=x, y=y, fill=layer)) + 
scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
ggtitle("Difference in temperature from 2001 to 2019")

jpeg("Difference2001-2019.jpeg")
p6
dev.off()



# calassificando il ghiaccio, con tre classi riesco a distinguere il ghiaccio da tutto il resto
# set.seed tiene fermi i valori

# r.code landcover rocio
set.seed(1)
adaPresa2001class <- unsuperClass(adaPresa2001, nClasses = 3)

# 3 per dividere fondo valle, roccia e neve

# value  count
#[1,]     1 469982
#[2,]     2 539187
#[3,]     3 688553
#[4,]    NA  35420

# map perchè il mio oggetto ha due robe dentro
plot(adaPresa2001class$map)

freq(adaPresa2001class$map)

# questa roba non farla...
#rlist <- list.files(pattern="landsat")
#import <- lapply(rlist, raster)
#adaPresa <- stack(import)

#cambiare
plot(adaPresa)


dift = AdPrSnow[[3]] - AdPrSnow[[1]]

# il fill deve essere la temperatura
p4 <- ggplot() + geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) + 
+ scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
+ ggtitle("Difference in temperature from 2000 to 2015")

