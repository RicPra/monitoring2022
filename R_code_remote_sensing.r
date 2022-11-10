# R code for remote sensing data analysis in ecosystem monitoring

# We are using the "raster" package
install.packages("raster")
library(raster)

# As usual we set the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# And we are going to upload the data, using a function called "brick()", telling it the name of the file we need
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# We assigned the function to an object obv

# We can plot the single bands in 7 different plots to see how they are
plot(p224r63_2011)

# Let's change color, using the palette we used already
