/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [iso_code]
      ,[continent]
      ,[location]
      ,[date]
      ,[population]
      ,[total_cases]
      ,[new_cases]
      ,[new_cases_smoothed]
      ,[total_deaths]
      ,[new_deaths]
      ,[new_deaths_smoothed]
      ,[total_cases_per_million]
      ,[new_cases_per_million]
      ,[new_cases_smoothed_per_million]
      ,[total_deaths_per_million]
      ,[new_deaths_per_million]
      ,[new_deaths_smoothed_per_million]
      ,[reproduction_rate]
      ,[icu_patients]
      ,[icu_patients_per_million]
      ,[hosp_patients]
      ,[hosp_patients_per_million]
      ,[weekly_icu_admissions]
      ,[weekly_icu_admissions_per_million]
      ,[weekly_hosp_admissions]
      ,[weekly_hosp_admissions_per_million]
  FROM [Portfolio Project].[dbo].[CovidDeaths];
 
 --Beginning to explore dataset

SELECT location,date,total_cases,new_cases,total_deaths,population
  FROM [Portfolio Project]..[CovidDeaths]
  order by 1,2

  --death percentage
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercent
  FROM [Portfolio Project]..[CovidDeaths]
  where location like '%India%'
  order by 1,2

  --total cases vs population
SELECT location,date,total_cases,total_deaths,population,(total_cases/population)*100 as casepercent
  FROM [Portfolio Project]..[CovidDeaths]
  where location like '%India%'
  order by 1,2

  -- which countries has highest infection rates
SELECT Distinct location,
  count(total_cases) OVER(Partition BY location) as countpercountry
  FROM [Portfolio Project]..[CovidDeaths]
    order by 2 desc

	--countries with highest infection rates compared to Population

SELECT location,population, max(total_cases) as highinfectioncount , max ((total_cases/population))*100 as highinfectionpercent
  FROM [Portfolio Project]..[CovidDeaths]
 where location not like '%World%'
 group by location,population
  order by 2 desc

  --countries with highest death
  SELECT location,max(cast(total_deaths as int)) as deathcount 
  FROM [Portfolio Project]..[CovidDeaths]
 where continent is not null
 group by location
  order by 2 desc

  
  --Partition of death count by Continent
  select distinct continent,count(total_deaths) over (partition by continent) as deathcount
  FROM [Portfolio Project].[dbo].[CovidDeaths]
 -- where continent like '%North America%'
  order by 2 desc

  --good query for visualization
  select location, MAX(cast(Total_deaths as int)) as totaldeathcount
  from [Portfolio Project].[dbo].[CovidDeaths]
  where continent is null
  group by location
  order by totaldeathcount desc
 
  select continent, MAX(cast(Total_deaths as int)) as totaldeathcount
  from [Portfolio Project].[dbo].[CovidDeaths]
  where continent is not null
  group by continent
  order by totaldeathcount desc

  --showing continents with highest death count per population
  select continent, MAX(cast(Total_deaths as int)) as totaldeathcount
  from [Portfolio Project].[dbo].[CovidDeaths]
  where continent is not null
  group by continent
  order by totaldeathcount desc

  