# Netflix Movies and TV Shows Analysis using SQL
![Netflix Logo](https://github.com/kellystrings/Netflix_business_project/blob/main/Netflix-logo.png)


## Objectives
This project uses SQL to analyze data from Netflix's movies and TV shows comprehensively. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

##Objectives
1. Analyze the distribution of content types (movies vs TV shows).
2. Identify the most common ratings for movies and TV shows.
3. List and analyze content based on release years, countries, and durations.
4. Explore and categorize content based on specific criteria and keywords.

##Dataset
The data for this project is sourced from the Kaggle dataset:

* Dataset Link: ![Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
***sql
CREATE TABLE netflix
(
show_id	VARCHAR(6),
type	VARCHAR(10),
title	VARCHAR(150),
director VARCHAR(230),
casts	VARCHAR(1000),
country	VARCHAR(150),
date_added	VARCHAR(30),
release_year	INT,
rating	VARCHAR(20),
duration	VARCHAR(20),
listed_in	VARCHAR(150),
description VARCHAR(300)
);
***
