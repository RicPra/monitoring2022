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
dvi1992 <- l1992[[1]] - l1992[[2]]
plot(dvi1992, col=cl)

dvi2006 <- l2006[[1]] - l2006[[2]]
plot(dvi2006, col=cl)
