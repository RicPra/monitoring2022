# Point pattern analysis for population ecology

# We have to install a new package now called "spatstat"
install.packages("spatstat")
# And then we recall it in R
library(spatstat)

# Use of working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# Read and save our data
covid <- read.table("covid_agg.csv", header=TRUE)

# We should explain to R that we have dimensional points and that it has to pair them
# Let's use a function called "ppp()" to create a planar point pattern
# We should say which are the coordinates (lon and lat) and say the range of the data
attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180,180), c(-90,90))
# Note we have assigned an object to the ppp function, and first we have attached covid (or we had to use i.e. "x=covid$lon")

# Try to plot the data
plot(covid_planar)

# Let's now make a map of density of points, using the function "density()" and assign it to an object
density_map <- density(covid_planar)
# And try to plot the data, adding the original points
plot(density_map)
points(covid_planar, pch=15)

# We can change the colors of our map. The number at the end says how many colors you want in your palette
# We assign our color plaette to a name so we can use later
cl <- colorRampPalette(c("cyan", "coral", "chartreuse"))(100)

# Now we try our palette
plot(density_map, col=cl)
points(covid_planar, pch=17, col="blue")

# Trying a different palette hihi, you can add as many colors as you want
clr <- colorRampPalette(c("aliceblue", "cadetblue1", "cornflowerblue", "darkblue"))(200)
plot(density_map, col=clr)
points(covid_planar, pch=11, col="darkorange1")


# We should install a new package called "rgdal"
install.packages("rgdal")

# We now use a new work directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")
# Then we upload the coastline file using rgdal and the function "readOGE()", assigning it to an object
coastlines <- readOGR("ne_10m_coastline.shp")

# We rebuild the map we made earlier
covid <- read.table("covid_agg.csv", header=TRUE)
attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180,180), c(-90,90))
plot(covid_planar)
# Now we plot the coastlines, saying that it should add it to our plot of the covid_planar
plot(coastlines, add=TRUE)
# We can also plot the density of the data
density_map <- density(covid_planar)
plot(density_map)
points(covid_planar, pch=18, col="green")
plot(coastlines, add=TRUE, col="yellow")

# If we want to change colors we can just do the same as above
