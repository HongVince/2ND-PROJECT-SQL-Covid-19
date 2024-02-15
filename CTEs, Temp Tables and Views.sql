-- CTEs, Temp Tables and Views
USE PortfolioProject



--CTE
WITH PopulationVsVaccination (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS 
(SELECT Death.continent, Death.location, Death.date, Death.population, Vaccination.new_vaccinations,
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
--ORDER BY 2,3
)




SELECT *, (RollingPeopleVaccinated/Population)*100
FROM PopulationVsVaccination




-- TEMP TABLE
DROP TABLE IF EXISTS #PercentageOfPopulationVaccinated




CREATE TABLE #PercentageOfPopulationVaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
DATE DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC)

INSERT INTO #PercentageOfPopulationVaccinated
SELECT Death.Continent, Death.Location, Death.Date, Death.Population, Vaccination.new_vaccinations AS 'New Vaccinations',
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS 'Rolling People Vaccinated'
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL
--ORDER BY 2,3




SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentageOfPopulationVaccinated




--------------------------------------------------------------------
-- Implementing Views to Hold Data for Visualizations in Tableau




-- View 1
-- Illustrates the Percentage of Population that are Vaccinated
CREATE VIEW PopulationVaccinated AS
SELECT Death.Continent, Death.Location, Death.Date, Death.Population, Vaccination.new_vaccinations AS 'New Vaccinations',
	SUM(CONVERT(BIGINT, Vaccination.new_vaccinations)) 
	OVER (PARTITION BY Death.location ORDER BY Death.location, Death.date) AS 'Rolling People Vaccinated'
FROM CovidDeaths AS Death
JOIN CovidVaccinations AS Vaccination
	ON Death.location = Vaccination.location
	AND Death.date = Vaccination.date
WHERE Death.continent IS NOT NULL


SELECT * 
FROM PopulationVaccinated




--View 2
-- Illustrates the Percentage of Population that contracted Covid
CREATE VIEW PercentageOfPopulationThatContractedCovid AS
SELECT Continent, Location, Population, Date, Total_cases AS 'Total Cases', (CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0))*100 as 'Percentage of Population Contraction'
FROM [CovidDeaths]
--WHERE location LIKE '%STATES%' AND continent IS NOT NULL


SELECT *
FROM PercentageOfPopulationThatContractedCovid




--View 3
-- Illustrates the Likelihood of Dying, by Country
CREATE VIEW PercentageOfDeath AS
SELECT Continent, Location, Date, Total_cases AS 'Total Cases', Total_deaths AS 'Total Deaths', (CONVERT(FLOAT, total_deaths) / NULLIF(CONVERT(FLOAT, total_cases), 0))*100 as 'Percentage of Death'
FROM [CovidDeaths]
WHERE continent IS NOT NULL


SELECT * 
FROM PercentageOfDeath




--View 4
-- Illustrating Countries with the Most Infection Rates Against Population
CREATE VIEW InfectionRatesAgainstPopultion AS
SELECT Continent, Location, Population, MAX(total_cases) AS 'Highest Contraction Count', MAX((CONVERT(FLOAT, total_cases) / NULLIF(CONVERT(FLOAT, population), 0)))*100 as 'Percentage of Population Contraction'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent, Location, population


SELECT *
FROM InfectionRatesAgainstPopultion




--View 5
-- Illustrating Countries with the Most Death Count per Population
CREATE VIEW CountryDeathCountPerPopulation AS
SELECT Continent, Location, MAX(CAST(total_deaths AS INT)) AS 'Total Death Count'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent, Location


SELECT * 
FROM CountryDeathCountPerPopulation




--VIEW 6
-- Illustrating the Continents with the Most Death Count by Population
CREATE VIEW ContinentsWithMostDeathCountByPopulation AS 
SELECT Continent, MAX(CAST(total_deaths AS INT)) AS 'Total Death Count'
FROM [dbo].[CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY Continent


SELECT *
FROM ContinentsWithMostDeathCountByPopulation




--View 7
-- Illustrating High Level of Gloval Statistics
CREATE VIEW GlobalStatistics AS
SELECT Date, SUM(new_cases) AS 'Total Cases', SUM(new_deaths) AS 'Total Deaths', 
(CONVERT(float, SUM(new_deaths)) / NULLIF(CONVERT(float, SUM(new_cases)), 0)) * 100 AS 'Percentage of Death'
FROM [CovidDeaths]
WHERE Continent IS NOT NULL
GROUP BY date


SELECT *
FROM GlobalStatistics