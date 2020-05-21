# Crash Course in R for Psychologists - ReadMe

This repository contains materials for a Crash Course in R for Psychologists.
The scripts and data folders are organised by Session number.
The crash course assumes basic training in statistical methods.

Presently this course is written in `R 3.6.2` Action of the toes.
This will be updated to `R 4.0.0` in due course.



## CC-01 - Session 1
This session is focused on getting to grips with R and Rstudio IDE.   

**Objectives**:  
  - Learn how to write readable code
  - R syntax
  - Introduce basic functions
  - Read a file
  - Perform a data summary 
  - Perform a t-test and associated plots
  - Export summaries as .csv files

The slide show is available as `CC-01-crash-course-in-R.pdf`.  
Exercises and practicals are included. Solution code to the practical is not available.  

**Package Dependencies**  
CC-01 requires functions from the `psych` and `readr` packages. 
These can be installed using directions in `CC-01-01_Installing-packages.R`

## CC-02 - Session 2
This session is focused on the tidyverse and data preparation. 
The lessons learned in CC-01 are advanced in this session. 

**Objectives**:
  - Using dplyr to clean and prepare data.
  - Using dplyr to summarise data.
  - Using ggplot2 to visualise data.
  - Perform a One-way ANOVA
  - Perform a Linear Regression
  
The slide show is available as `CC-01-crash-course-in-R.pdf`.
Exercises and practicals are included. Solution code to the practical is not available.   

**Package Dependencies**  
CC-02 requires a tidyverse installation. Tidyverse is installed in CC-01.   


## File Structure  

Crash Course in R for Psychologists/

              |------- scripts/             "Scripts for CC-01 and CC-02"
                          |------- CC-01/ 
                          |------- CC-02/ 
                          
              |------- data/                "input data for CC-01 and CC-02"
                          
                          |------- CC-01/ 
                          |------- CC-02/
                          
              |------- output/              "Contains output from CC-01 and CC-01"
              
              |------- course-docs/         "Contains session slides"