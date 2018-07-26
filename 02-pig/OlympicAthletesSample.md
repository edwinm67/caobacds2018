# Hadoop - HDFS
## Curso Citizen Data Scientist - CAOBA
### Profesor: Edwin Montoya M. – emontoya@eafit.edu.co
## 2018

# Ejecutar programas desde la terminal en PIG:

## Tome como base el archivo: "OlympicAthletesSample.csv"

### Cual es el modelo de datos?

## ¿Qué pregunta responde este pig script?

      athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);
      
      distinct_countries = DISTINCT (FOREACH athletes GENERATE country);
      
      DUMP distinct_countries;

## ¿Qué pregunta responde este pig script?

      athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);

      athletes_filter = FILTER athletes by sport != 'Swimming';

      medal_sum = FOREACH (GROUP athletes_filter BY country) GENERATE group as country, SUM(athletes_filter.total) as medal_count;

      ordered_medals = ORDER medal_sum BY medal_count DESC;

      DUMP ordered_medals;

## ¿Qué pregunta responde este pig script?

      athletes = LOAD '/user/<username>/datasets/OlympicAthletesSample.txt' USING PigStorage(',') AS (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);

      athletes_grp_country = GROUP athletes BY country;

      medal_sum = FOREACH athletes_grp_country GENERATE group AS country, SUM(athletes.total) AS medal_count;

      ordered_medals = ORDER medal_sum BY medal_count DESC;

      DUMP ordered_medals;

## Realice el script pig que permita responder la siguiente pregunta:

### Liste cantidad de medallas de Oro, Plata, Bronce y Total por PAIS, ordenado por Medallas de Oro:

      