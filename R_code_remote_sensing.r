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
clric <- colorRampPalette(c("dodgerblue4", "cornflowerblue", "aliceblue"))(200)
plot(p224r63_2011[[1]], col=clr)

# If we want to plot one image beside the other we do like this
par(mfrow=c(1,2))
# This is an array with columns and rows, prepared to recive data inside of it
plot(p224r63_2011[[1]], col=clric)
plot(p224r63_2011[[2]], col=cl)

# Let's make the first four images now, yeyy!!! :)))
par(mfrow=c(2,2))
plot(p224r63_2011[[1]], col=clric)
plot(p224r63_2011[[2]], col=clric)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)

# Let's plot all these four bands with different legends (color ramps)
# Every plot with its own color palette
par(mfrow=c(2,2))
clb <- colorRampPalette(c("darkblue", "blue", "lightblue"))(100)
plot(p224r63_2011[[1]], col=clb)
clg <- colorRampPalette(c("chartreuse4", "green", "chartreuse"))(100)
plot(p224r63_2011[[2]], col=clg)
clr <- colorRampPalette(c("red4", "red2", "red"))(100)
plot(p224r63_2011[[3]], col=clr)
clnir <- colorRampPalette(c("orchid4", "orchid", "plum1"))(100)
plot(p224r63_2011[[4]], col=clnir)


# Now we make a multilayer image (3 layer immage)
# We use three components: Red, Green and Blue
# For mounting the bands together we use these three bands, which will be how we would see with our eyes
# We plot every band above the other, unsing the function "plotRGB()", assigning each lens at its band
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
# In our image the red was the band number 3, the green the number 2 and the blue the number 1
# With this visualisation is difficult to discriminate all the things, so we use also the near infrared
# But we should choose to remove one of the other three bands RIP
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
# Now we see in red all the vegetation which reflects a lot in the near infrared

# Now we try to put the infrared instead of the green band
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
# And we see the vegetatation in fluorescent green and the bare soil in violet

# Now we try to put the near infrared in the blue channel
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")
# So we see in blue all the vegetation and we see better all the human activities ew

# We plot now all the previous four manners in a single multiframe
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")

# Let's see the histogram stretching, putting hist instead of lin in the stretch
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
# With the histogram stretching we can se better the bare soil in the middle of the forest, which is a bit sus

# Same with other colors
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")


# Now we are going to upload new data, as usual
setwd("/Users/Ricky/Documents/MONITORING/LAB")
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# We are going to use both of the data to make some calculations

# We use the function "plotRGB()" as above
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="lin")
# This is our visual perception, so as above we use the infrared band, to see better the vegetation, that is going to be in red
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
# Or in green
plotRGB(p224r63_1988, r=3, g=4, b=2, stretch="lin")

# Now we plot a multiframe with 2 rows and one column, with the 1988 and the 2011 images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
# Better to put the near infrared in the blue channel, so we are going to see the bare soil in yellow
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=4, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")


# MULTITEMPORAL ANALYSIS
# We are now going to take the two immages and subtract the bands to see what is changed
# If we see changes in the near infrared this means that some trees had been cutted
# We are going to do this for every pixel (more or less 4.5 millions)
difnir <- p224r63_1988[[4]] - p224r63_2011[[4]]
# Now we plot it with a color palette to see the changes
cl <- colorRampPalette(c("orange", "yellow", "black"))(100)
plot(difnir, col=cl)
# So we see in black all the changes in vegetation

# We are going to focus on the Normalized Difference Vegetation Index
# If the vegetation is suffering, the value of the near infrared is decreasing and the red is increasing

# First we caluclate and plot the DVI of 2011
dvi2011 <- p224r63_2011[[4]] - p224r63_2011[[3]]
plot(dvi2011)
# Then we caluclate and plot the DVI of 1988
dvi1988 <- p224r63_1988[[4]] - p224r63_1988[[3]]
plot(dvi1988)

# Now we see the difference between the two DVI
difdvi <- dvi1988 - dvi2011
cl <- colorRampPalette(c("blue", "white", "red"))(100)
plot(difdvi, col=cl)
# All the red part show a loss in vegetation, if we see blue that means that there is a more healty vegetation
# (Which usually is not natural but is vegetation of the agriculture)
