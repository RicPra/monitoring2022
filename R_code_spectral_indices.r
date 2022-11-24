# Calculating vegetation indices from remote sensing
# We want to see if trees had

# Recalling the package we need as usual
library(raster)

# Setting the folder as usual, and taking the data we need
setwd("/Users/Ricky/Documents/MONITORING/LAB")
l1992 <- brick("defor1.png")

# Our bands are: 1 NearInfraRed, 2 Red, 3 Green
# Now we plot our image
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
