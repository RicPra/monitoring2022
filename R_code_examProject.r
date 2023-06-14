# My exam project
# Analysis of the snow cover on the Adamello Presanella group on the Italian Alps

# With this project I want to look at the variation of the ice cover at the beginning of the summer from
# May/August 2001 to May/August 2022

# The images are a median of the period from the beginning of May to end of August of 2001, 2010, and 2022.

library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

adamello2001 <- brick("landsat2001Adamello.tif")

adamello2010 <- brick("landsat2010Adamello.tif")

adamello2022 <- brick("landsat2022Adamello.tif")

# for landsat the sr_b1 = blue etc..vedi roba rocio (3,2,1 perchè le bande di landsat sono così

#me li plotto tutti e tre per vedere le mie immaginine satellitari
plotRGB(adamello2001, r=3, g=2, b=1, stretch="hist")

plotRGB(adamello2010, r=3, g=2, b=1, stretch="hist")

plotRGB(adamello2022, r=3, g=2, b=1, stretch="hist")


ext <- c(601875, 641215, 5090355, 5130000)
# We use the function "crop()" and we save our new image
adaPresa2001 <- crop(adamello2001, ext)
adaPresa2010 <- crop(adamello2010, ext)
adaPresa2022 <- crop(adamello2022, ext)


plotRGB(adaPresa2001, r=3, g=2, b=1, stretch="hist")


ggplot() + geom_raster(adaPresa2001, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)

ggplot() + geom_raster(adaPresa2010, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)

ggplot() + geom_raster(adaPresa2022, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)


par(mfrow=c(1,3))

plot(adamello2001)
plot(adamello2010)
plot(adamello2022)


# calassificando il ghiaccio, con due classi riesco a distinguere il ghiaccio da tutto il resto
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

rlist <- list.files(pattern="landsat")
import <- lapply(rlist, raster)

adaPresa <- stack(import)

plot(adaPresa)

p1 <- ggplot() + geom_raster(adaPresa$ST_B6, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")

p2 <- ggplot() + geom_raster(adaPresa$layer.2, mapping = aes(x=x, y=y, fill=layer.2)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")

p3 <- ggplot() + geom_raster(AdPrSnow$layer.3, mapping = aes(x=x, y=y, fill=layer.3)) + 
scale_fill_viridis(option="inferno", direction=-1, alpha=0.8) + 
ggtitle("Temperature 2000")


dift = AdPrSnow[[3]] - AdPrSnow[[1]]

p4 <- ggplot() + geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) + 
+ scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
+ ggtitle("Difference in temperature from 2000 to 2015")



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
