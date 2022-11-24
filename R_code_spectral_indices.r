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
