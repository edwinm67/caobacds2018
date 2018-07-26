empleados = load '/user/<username>/datasets/dataempleados.csv' using org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') as (se:int, idemp:int, salario:int, year:int);
agrupado = group empleados by idemp;
A = FOREACH agrupado {
    d = DISTINCT empleados.se;
    GENERATE group, COUNT(d) as cnt;
}; 
dump A;