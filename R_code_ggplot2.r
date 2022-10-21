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



# Now we are using data from outside R, so we have to connect R with the folder were our own data are
# So we have to set the working dirctory, saying the path where to find the file with data
# This is the path for Mac
setwd("/Users/Ricky/Documents/MONITORING/LAB")

# We use a function called "read.table()" and we have to say if there is a head of the table, what are the separators of the different columns
# We assign the table to an object
covid <- read.table("covid_agg.csv", header=TRUE)

