# Hadoop - HDFS
## Curso Citizen Data Scientist - CAOBA
### Profesor: Edwin Montoya M. – emontoya@eafit.edu.co
## 2018

# Ejecutar programas desde la terminal en PIG:

## Ejemplo WordCount:

      $ cat wordcount.pig

      lines = LOAD '/datasets/gutenberg/gutenberg-small/*.txt' AS (line:chararray);
      words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
      grouped = GROUP words BY word;
      wordcount = FOREACH grouped GENERATE group, COUNT(words) as cont;
      ordered = ORDER wordcount BY cont DESC;
      STORE ordered INTO ‘/tmp/wordcount';
      Top10 = LIMIT ordered 10;
      DUMP Top10;

      $ pig -f wordcount.pig
            
## Tutorial Pig de comandos

* [Tutorial](PigTutorial.md)

## Ejemplos con dataset OlympicAthetesSample.txt

* [OlympicAthletesSample](OlympicAthletesSample.md)

## Retos con los datos de empleados, peliculas, empresas 'datasets/otros/    dataempleados.csv, dataempresas.csv, datapeliculas.csv'.

[datasets de ejemplo](../datasets/otros/)

### 1. Se tiene un conjunto de datos, que representan el salario anual de los empleados formales en Colombia por sector económico, según la DIAN.

* La estructura del archivo es: (SE: sector económico) ("dataempleados.csv")

      SE,Id_empleado,salario,año

      3233,1234,35000,1960
      3233,5434,36000,1961
      1115,3432,34000,1980
      3233,1234,40000,1965
      1115,1212,77000,1980
      1115,1412,76000,1981
      1116,1412,76000,1982

* Realizar un programa en PIG que permita calcular:

1. El salario promedio por Sector Económico (SE)
2. El salario promedio por Empleado
3. Número de SE por Empleado que ha tenido a lo largo de la estadística

El programa [empleados1.pig](empleados1.pig) Cual de estas preguntas responde?

### 2. Se tiene un conjunto de acciones de la bolsa, en la cual se reporta a diario el valor promedio por acción, la estructura de los datos es: ("dataempresas.csv")

    empresa,valor,fecha

    exito,77.5,2015-01-01
    EPM,23,2015-01-01
    exito,80,2015-01-02
    EPM,22,2015-01-02
    …

* Realizar un programa en PIG que permita calcular:

1. Por acción, dia-menor-valor, día-mayor-valor
2. Listado de acciones que siempre han subido o se mantienen estables.
3. DIA NEGRO: Saque el día en el que la mayor cantidad de acciones tienen el menor valor de acción (DESPLOME), suponga una inflación independiente del tiempo.

### 3. Sistema de evaluación de películas ("datapeliculas.csv"):

Se tiene un conjunto de datos en el cual se evalúan las películas con un rating, con la siguiente estructura:

    user_id,movie_id,genero,rating,date

    1234,4567,accion,5,2016-10-23
    1234,3232,suspenso,1,2016-10-23
    4321,4567,accion,1,2016-10-23
    4321,4568,accion,5,2016-10-23
    4321,4567,accion,1,2016-10-24
    4321,4567,accion,1,2016-10-24
    9999,4557,accion,5,2016-10-25
    …
    …

* Realizar un programa en PIG que permita calcular:

1. Número de películas vista por un usuario, valor promedio de calificación
2. Día en que más películas se han visto
3. Día en que menos películas se han visto
4. Número de usuarios que ven una misma película y el rating promedio
5. Día en que peor evaluación en promedio han dado los usuarios
6. Día en que mejor evaluación han dado los usuarios
7. La mejor y peor película evaluada por genero