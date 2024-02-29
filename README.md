# Covid-19 Deaths

    Dataset: https://ourworldindata.org/covid-deaths 
    Years Covered: 2020-2023

## About

This project explores Covid-19 data to understand the pandemic's effect on a global scale, then narrowing it down to illustrate countries most effected. More specifically, exploring this data will shed light onto the vaccination percentage, contraction rate, death rates, infection rates and death count.

## Key Points Mentioned Above

- The vaccination percentage of a continent's population 
- The contraction percentage of a continent's population
- The liklihood of death by country
- The infection rates of a country's population
- Death count by country
- Death count by continent
- A high level look at the global statistics

## Purpose of This Project

The agenda of this project is to gather insight into Covid-19 deaths to identify factors effecting different countries/populations.

## About Data

| Column Name  | Description | Data Type |
| ---------   | --------- | --------- |
| Continent |  Name of continent | NVARCHAR(255), NULL |
| Location |  Name of country | NVARCHAR(255), NULL |
| Date | Format: YYYY-MM-DD HH:MI:SS | DATETIME, NULL |
| Population | Population total | FLOAT, NULL |
| Total Cases | As the name suggests | NVARCHAR(255), NULL |
| New Cases | Number of new cases | FLOAT, NULL |
| Total Deaths | As the name suggests | NVARCHAR(255), NULL |
| New Deaths| As the name suggests | FLOAT, NULL |
| Total Cases Per Million | As the name suggests | NVARCHAR(255), NULL |
| New Cases Per Million | As the name suggests | FLOAT, NULL |
| Total Death Per Million | As the name suggests | NVARCHAR(255), NULL |
| New Deaths Per Million | As the name suggests | NVARCHAR(255), NULL |

## Analysis List

### 1) Continent, Location

Conduct analysis on the dataset of the different continents and countries to understand the areas that are affected the most.

### 2) Date

This analysis centers around the death rate over time - from peak time to the lowest.

### 3) Population Analysis

This analysis aims to illustrate Covid-19's affect on specific populations around the world, with the intention of discovering rates such as death, infection, contraction, etc.

### 4) Total - Cases, Deaths, Cases Per Million and Deaths Per Million

Using the sum of the data to calculate percentages with the intention of uncovering the ratio of a population and one of the totals mentioned above.

## Approaches Used

1) **Data Cleaning:** Involves the inspection of data to make sure they are not NULL, and are not missing.

   a) Building a database
   b) Creating and table to insert the data

2) **Engineering New Features**
   a) Creating a CTE that illustrates the ratio of a population to vaccination rates
   b) Creating a TEMP Table to insert the data centering around population to vaccination ratio
   c) Creating various views to implement into Tableau for visualization and analysis

3) **Exploratory Data Analysis:** Done to address the keypoints mentioned at the very top of this README.

## Questions Answered

1) What is the continent with the highest death rate?
2) What is the country with the higehst death rate?
3) What is the ratio between a country's population and vaccination rate?
4) What is the percentage of a population that contracted covid?
5) What country had the higehst infection rate?
6) What is the likelihood of dying in a specific country?
7) What are the countries with the highest infection rates?
8) What are each countriy's death count?
9) What is the ratio between total cases against total deaths?

## Observations
Despite having a lower contraction rate, Mexico's mortality rate seems to surpass, China, India, the United States and the United Kingddom. This may be attributed to Mexico's Safe Distance campaign having an impact in reducing the contraction rate, but not impacting the proportion of hospitalized and deceased patients.
Futhermore, another reason could be the saturation of hospital and intensive care units required to deal with the high occupancy of patients. This would exist in both private and public institutions. 

The U.S.'s contraction rate as well as death count seem to be overshadow a lot of other wealthy countries. This may be attributed to the U.S.'s difficulity in distributing vaccinations in parts of the country for one reason another. A big factor in this issue is the politiciziation of the public health's response to the pandemic.
Futhermore, the U.S's resistance to the public health's response might have a large role in the high contraction and mortality rates. When considering the population size of the U.S, the statistics are astonishing.

Despite having the highest infection rates, Europe's death count and average percentage of death is lower than that of the American continent. Many factors may have influenced such a result, but the prominent culprit seems to be the population's perception of the public health's response to Covid-19. Despite being hit hard early on, isolation efforts enabled countries like France and Austria (two European contries with the higehst infection rates) to hold off death rates until the release of vaccinations. Furthermore, there seems to be a trend regarding a populations perception of the public health's efforts in dealing with the epidemic. 

In summary, despite being patient zero, China's average death rate/count is lower than the U.S. This is attributed to China having a faster reaction time, naturally. All this to say, North America's higher death count seems to correlate with the politiciziation of the epidemic. More specifically, the public health's preventative measures like masks and vaccinations. All in all, the epidemic is highly contreversial in the states, for unforseen reasons. 
