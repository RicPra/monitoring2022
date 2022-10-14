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
Errore in View(meuse) : La dataentry X11 non può essere caricata
In aggiunta: Messaggi di avvertimento:
1: In system2("/usr/bin/otool", c("-L", shQuote(DSO)), stdout = TRUE) :
  il comando in esecuzione ''/usr/bin/otool' -L '/Library/Frameworks/R.framework/Resources/modules/R_de.so'' aveva status 69
2: In View(meuse) :
  non è possibile caricare un oggetto condiviso '/Library/Frameworks/R.framework/Resources/modules//R_de.so':
  dlopen(/Library/Frameworks/R.framework/Resources/modules//R_de.so, 6): Library not loaded: /opt/X11/lib/libSM.6.dylib
  Referenced from: /Library/Frameworks/R.framework/Versions/4.2/Resources/modules/R_de.so
  Reason: image not found

You have not agreed to the Xcode license agreements, please run 'sudo xcodebuild -license' from within a Terminal window to review and agree to the Xcode license agreements.



# Then we use the function "head()" to see only the initial lines of the table
head(meuse)

# To see only the names of the columns we use the function "names()"
names(meuse)

# Now we use the "summary()" function that gives me all the statistical variables I want
summary(meuse)

# We plot two of the columns and we have to say where to take the data so we use the $ symbol
plot(meuse$cadmium, meuse$zinc)

# We can put all the column in a new variable
cad <- meuse$cadmium
zin <- meuse$zinc

plot(cad, zin)

# Or you can use the "attach()" function
attach(meuse)
plot(cadmium, zinc)

# If we use the function "pairs()"
pairs(meuse)
