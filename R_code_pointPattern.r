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
# Let's use a function called "ppp" to create a planar point pattern
# We should say which are the coordinates (lon and lat) and say the range of the data
attach(covid)
covid_planar <- ppp(x=lon, y=lat, c(-180,180), c(-90,90))
# Note we have assigned an object to the ppp function, and first we have attached covid (or we had to use i.e. "x=covid$lon")

# Try to plot the data
plot(covid_planar)

