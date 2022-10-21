# This is a code for investigating relationships among ecological variables

# We are using the sp package. To install it use:
# install.packages("sp")

# To recall the package we use the function "library()" or also "require()"
library(sp)

# We are using meuse, search for "meuse dataset R sp package" on google to know what this is
# OMG, JUST GOOGLE IT

# To recall the dataset we can use the function "data()"
data(meuse)

# To see in a savage way the data just write "meuse" and you'll see all that cute numbers
meuse

# There is an other function called "View()" to see data in a more fancy way
# NOTE: use the V in capital letter
View(meuse)

# This gives me an error :(
# Is that because I use a MacBook??? OMG rude

# Errore in View(meuse) : La dataentry X11 non può essere caricata
# In aggiunta: Messaggi di avvertimento:
# 1: In system2("/usr/bin/otool", c("-L", shQuote(DSO)), stdout = TRUE) :
#   il comando in esecuzione ''/usr/bin/otool' -L '/Library/Frameworks/R.framework/Resources/modules/R_de.so'' aveva status 69
# 2: In View(meuse) :
#   non è possibile caricare un oggetto condiviso '/Library/Frameworks/R.framework/Resources/modules//R_de.so':
#   dlopen(/Library/Frameworks/R.framework/Resources/modules//R_de.so, 6): Library not loaded: /opt/X11/lib/libSM.6.dylib
#   Referenced from: /Library/Frameworks/R.framework/Versions/4.2/Resources/modules/R_de.so
#   Reason: image not found
#
# You have not agreed to the Xcode license agreements, please run 'sudo xcodebuild -license' from within a Terminal window to review and agree to the Xcode license agreements.

# To solve this error I updated to the latest version the app Xcode on my computer and agreed the license
# Then I downloaded and installed the package at: https://www.xquartz.org/
# I restarted the computer and the function "View()" didn't give me errors anymore, it's only a bit slow


# Then we use the function "head()" to see only the initial lines of the table
head(meuse)

# To see only the names of the columns we use the function "names()"
names(meuse)

# Now we use the "summary()" function that gives me all the statistical variables I want
summary(meuse)

# We plot two of the columns and we have to say where to take the data so we use the $ symbol, because they are inside the table
# $ is used to link the objects with the variables
plot(meuse$cadmium, meuse$zinc)

# We can put all the column in a new variable
cad <- meuse$cadmium
zin <- meuse$zinc

plot(cad, zin)

# Or you can use the "attach()" function, to attach the datafame to R
attach(meuse)
plot(cadmium, zinc)

# We can change the color, the size and the shape of the dots
plot(cadmium,zinc, col="red", cex=2, pch=24)

# If we use the function "pairs()" it plots every data, pairing between them
pairs(meuse)

# To select only some of the columns of the table (form column n to column m) we have to say it by using [,n:m]
# Note that the commant to say what is the inizial point is comma
meuse[,3:6]

# To plot only the selected data we do simply like this
pairs(meuse[,3:6])

# To assign the selected data in a variable we do so
pol <- meuse[,3:6]

pairs(pol, col="blue", cex=0.2)

# If we want to pair some variable in a less efficient way do like this
# Note that we have to use tilde ~ (Alt + 5 on Mac) because we are clumping the data with plus
pairs(~ cadmium + copper + lead + zinc, data=meuse)


# We have to say to R that the variables are spacial components
# There is a function called "coordinates()" 
coordinates(meuse) = ~x+y

# Now the software understood that x and y are the coordinates
# If we do "plot(meuse)" R will print a spacial graph

# We use the function "spplot()" to plot the elements spread in space
spplot(meuse, "zinc", main="Concentration of Zinc")

# We can make a spacial plot of several variables all together 
spplot(meuse, c("copper","zinc","lead"))

# With the function "bubble()" we are going to change the size of points according to the value, and not the color
bubble(meuse, "zinc", main="Concentration of Zinc")
# This is a more fancy way to show data, because the size of the dots get bigger when the data are higher
# It is much more immediate for eyes a graph like that, and to show data like this. Also babies will understand


# Now we use a new package "ggplot2"
install.packages("ggplot2")

library(ggplot2)

# We are going to create the dataframe, by building two arrays
virus <- c(10, 30, 40, 50, 60, 80)
death <- c(100, 240, 310, 470, 580, 690)
# We want this two arrays in a table. A table is a dataframe, and there is a function that allows us to create one
# We assign the dataframe to a variable
d <- data.frame(virus, death)

# If we want, in example, to see some statistical data of our dataframe we do so
summary(d)

# Now we use ggplot2
# We use the function "ggplot()", which needs the data and the aesthetics of the graph
# We have to say also the geometry of our space, so we use the function "geom_point()", because we want points
ggplot(d, aes(x=virus, y=death)) + geom_point()
# Note that in R you can add two function togheter using "+"

# If we want to change grafic things to make it more fancy we should say it to "geom_point()"
ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="red", pch=11)

# As an example we can use "geom_line()", that connects our points
ggplot(d, aes(x=virus, y=death)) + geom_line(col="blue")

# You can also use more than two function at once
ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="red", pch=11) + geom_line(col="blue")

# Instead of using lines we can use polygons to connect our points, here is no sense but we do it using "geom_polygon()"
ggplot(d, aes(x=virus, y=death)) + geom_point(size=3, col="red", pch=11) + geom_polygon()


