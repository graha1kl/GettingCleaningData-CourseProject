Getting and Cleaning Data: Course Project
=========================================

This repository contains the R code and documentation files for the course project for the "Getting and Cleaning Data" Coursera class which is part of the Data Science Specialization from John Hopkins University.

"The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis." (from the assignment description located within the Coursera class module).

## Files

`CodeBook.md` - Contains information about the original data set, as well as a complete description of the data transformations performed by the `run_analysis.R` script and the variables produced in the resulting tidy data set (`tidyDataAverages.txt`).

`README.md` - Includes requirements and instructions for executing the `run_analysis.R` script, along with instructions for viewing the tidy data set (`tidyDataAverages.txt`)

`run_analysis.R` - Contains R code that is designed to manipulate the original data set from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and produce a tidy data set (`tidyDataAverages.txt`) for later analysis.

## Requirements

1. Download and unzip the [project data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The data files will unzip into the following folder: `UCI_HAR_Dataset`. Do not rename or move any of the files within this folder.

2. Place the `run_analysis.R` file in the `UCI_HAR_Dataset` directory.

3. Set `UCI_HAR_Dataset` as your working directory in you R environment.

4. The `run_analysis.R` script requires the `plyr` package. If not already installed, do so prior to running the script (`install.packages("plyr")`
