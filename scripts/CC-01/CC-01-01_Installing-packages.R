# R/CC-01-01_Installing-packages.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
# Sections:
# 00) Checking for package installation
# 01) Installing Packages
    # 00-1 The easy way
    # 00-2 The complicated way
# 02) Package Documentation
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#




# 00) Check for packages --------------------------------------------------
# In case you already have a working copy of R with several package installs
# check to see if you have already installed these packages before you perform
# a new installation


# 00-1 easy way ---------------------------
# take an unassigned character object and check to see if it is *in* installed packages, using the %in% operator
"tidyverse"     %in% installed.packages() 
"lavaan"        %in% installed.packages() 
"psych"         %in% installed.packages()
"sdablcabcywjk" %in% installed.packages() # this is a made up package



# 00-2 Complicated way --------------------
# demonstrating how to use an ifelse statement inside a for-loop 

my_packages   <- as.vector(library()$results[,1])

search_name  <- c("tidyverse", "lavaan", "psych", "sdablcabcywjk")

# Initialize for-loop variables
check_list_tmp  <- as.data.frame()
check_list      <- NULL
X_tmp           <- NULL
Y_tmp           <- NULL



for (i in 1:length(search_name)) {
  
  # Search value
  X_tmp <- search_name[i]
  
  # Ifelse function for checking if package is installed or not
  Y_tmp <- ifelse(
    # Is the Search name in installed packages? 
    X_tmp %in% my_packages, 
    # IF installed
    "Installed", 
    # ELSE
    "Not installed"
  )
  
  check_list_tmp <- data.frame(
    Package = X_tmp,
    Installed = Y_tmp
  )
  
  # output
  check_list <- rbind(check_list, check_list_tmp)
}

# View the results:
check_list
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 01) Package install -----------------------------------------------------
# If any of the packages in section 00 are NOT installed, then install here
# Remove the comment '#' at the start of each *installed.packages()* line

# These packages are frequently used packages and are well tested.
# We will use them where appropriate

# Tidyverse is a collection of packages with a shared style
# We will cover it's use in session 2
# Installing tidyverse this way will install number of packages which we will end up using: 
# e.g. dplyr, tibble, ggplot2, readr

#install.packages("tidyverse")  ## install tidyverse


 
# Psych is a very useful package with a variety of functions for psychological and psychometric analysis
# The package author, William Revelle, has written a number of open-access text books demonstrating
# how to perform psychometric analysis using psych
# visit http://personality-project.org/ for more details

#install.packages("psych", dependencies = TRUE) ## install psych with dependencies



# lavaan is a very popular package for confirmatory factory analysis
# Visit http://lavaan.ugent.be/ for more details

#install.packages("lavaan", dependencies = TRUE) ## install lavaan with dependencies

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#



# 02) Package Documentation -----------------------------------------------
# The package documentation will appear in the help tab of the viewer pane
help(package="tidyverse")
help(package="psych")
help(package="lavaan")
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#