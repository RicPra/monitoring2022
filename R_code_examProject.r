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


# Now I check the changes in the amount of snow
# To quantify this I do a classification using the function "unsuperClass()"
# I use 3 classes to divide the snow, the mountains and rocks and everything else
set.seed(4)
adaPresa2001class <- unsuperClass(adaPresa2001, nClasses = 3)
adaPresa2010class <- unsuperClass(adaPresa2010, nClasses = 3)
adaPresa2019class <- unsuperClass(adaPresa2019, nClasses = 3)

# Saving the images
jpeg("Classification2001.jpeg")
plot(adaPresa2001class$map, main="Classification 2001")
dev.off()

jpeg("Classification2010.jpeg")
plot(adaPresa2010class$map, main="Classification 2010")
dev.off()

jpeg("Classification2019.jpeg")
plot(adaPresa2019class$map, main="Classification 2019")
dev.off()


# I can count the number of pixel for each class for each image
freq(adaPresa2001class$map)
# The results are:
# value  count
# [1,]     1 536279
#[2,]     2 458544
#[3,]     3 702899
#[4,]    NA  35420

freq(adaPresa2010class$map)
# The results are:
# value  count
#[1,]     1 170972
#[2,]     2 964758
#[3,]     3 488399
#[4,]    NA 109013

freq(adaPresa2019class$map)
# The results are:
#value  count
#[1,]     1 551081
#[2,]     2 440175
#[3,]     3 619683
#[4,]    NA 122203

# I look at the total pixel for each
adaPresa2001
adaPresa2010
adaPresa2019
# All af them have a total of 1733142 pixels

# And now I can caluclate the proportions of snow on the total for each image
snow2001 <- 536279 / 1733142
snow2010 <- 170972 / 1733142
snow2019 <- 551081 / 1733142

# Now I calculate the percentage of snow and non snow for each period
percSnow2001 <- snow2001 * 100
percSnow2010 <- snow2010 * 100
percSnow2019 <- snow2019 * 100
percRest2001 <- 100 - percSnow2001
percRest2010 <- 100 - percSnow2010
percRest2019 <- 100 - percSnow2019

# Now I make a database to study the changes
landcover <- c("Snow", "Land")
percent_2001 <- c(percSnow2001, percRest2001)
percent_2010 <- c(percSnow2010, percRest2010)
percent_2019 <- c(percSnow2019, percRest2019)

# I use the function "data.frame()" to save the data
perc <- data.frame(landcover, percent_2001, percent_2010, percent_2019)

# And I plot our data with a fancy histogram
p7 <- ggplot(perc, aes(x=landcover, y=percent_2001, color=landcover)) + 
geom_bar(stat="identity", fill="chartreuse") + ggtitle("Percentage of snow and land in 2001")
p8 <- ggplot(perc, aes(x=landcover, y=percent_2010, color=landcover)) + 
geom_bar(stat="identity", fill="chartreuse") + ggtitle("Percentage of snow and land in 2010")
p9 <- ggplot(perc, aes(x=landcover, y=percent_2019, color=landcover)) + 
geom_bar(stat="identity", fill="chartreuse") + ggtitle("Percentage of snow and land in 2019")

# Let's have a look
p7 + p8 + p9

# And I save them
jpeg("Percentage2001.jpeg")
p7
dev.off()

jpeg("Percentage2010.jpeg")
p8
dev.off()

jpeg("Percentage2019.jpeg")
p9
dev.off()
