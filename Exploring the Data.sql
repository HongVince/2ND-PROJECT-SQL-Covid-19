-- Exploring the Data!
-- Queries to be Used to Create CTEs, Temp Tables and Views




SELECT *
FROM PortfolioProject..CovidDeaths
WHERE Continent IS NOT NULL
ORDER BY 3,4




-- Selecting Data That We Will Be Using
USE PortfolioProject
SELECT Continent, Location, Date, Total_cases AS 'Total_Cases', New_cases AS 'New Cases', Total_deaths AS 'Total Deaths', Population
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
ORDER BY 1,2




-- Viewing Total Cases Against Total Deaths
-- Illustrates the Likelihood of Dying, by Country
USE PortfolioProject
SELECT Continent, Location, Date, Total_cases AS 'Total Cases', Total_deaths AS 'Total Deaths', (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0))*100 as 'Percentage of Death'
FROM [CovidDeaths]
WHERE location LIKE '%STATES%' AND continent IS NOT NULL
ORDER BY 1,2




-- Viewing Total Cases Against Population
-- Illustrates the Percentage of Population that contracted Covid
USE PortfolioProject
SELECT Continent, Location, Population, Date, Total_cases AS 'Total Cases', (CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0))*100 as 'Percentage of Population Contraction'
FROM [CovidDeaths]
WHERE location LIKE '%STATES%' AND continent IS NOT NULL
ORDER BY 1,2




-- Countries with the Most Infection Rates Against Population
USE PortfolioProject
SELECT Continent, Location, Population, MAX(total_cases) AS 'Highest Contraction Count', MAX((CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0)))*100 as 'Percentage of Population Contraction'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent, Location, population
ORDER BY 'Percentage of Population Contraction' DESC




-- Countries with the Most Death Count per Population
USE PortfolioProject
SELECT Continent, Location, MAX(CAST(total_deaths AS INT)) AS 'Total Death Count'
--WHERE location LIKE '%STATES%'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent, Location
ORDER BY 'Total Death Count' DESC




-- BREAKING THINGS DOWN BY CONTINENT
--USE PortfolioProject
--SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
--WHERE location LIKE '%STATES%'
--FROM [CovidDeaths]
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY TotalDeathCount DESC
--USE PortfolioProject




-- Illustrating the Continents with the Most Death Count by Population
SELECT Continent, MAX(CAST(total_deaths AS INT)) AS 'Total Death Count'
--WHERE location LIKE '%STATES%'
FROM [dbo].[CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent
ORDER BY 'Total Death Count' DESC




--Total Population Compared to Vaccination
SELECT Death.Continent, Death.Location, Death.Date, Death.Population, Vaccination.new_vaccinations AS 'New Vaccinations',
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS 'Rolling People Vaccinated'
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
ORDER BY 2,3




-- Global statistics
SELECT Date, SUM(new_cases) AS 'Total Cases', SUM(new_deaths) AS 'Total Deaths', 
(CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0)) * 100 AS 'Percentage of Death'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY date
ORDER BY 1,2




SELECT SUM(new_cases) AS 'Total Cases', SUM(new_deaths) AS 'Total Deaths', 
(CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0)) * 100 AS 'Death Percentage'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2