# My exam project
# Analysis of the snow cover on the Adamello Presanella group on the Italian Alps

# With this project I want to look at the variation of the ice cover at the beginning of the summer from
# May/August 2001 to May/August 2029

# The images are a median of the period from the beginning of May to end of August of 2001, 2010, and 2019.

library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)


setwd("/Users/Ricky/Documents/MONITORING/examProject_RiccardoPrandi")

adamello2001 <- brick("landsat2001Adamello.tif")

adamello2010 <- brick("landsat2010Adamello.tif")

adamello2019 <- brick("landsat2019Adamello.tif")


# for landsat the sr_b1 = blue etc..vedi roba rocio (3,2,1 perchè le bande di landsat sono così

pdf("satimages.pdf")

#me li plotto tutti e tre per vedere le mie immaginine satellitari
plotRGB(adamello2001, r=3, g=2, b=1, stretch="hist")

plotRGB(adamello2010, r=3, g=2, b=1, stretch="hist")

plotRGB(adamello2019, r=3, g=2, b=1, stretch="hist")
plot(multivar)
dev.off()

ext <- c(601875, 641215, 5090355, 5130000)
# We use the function "crop()" and we save our new image
adaPresa2001 <- crop(adamello2001, ext)
adaPresa2010 <- crop(adamello2010, ext)
adaPresa2019 <- crop(adamello2019, ext)

par(mfrow=c(1,3))
plotRGB(adaPresa2001, r=3, g=2, b=1, stretch="hist")
plotRGB(adaPresa2010, r=3, g=2, b=1, stretch="hist")
plotRGB(adaPresa2019, r=3, g=2, b=1, stretch="hist")


#con la temperatura
p1 <- ggplot() + geom_raster(adaPresa2001, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)

p2 <- ggplot() + geom_raster(adaPresa2010, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)

p3 <- ggplot() + geom_raster(adaPresa2019, mapping = aes(x=x, y=y, fill=ST_B6)) + 
scale_fill_viridis(option="mako", direction=1)





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

#qua cambia le robe con il dollaro
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

# il fill deve essere la temperatura
p4 <- ggplot() + geom_raster(dift, mapping = aes(x=x, y=y, fill=layer)) + 
+ scale_fill_viridis(option="mako", direction=1, alpha=0.8) + 
+ ggtitle("Difference in temperature from 2000 to 2015")

