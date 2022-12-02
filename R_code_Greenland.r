# Study of the ice melting in Greenland due to increasing temperature

# Packages we need
library("raster")

# We import the data we need, setting the working directory
setwd("/Users/Ricky/Documents/MONITORING/LAB")
lst_2000 <- raster("lst_2000.tif")

# Now we plot it with ggplot()
