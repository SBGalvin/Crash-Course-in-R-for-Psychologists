# R/CC-01-03_Exercise-1_t-test.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Sections:
          # 00) Reading in data
          # 01) Summarizing data
                # 02-1) Summary
                # 02-2) Summary by group
                # 02-3) Summarize as a dataframe

          # 03) Visualising data
                # 02-1) Histograms
                # 02-2) Box plot
                # 02-3) Plot everything together
          # 04) Analysing data
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# Set options and Load Packages -------------------------------------------
options(
  stringsAsFactors = FALSE,
  scipen = 999
)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 00) Read in data --------------------------------------------------------
# Data are stored as a ".RDS" object
# Read in data
Exercise_1_data <- readRDS('data/CC-01/Exercise_1.rds')  # The values enclosed in quotes are filepaths
                                                         # this tells R where to look to read the desired file

# view structure
str(Exercise_1_data) # multiple data frames are stored inside the Exercise_1_data object

# access the relevant data buy subsetting using the $ operator
mydata <- Exercise_1_data$G1 

head(mydata) # peek at the first 6 rows ## 3 columns: ID, Group, Measure
str(mydata)  # This tells us the structure of the object
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 01) Summarise Data ------------------------------------------------------

# 02-1) Summary -----
summary(mydata$Group)   # Group variable
levels(mydata$Group)    # factor levels
summary(mydata$Measure) # Measure variable

# 02-2) Summary by group ----------------------------------------
# We need to group our data to get a summary value per group A and Group B

# 02-2-1) using subset method ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
my_data_A <- mydata[mydata$Group == "A", ]
my_data_B <- mydata[mydata$Group == "B", ]

summary(my_data_A)
summary(my_data_B)

# 02-2-2 using with() ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
with( mydata , 
      aggregate(
        mydata, 
        by=list(Group) , 
        FUN=summary)
      )

# 02-2-3 Using describe and describeBy from the psych package ~~~~~~~~~~~~~~
psych::describe(mydata$Measure) # total measure
psych::describeBy(mydata$Measure, group = mydata$Group, mat = TRUE) # measure by group


# 02-3) Summary to dataframe ---------------------------------------
# Storing this as a dataframe object
mydata_summary <- as.data.frame(psych::describeBy(mydata$Measure, group = mydata$Group, mat = TRUE))

# This method is a bit neater as you don't need to create multiple objects
mydata_summary

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 02) Plot Data -----------------------------------------------------------
# In this section we will plot our data before we perform statistical analysis on it
# We will need a an idea of the total and group distributions
# We will to visualise the mean differences between groups

# 02-1) Histograms -----------
# All Measure Data
# Histogram of All responses ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hist(mydata$Measure,                            # Select variable
     main = "Histogram : All Values",           # Set main title
     xlab = "Response Variable",                # Set x axis title
     col = "white",                             # Set bar fill Colour
     border = "black"                           # Set bar edge colour
)

# Group A ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hist(mydata$Measure[mydata$Group == "A"],       # Select variable 
     main="Histogram : Group A",                # Set main title
     xlab="Response Variable",                  # Set x axis title
     col = "chocolate",                         # Set Colour
     border = "white",                          # Set bar edge colour
     breaks = 14                                # Set n breaks
)

# Group B ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
hist(mydata$Measure[mydata$Group == "B"],       # Select variable 
     main="Histogram : Group B",                # Set main title
     xlab="Response Variable",                  # Set x axis title
     col = "darkmagenta",                       # Set Colour
     border = "white",                          # Set bar edge colour
     breaks = 14                                # Set n breaks
)


# Visualising Spread in the dependent variable ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
plot(x = mydata$Measure, y = mydata$ID,                # X and Y variables
     pch = 20,                                         # point shape
     cex = mydata$Measure*2.5,                         # point size
     col = c("chocolate", 
             "darkmagenta")[as.numeric(mydata$Group)], # point colour
     xlab = "Measure",                                 # X axis label
     ylab = "ID",                                      # Y axis label
     main = "Spread of Measure values")                # Main title
# Add the  plot legend
legend("topleft",                         # legend position
       legend=c("Group A", "Group B"),    # Legend labels
       pch=c(20, 20),                     # point type
       col=c("chocolate", "darkmagenta")) # point colour


# 02-2) Box plot -------------
# Box plot comparing responses
boxplot(formula = Measure ~ Group,              # Select Y and X variables
        data = mydata,                          # Tell R to use this data 
        main = "Boxplot : Group x Measure",     # Set the main title
        col = c("chocolate", "darkmagenta"))    # Set colours



# 02-3) Plot everything together --------
# We can plot everything together in a neat panel plot

#png("output/figs/Exercise_1_Panel_Plot.png") # for saving to a .png file
# This sets the image parameters, 2 rows, 2 columns
par(mfrow=c(2,2))               

# Histogram of All responses
hist(mydata$Measure,                            # Select variable
     main = "Histogram : All Values",           # Set main title
     xlab = "Response Variable",                # Set x axis title
     col = "white",                             # Set bar fill Colour
     border = "black"                           # Set bar edge colour
)

# Group A
hist(mydata$Measure[mydata$Group == "A"],       # Select variable 
     main="Histogram : Group A",                # Set main title
     xlab="Response Variable",                  # Set x axis title
     col = "chocolate",                         # Set Colour
     border = "white",                          # Set bar edge colour
     breaks = 14                                # Set n breaks
)

