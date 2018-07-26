athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);
athletes_grp_country = GROUP athletes BY country;
medal_sum = FOREACH athletes_grp_country GENERATE group AS country, SUM(athletes.total) AS medal_count;
ordered_medals = ORDER medal_sum BY medal_count DESC;
DUMP ordered_medals;