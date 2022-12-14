# Community ecology
# We are going to make multivariate analysis

# We install a new package called "vegan()" which means VEGetation ANalysis
install.packages("vegan")

library(vegan)

# We should upload some data using the path of our directory as ususal
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# To read the data we are not using the function "read.data()" as usual
# We use the "load()" function that reloads saved datasets
load("biomes_multivar.RData")

# Now that the project is completely imported we use the "ls()" function to see what files are inside
ls()

# We use the function "decorana()" which performs detrended correspondence analysis
multivar <- decorana(biomes)
# This squeezes in just two axes all the plots of the table "biomes"
# Let's see
plot(multivar)

# We have taken a plot of 20 species and we can see all of them in only two axes
# But how to see all the biomes? We have a label in a different table that gives all the informations we need
attach(biomes_types)
# We use a function called "ordiellipse()" which ordinate plots in a new space
ordiellipse(multivar, type, col=c("black", "red", "green", "blue"), kind="ehull", lwd=3)
# And we see an ellipse that connects every data of the same biome

# Now we use another function called "ordispider()" to connect the points of a certain biome to their biome label
ordispider(multivar, type, col=c("black", "red", "green", "blue"), label=TRUE)

# Now we export our output, making a pdf of our graph
# We are going to save it out of R, and put in the pdf all the graph I want
pdf("myfirstoutput.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black", "red", "green", "blue"), kind="ehull", lwd=3)
ordispider(multivar, type, col=c("black", "red", "green", "blue"), label=TRUE)
# We have to close the pdf, to say that we put everything we wanted in it. The function "dev.off()" in R is used to close things
dev.off()

# Let's try to make a pdf just with the plot of multivar
pdf("mysecondoutput.pdf")
plot(multivar)
dev.off()
