athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);
distinct_countries = DISTINCT (FOREACH athletes GENERATE country);
DUMP distinct_countries;