# Group B
hist(mydata$Measure[mydata$Group == "B"],       # Select variable 
     main="Histogram : Group B",                # Set main title
     xlab="Response Variable",                  # Set x axis title
     col = "darkmagenta",                       # Set Colour
     border = "white",                          # Set bar edge colour
     breaks = 14                                # Set n breaks
)

# Box plot comparing responses
boxplot(formula = Measure ~ Group,              # Select Y and X variables
        data = mydata,                          # Tell R to use this data 
        main = "Boxplot : Group x Measure",     # Set the main title
        col = c("chocolate", "darkmagenta"))    # Set colours

par(mfrow=c(1,1))                               # This returns the image parameters to normal
#dev.off()                                      # This closes the graphics device for saving
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 03) Analyse Data --------------------------------------------------------
# First we need to check our assumptions

# 03-1) Assumption of Normality ----
mydata_shap   <- shapiro.test(mydata$Measure)
mydata_shap_A <- shapiro.test(mydata$Measure[mydata$Group == "A"])
mydata_shap_B <- shapiro.test(mydata$Measure[mydata$Group == "B"])

# 03-2) Equality of variances ----
my_data_VarTest   <- var.test(Measure~Group, mydata)
my_data_BartTest  <- bartlett.test(Measure~Group, mydata)


# 03-3) T test ----
my_data_t_test  <- t.test(Measure~Group, data = mydata, alternative = "two.sided", conf.level = 0.95)

# Cohen's D
SD_pooled <- sqrt((sd(my_data_A$Measure)^2)+(sd(my_data_A$Measure)^2)/2)
Cohen_D   <- (mean(my_data_A$Measure) - mean(my_data_B$Measure))/ SD_pooled

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 04) Prepare output ------------------------------------------------------
# Because we have everything stored as an object we can just use the object name
# and subset operators to access elements and create tables for reports

# 04-1) Summary data --------------------------------------------
# Clean up the summary object
row.names(mydata_summary) <- NULL # we don't need row names
mydata_summary$item       <- NULL # we don't need this column 



# use row bind rbind() to bind the total summary to the grouped summary
mydata_total_summary <- rbind(
  # Concatenate a grouping variable to the all groups Measure summary
  c(group1 = "All",                     # new group variable for ALL, to ensure binding to groups summary
    psych::describe(mydata$Measure)),   # All groups summary
  # bind to the grouped summary
  mydata_summary                        # Groups summary
) 

mydata_total_summary # take a look at the data frame
# drop any other columns you feel are unncessary
mydata_total_summary$mad        <- NULL
mydata_total_summary$trimmed    <- NULL
mydata_total_summary$skew       <- NULL
mydata_total_summary$kurtosis   <- NULL

# write summary as a csv file
write.csv(mydata_total_summary,              # object to be written to file
          'output/tables/mydata_total_summary.csv') # file path for output file


# 04-2) T-test Assumptions ----------------------------------------
# write normality tests to a dataframe
ShapiroWilksTest <- data.frame(
  # The c() inside a data.frame() allows us to assign a list to a column name
  Group = c("All", "A", "B"),                                                       # Group membership
  W = c(mydata_shap$statistic, mydata_shap_A$statistic, mydata_shap_B$statistic),   # W statistic
  p = c(mydata_shap$p.value, mydata_shap_A$p.value, mydata_shap_B$p.value)          # p value
)

# write output to file
write.csv(ShapiroWilksTest,
          'output/tables/mydata_ShapiroWilksTest-results.csv')


# Homogeneity of variance
BartletTest <- data.frame(
  k_sq = my_data_BartTest$statistic,
  df = my_data_BartTest$parameter,
  p = my_data_BartTest$p.value
)

# write output to file
write.csv(BartletTest,
          'output/tables/mydata_BartletTest-results.csv')

# 04-3) T-test -----------------------------------------------------
# T- test

t_test_summary <- data.frame(
  t = my_data_t_test$statistic,          # t value
  df = my_data_t_test$parameter,         # degrees of freedom
  p = my_data_t_test$p.value,            # p value
  CI_lower = my_data_t_test$conf.int[1], # lower 95% CI
  CI_upper = my_data_t_test$conf.int[2], # upper 95% CI
  method = my_data_t_test$method,         # Method used to obtain t (Welch's t-test)
  Cohen_D = Cohen_D
)

# write output to file
write.csv(t_test_summary,
          'output/tables/mydata_t-test-results.csv')

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 05) What next? ----------------------------------------------------------

# We have performed a t-test on a data set G1

# There are three separate groups in the Exercise_1_data object
# So for practice try to perform an analysis on G2 there are n = 1000 observations
# G3 contains missing data if you want to take it and learn how to perform an analysis with missing data
# There are extra steps needed to filter missing data but it is relatively straight forward with our data

G3 <- Exercise_1_data$G3
nrow(G3) # 10000

# create a clean data set with no missing values
# Exclude missing data using subset
G3_clean <- G3[!rowSums(is.na(G3["Measure"])), ]

# collect the rows for missing values and store
G3_rows_with_missing_data <- G3[-as.numeric(row.names(G3_clean)), ]

