# R code for remote sensing data analysis in ecosystem monitoring

# We are using the "raster" package
install.packages("raster")
library(raster)

# As usual we set the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# And we are going to upload the data, using a function called "brick()", telling it the name of the file we need
# The "brick()" function is importing all the data all together
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# We assigned the function to an object obv

# We can plot the single bands in 7 different plots to see how they are
plot(p224r63_2011)

# Let's change color, using the palette we used already
cl <- colorRampPalette(c("cyan", "coral", "chartreuse"))(100)
plot(p224r63_2011, col=cl)

# To see only the plot of the first band (blue) we do like this
plot(p224r63_2011$B1_sre, col=cl)
# If we know the position of the band we can do so, with the quadratic parentesis, using the position and not the name
plot(p224r63_2011[[1]], col=cl)

# Now we try to change some colors xdxd
clr <- colorRampPalette(c("dodgerblue4", "cornflowerblue", "aliceblue"))(200)
plot(p224r63_2011[[1]], col=clr)

# If we want to plot one image beside the other we do like this
par(mfrow=c(1,2))
# This is an array with columns and rows, prepared to recive data inside of it
plot(p224r63_2011[[1]], col=clr)
plot(p224r63_2011[[2]], col=cl)
