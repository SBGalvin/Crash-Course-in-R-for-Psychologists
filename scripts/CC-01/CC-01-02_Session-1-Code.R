# R/CC-01-02_Session-1-Code.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# This script presents the code for  Session 1 slides
# Script sections:

# 00) Set options and load packages

# 01) R syntax Examples
# 01-1) IQ and Histogram
# 01-2) For-Loops
# 01-3) While-loops
# 01-4) If-else statements

# 02) Good Code/ Bad Code
# 02-1) Write Readable Code
# 02-2) Yearly Nicholas Cage Movie Releases & Drowings (US)
# 02-3) Yearly Nicholas Cage Movie Releases & Drowings (US)
# 02-4) Yearly Nicholas Cage Movie Releases & Drowings (US)
# 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# 00) Set options and load packages ---------------------------------------

# Options
options(
  scipen = 999, # turns off scientific notation (useful for p values)
  stringsAsFactors = FALSE # not necessary for R v 4.0.0 and greater
)

set.seed(42) # when randomisation is used, this helps to make the randomisation reproducible

# INSTALL
# install this if you already have not.
# you can check by running the foll
# check to see if "readr" is in the install.packages list before you install

#install.packages("readr") 


# 01) R syntax examples ---------------------------------------------------

# 01-1) IQ and Histogram -----------------

# Generate 1000 normally distributed values
IQ <- rnorm(
  # number of random draws
  n = 1000, 
  # mean of distribution
  mean = 100, 
  # standard deviation of distribution
  sd = 15
)

length(IQ)    # Number of values in IQ
head(IQ)      # view the first 6 entries using head()
tail(IQ)      # view the last 6 entries using tail()
summary(IQ)   # view a summary of the IQ variable
mean(IQ)      # mean of sample
median(IQ)    # median of sample
sd(IQ)        # standard deviation of sample
min(IQ)       # view sample minimum
max(IQ)       # view sample maximum
range(IQ)     # value range, prints min and max

# make a dataframe summary
IQ_Summary <- data.frame(N = length(IQ),         # Number of values in IQ
                         Mean = mean(IQ),        # Mean of sample
                         Median = median(IQ),    # Median of sample
                         StDev = sd(IQ),         # Standard deviation of sample
                         Min = min(IQ),          # View sample minimum
                         Max = max(IQ))          # View sample maximum

IQ_Summary # view the summary data frame

# Histogram of IQ
hist(IQ) # prints to viewer/plots panel




# 01-2) For-Loops

x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

# initialise null variables
x2 <- NULL
x3 <- NULL
x.df <- data.frame()

# For loop
for (i in 1:length(x)) {
  
  x2 <- x[i]^2
  x3 <- x[i]^3
  
  # temporary data frame
  tmp.df <- data.frame(a = x[i], b = x2, c = x3)
  
  # output object
  x.df <- rbind(x.df, tmp.df)
  
}

# Print the data frame output to console
x.df



# 02) Good Code/ Bad Code -------------------------------------------------

# 02-1) Write Readable Code ---------

# Crap Rcode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
xX= rnorm(10000,100,15)
Xx =rnorm(10000, 37, 1.6)

# Good Rcode ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Generates 10k,random values 
iq.sim  <-  rnorm(n = 10000, mean = 100, sd = 15) # IQ variable
b5.sim <-  rnorm(n = 10000, mean = 37, sd = 1.6) # open.b5 variable

# create a data frame
iq_b5_df <- data.frame(IQ = iq.sim, B5 = b5.sim)

# Plot a histogram ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hist(iq.sim,
     main = "Histogram of Sample IQ", # plot title
     col = "steelblue",               # Set Bar Colour
     border = "white")                # Set bar edge colour

# Plot a scatter plot ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
plot(
  x = iq_b5_df$IQ,
  y = iq_b5_df$B5,
  cex = 2,
  col = "steelblue",
  main = "IQ x B5"
)


# 02-2) Yearly Nicholas Cage Movie Releases & Drowings (US) -----

# Data ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# read in the csv file
NC <- readr::read_csv("data/CC-01/NicCage.csv")

# Correlation ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# create the correlation value
CORRR <- cor.test(NC$Nicholas_Cage, NC$Drownings)

# Plot points for Nicholas Cage movies
with(     # with() allows you to use a function with data
  NC, # data
  # Plot ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  plot(Year, Nicholas_Cage,                                           # Data Columns
       # Plot point settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~
       pch = 21,      # Point Shape
       cex = 2,        # point size
       col = "grey10", # Point outline colour
       bg = "tomato",  # point fill colour
       
       # Plot labels ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       main = paste0("Yearly Nicholas Cage Films and Drownings (US): ",
                     "r  = ", round(CORRR$estimate, 3)),  # Main Title
       xlab = "Year(1999: 2009)",                                     # X axis label
       ylab = "Number of Nicholas Cage Films")                        # Y axis label
) 
# Add lines ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(new=T) # add a new parameter to the plot
lines(
  NC$Year,         # X-axis
  NC$Nicholas_Cage # Y- axis
) 

# Add points for n Drownings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(new = T)        # Add another new parameter for points              
with(   # with() allows you to use a function with data
  NC,   # Data
  plot(Year, 
       Drownings,                                   # Data Columns
       pch = 21, cex = 2, col="grey10", 
       bg="dodgerblue2", # Set point colours and values
       axes=F,                                            # Turn off axes values
       xlab=NA,                                           # No label
       ylab=NA),                                          # No label
)
# Lines for Drownings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
par(new = TRUE)              # new paramater
lines(NC$Year, NC$Drownings) # data for lines

# Add the  plot legend ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
legend("topleft",                                      # legend position
       legend=c("Nicholas Cage Films", "Drownings"),   # Legend labels
       lty=c(0,0),                                     # line type
       pch=c(21, 21),                                  # point type
       col=c("tomato", "dodgerblue2"))                 # point colour
# Secondary axis ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
axis(side = 4)# Secondary axis -> side 4
mtext(side = 4, line = 0, 'Number of Drownings (US)') # secondary axis label