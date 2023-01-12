# Today we do Species Distribution Modelling (SDM)
# We estimate the distribution of frogs (?)

# We install a new package we need
install.packages("sdm")

# We recall the packages we need
library(sdm)
library(raster)
library(rgdal)

# Our fancy palette
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)

# We use a function called "system.file()" which is going to show us the path of a certain file
file <- system.file("external/species.shp", package="sdm")
# Now in "file" we have the path to the data
# We want to take the file on this path inside R, so we use the function "shapefile()"
species <- shapefile(file)

# Let's try to plot this file
plot(species)

# Remember if we want some informations about the file we can just write so
species

# Now we do something called subsets
# We select only the presence of the species
presences <- species[species$Occurrence == 1,]
# And the absences
absences <- species[species$Occurrence == 0,]

# See if it worked
presences$Occurrence
absences$Occurrence

# Now we can plot them all together
plot(presences,col='blue',pch=16)
points(absences,col='red',pch=8)

# We want to do predictions of presences or absences
# We have to search the path of the folder where the predictors are
path <- system.file("external", package="sdm")
# Inside this folder we have to take the files with .asc extention, which is an image extention
# So we save all the paths of the files with that extention
lst <- list.files(path=path,pattern="asc$",full.names = TRUE)

# We use the "stack()" function for the predictors
preds <- stack(lst)
# And plot
plot(pred)

# Now we build the model
datasdm <- sdmData(train = species, predictors = preds)

# To build the model we use the "sdm()" function
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# The tilde is the same as writing the equal

# We predict the distribution based on our model with our predictors
p1 <- predict(m1, newdata=preds)

# We plot now the probability of the spread of the species
plot(p1)
# This is a probability from 0 to 1

# We can stack all together
finalstack <- stack(preds, p1)
# And we plot
plot(finalstack, col=cl)

# Now we have the possibility to predict and understand why frogs are there or not yey
