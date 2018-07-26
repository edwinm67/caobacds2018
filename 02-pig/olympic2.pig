athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);
athletes_filter = FILTER athletes by sport != 'Swimming';
medal_sum = FOREACH (GROUP athletes_filter BY country) GENERATE group as country, SUM(athletes_filter.total) as medal_count;
ordered_medals = ORDER medal_sum BY medal_count DESC;
DUMP ordered_medals;