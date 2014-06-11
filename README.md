Getting and Cleaning Data
========================================================

## About this Repository


This repository has the files required for the course project of the Getting and Cleaning Data Course on Coursera. It started on june, 4 (2014).

The course is (was) avaiable at [Coursera](https://class.coursera.org/getdata-004)

## Contents

* **`readme.md`** - this file
* **`run_analysis.R`** - An R script to process the raw data and generate the tidy dataset
* **`CodeBook.md`** - Description of the variables of the tidy dataset
* **`Tidy_Dataset.txt`** - A tidy data set as required by the Project Description. It´s the result of the runanalysis.R on the raw data.

## How to use
To run the `run_analysis.R` script it´s necessary to extract the raw data (the link is in the Project Description section of this document) on the directory `/data/raw`.

With the raw data on the right directory just run the entire script and it will produce as the result the `Tidy_DataSet.txt` file on the directory `/data`

## Project Description

From the Project Course Description:

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 

> 1. a **tidy data set** as described below, 
> 2. a **link to a Github repository** with your script for performing the analysis, and 
> 3. a **code book** that describes the variables, the data, and any transformations or work that you performed to clean up the data called *CodeBook.md*. You should also include a *README.md* in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
>
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

> Here are the data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

> You should create one R script called *run_analysis.R* that does the following. 

> 1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

