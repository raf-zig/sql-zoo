-- 1. Show the name, continent and population of all countries
SELECT name, continent, population FROM world;

-- 2. Show the name for the countries that have a population of at least 200 million
SELECT name FROM world WHERE population > 200000000;

-- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million 
SELECT name, gdp/population FROM world WHERE population > 200000000;

-- 4. Show the name and population in millions for the countries of the continent 'South America' 
SELECT name, population/1000000 FROM world WHERE continent = 'South America';

-- 5. Show the name and population for France, Germany, Italy
SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries which have a name that includes the word 'United'
SELECT name FROM world WHERE name LIKE '%United%';

-- 7. Show the countries that are big by area or big by population. Show name, population and area. 
SELECT name, population, area FROM world WHERE population > 250000000 OR area > 3000000;

/* 8. Show the countries that are big by area (more than 3 million) or big by
      population (more than 250 million) but not both. Show name, population and
      area.*/
SELECT name, population, area FROM world WHERE population > 250000000 XOR area > 3000000;

-- 9. For South America show population in millions and GDP in billions both to decimal places. 
SELECT name, ROUND(population/1000000, 2) 
    AS population_milli, ROUND(GDP/1000000000, 2) 
    AS gdp_billi
  FROM world 
 WHERE continent = 'South America';

/* 10. Show the name and per-capita GDP for those countries with a GDP of at
       least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000. */
SELECT name, ROUND(GDP/population, -3) 
    AS per_capita_gdp 
  FROM world 
 WHERE gdp >= 1000000000000;

/* 12. Show the name and the capital where the first letters of each match.
       Don't include countries where the name and the capital are the same word. */
SELECT name, capital 
  FROM world 
 WHERE LEFT(name, 1) = LEFT(capital, 1) 
   AND name <> capital;   

-- 13. Find the country that has all the vowels (a e i o u) and no spaces in its name.
SELECT name 
  FROM world 
 WHERE name LIKE '%a%' 
   AND name LIke '%e%' 
   AND name LIke '%i%'
   AND name LIke '%o%' 
   AND name LIke '%u%' 
   AND name NOT LIke '% %';