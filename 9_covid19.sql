-- 1. Modify the query to show data from Spain
  SELECT name, DAY(whn),
         confirmed, deaths, recovered
    FROM covid
   WHERE name = 'Spain'
     AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

-- 2. Modify the query to show confirmed for the day before.
  SELECT name, DAY(whn), confirmed,
         LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
    FROM covid
   WHERE name = 'Italy'
     AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

-- 3. Show the number of new cases for each day, for Italy, for March.
  SELECT name, DAY(whn), confirmed -
         LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
    FROM covid
   WHERE name = 'Italy'
     AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

/* 4. Show the number of new cases in Italy for each week in 2020 - show Monday
      only. */
  SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), 
         confirmed -  LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new
    FROM covid
   WHERE name = 'Italy'
     AND WEEKDAY(whn) = 0 AND YEAR(whn) = 2020
ORDER BY whn;

-- 5. Show the number of new cases in Italy for each week - show Monday only.
  SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
         tw.confirmed - lw.confirmed 
    FROM covid tw LEFT JOIN covid lw ON 
         DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
     AND tw.name=lw.name
   WHERE tw.name = 'Italy' AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- 6. Include the ranking for the number of deaths in the table.
  SELECT name, confirmed,
         RANK() OVER (ORDER BY confirmed DESC) rc,
         deaths, RANK() OVER (ORDER BY deaths DESC) 
    FROM covid
   WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

/* 7. Show the infect rate ranking for each country. Only include countries with
      a population of at least 10 million. */
  SELECT world.name,
         ROUND(100000*confirmed/population, 0) AS infect_rate,
         RANK() OVER (ORDER BY (confirmed/population) DESC) AS ranking
    FROM covid INNER JOIN world ON covid.name = world.name
   WHERE whn = '2020-04-20'
     AND population >= 10000000
ORDER BY infect_rate DESC;