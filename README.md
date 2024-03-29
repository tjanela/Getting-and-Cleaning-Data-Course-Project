# Getting and Cleaning Data - Course Project

This repository contains the Code Book and script files needed to understand and
process the data files for the assignment of Getting and Cleaning Data [course 
project](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).

## Original Data

The original data location is [here](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)

## Files

The CodeBook.md file contains a brief description of the original data and the steps taken to produce the summary.csv,
as well as a description of each variable contained in the summary.csv

The main processing is executed in run_analysis.R

## Analysis Script

The file run_analysis.R contains:

  - a utility function p() used to concatenate strings;
  - a utility function download_data() that encapsulates the download and extraction of the original data to a predefined location;
  - a utility function load_set(type) that loads, processes, and normalizes the data files needed to produce a normalized data frame.

The main script declares these functions and then executes them storing the train and test data sets in variables.
These two data sets are then merged into a single data frame. This merged data frame is them summarized, grouping by subject and activity name, applying the mean function to all variables excepts the grouping variables.
The resulting summary data frame is then saved in summary.csv.

## Dependencies

The script depends on:

  - dplyr (1.1.4)
  - R (4.3.3)
