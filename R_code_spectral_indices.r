# Calculating vegetation indices from remote sensing
# We want to see if trees had been cutted or nope

# Recalling the package we need as usual
library(raster)

# Setting the folder as usual, and taking the data we need
setwd("/Users/Ricky/Documents/MONITORING/LAB")
l1992 <- brick("defor1.png")

# Our bands are: 1 NearInfraRed, 2 Red, 3 Green
# Now we plot our image
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# And then for the other image
l2006 <- brick("defor2.png")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# We plot them together to see the same image in two different periods
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Now we are going to calculate some indices to demonstrate that there were some big changes in that area
# We first caluclate de vegetation indices and then we compare the final results
# Let's make my fancy palette first
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)

# REMINDER: NIR - R = DVI
# Now we calculate the index and we plot them
dvi1992 <- l1992[[1]] - l1992[[2]]
plot(dvi1992, col=cl)

dvi2006 <- l2006[[1]] - l2006[[2]]
plot(dvi2006, col=cl)


# Let's see now if someone cutted some trees  :(

# Now we need to racall another package that we use for classification
library(RStoolbox)

# Threshold for trees
# To do the classifications we use the function "unsuperClass()"
d1c <- unsuperClass(l1992, nClasses=2)
# Note: we have to say the number of classes we want
plot(d1c$map)

# To see the number of pixels of our two classes we do like this
freq(d1c$map)
# Class 1 = forest - 305131
# Class 2 = human impact - 36161

# Now we caluclate the proportions of the nature and the human impacts
# This one for forest
f1992 <- 305131 / (305131 + 36161)
# This one for human impacts
h1992 <- 36161 / (305131 + 36161)

# Let's do the same for 2006
d2c <- unsuperClass(l2006, nClasses=2)

freq(d2c$map)
# Class 1 = forest - 178138
# Class 2 = human impact - 164588

f2006 <- 178138 / (178138 + 164588)
h2006 <- 164588 / (178138 + 164588)

# The proportion we calculated are these
# Class 1, 1992 = forest - 0.8940467
# Class 2, 1992 = human impact - 0.1059533
# Class 1, 2006 = forest - 0.519768
# Class 2, 2006 = human impact - 0.480232


# Now we make our database to study the changes
landcover <- c("Forset", "Humans")
percent_1992 <- c(89.40, 10.60)
percent_2006 <- c(51.98, 48.02)

# In R the database are called dataframe, we use the function "data.frame()"
perc <- data.frame(landcover, percent_1992, percent_2006)

# Now we have to use the package "ggplot2" so we have to recall it
library(ggplot2)
# And we plot our data with a fancy histogram yey
ggplot(perc, aes(x=landcover, y=percent_1992, color=landcover)) + geom_bar(stat="identity", fill="chartreuse")
ggplot(perc, aes(x=landcover, y=percent_2006, color=landcover)) + geom_bar(stat="identity", fill="chartreuse")

# Now we use another fancy package called "patchwork"
install.packages("patchwork")
library(patchwork)

# We assign the two plots to objects and we make one plus the other
p1 <- ggplot(perc, aes(x=landcover, y=percent_1992, color=landcover)) + geom_bar(stat="identity", fill="chartreuse")
p2 <- ggplot(perc, aes(x=landcover, y=percent_2006, color=landcover)) + geom_bar(stat="identity", fill="chartreuse")
# And now we can see the two histograms one beside the other to have a more clear look
p1 + p2

# Just for fun we try to put the first plot on top of the other
p1 / p2


# Now we plot the images in RGB
# Band 1 is the NIR
plotRGB(l1992, r=1, g=2, b=3)
# Or we can do like this
ggRGB(l1992, 1, 2, 3)

# But we can plot also the DVI (Difference Vegetation Index), as above
dvi1992 = dvi1992 <- l1992[[1]] - l1992[[2]]
plot(dvi1992, col=cl)

# We need a new package called "viridis" to make use of a new function for daltonic people to see all the difference in maps
install.packages("viridis")
library(viridis)

# Or we can make use of ggplot with a new geometry, geom_raster
pp1 <- ggplot() + geom_raster(dvi1992, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option="viridis") + 
ggtitle("Multispectral Rao")
# We used also the function "scale_fill_viridis()" to make the map visible for daltonic people, using "viridis" in the options
# We can use whatever option we want, so we don't have to use the colorRampPalette
pp2 <- ggplot() + geom_raster(dvi1992, mapping=aes(x=x, y=y, fill=layer)) + scale_fill_viridis(option="inferno") +
ggtitle("Multispectral Rao")

# And we plot the two plots together
pp1 + pp2
