# Covid-19 Data Analysis

## Overview
This project involves analyzing a COVID-19 dataset to derive meaningful insights regarding the spread of the virus, its impact on public health, and other significant trends. The analysis is performed using SQL queries after preprocessing the data and loading it into a MySQL database.

## Prerequisites
Before running the analysis, ensure you have the following installed:

- Python
- Pandas
- MySQL server
- MySQL client (such as MySQL Workbench)

## Loading CSV Data into MySQL
Follow these steps to load the preprocessed CSV data into a MySQL database:

- Use the python file provided to preprocess the dataset and load the output csv file into MySQL.
- Create a Database and Table in MySQL

```bash
CREATE DATABASE covid_analysis;

USE covid_analysis;

CREATE TABLE covid (
    Province VARCHAR(255),
    `Country/Region` VARCHAR(255),
    Latitude DECIMAL(20,10),
    Longitude DECIMAL(20,10),
    Date DATE,
    Confirmed INTEGER(10),
    Deaths INT(10),
    Recovered INT(10)
);
```
- Load Data in MySQL using the following link for your reference
    https://www.youtube.com/watch?v=cWA9OSuLPuI

    OR 
    
    You can execute the following code in MySQL workbench

    ```bash
    LOAD DATA LOCAL INFILE '/path/to/csv/file.csv'
    INTO TABLE covid_data
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
    ```

## Reference File for Corona Data

A reference file is provided with specific questions for performing detailed analysis. Each question can be answered using appropriate SQL queries based on the data loaded into the MySQL database.

## Conclusion

This README provides an overview of the project, prerequisites, and instructions for loading data into MySQL. By following these steps, you can perform a comprehensive analysis of the COVID-19 dataset to derive meaningful insights.