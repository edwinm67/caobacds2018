# Universidad EAFIT
# Curso Big Data - Postobon, 2018-1
# Profesor: Edwin Montoya M. – emontoya@eafit.edu.co

# Resumen de https://www.tutorialspoint.com/apache_pig/index.htm

## Apache Pig - LOAD data

### student_data.txt ($ hdfs dfs -put student_data.txt /user/username/datasets/pig/)

      001,Rajiv,Reddy,9848022337,Hyderabad
      002,siddarth,Battacharya,9848022338,Kolkata
      003,Rajesh,Khanna,9848022339,Delhi
      004,Preethi,Agarwal,9848022330,Pune
      005,Trupthi,Mohanthy,9848022336,Bhuwaneshwar
      006,Archana,Mishra,9848022335,Chennai

### Load Data

      grunt> student = LOAD '/user/username/datasets/pig/student_data.txt' USING PigStorage(',')
      as ( id:int, firstname:chararray, lastname:chararray, phone:chararray, city:chararray );

      grunt> dump student;      

## Apache Pig - STORE data

      grunt> STORE student INTO '/user/username/pigout1' USING PigStorage (',');

### verification

      $ hdfs dfs -ls /user/username/pigout1
      $ hdfs dfs -cat /user/username/pigout1/part-m-00000      

## Apache Pig - DUMP command

The Dump operator is used to run the Pig Latin statements and display the results on the screen. It is generally used for debugging Purpose.

      grunt> DUMP student;

## Apache Pig - DESCRIBE command

The describe operator is used to view the schema of a relation.

      grunt> DESCRIBE student;

## Apache Pig - EXPLAIN command

The explain operator is used to display the logical, physical, and MapReduce execution plans of a relation.

      grunt> EXPLAIN student;

## Apache Pig - ILLUSTRATE command

The illustrate operator gives you the step-by-step execution of a sequence of statements.

      grunt> ILLUSTRATE student;

## Apache Pig - GROUP Operator  

The GROUP operator is used to group the data in one or more relations. It collects the data having the same key.

### student_details.txt ($ hdfs dfs -put student_details.txt /user/username/datasets/pig/)

      001,Rajiv,Reddy,21,9848022337,Hyderabad
      002,siddarth,Battacharya,22,9848022338,Kolkata
      003,Rajesh,Khanna,22,9848022339,Delhi
      004,Preethi,Agarwal,21,9848022330,Pune
      005,Trupthi,Mohanthy,23,9848022336,Bhuwaneshwar
      006,Archana,Mishra,23,9848022335,Chennai
      007,Komal,Nayak,24,9848022334,trivendram
      008,Bharathi,Nambiayar,24,9848022333,Chennai

Example:

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray);

      grunt> group_data = GROUP student_details by age;

      grunt> Dump group_data;

### Grouping by Multiple Columns

      grunt> group_multiple = GROUP student_details by (age, city);
      grunt> Dump group_multiple;

### Group All

      grunt> group_all = GROUP student_details All;
      grunt> Dump group_all; 

## Apache Pig - COGROUP Operator

group operator is normally used with one relation, while the cogroup operator is used in statements involving two or more relations.

### student_details.txt

      001,Rajiv,Reddy,21,9848022337,Hyderabad
      002,siddarth,Battacharya,22,9848022338,Kolkata
      003,Rajesh,Khanna,22,9848022339,Delhi
      004,Preethi,Agarwal,21,9848022330,Pune
      005,Trupthi,Mohanthy,23,9848022336,Bhuwaneshwar
      006,Archana,Mishra,23,9848022335,Chennai
      007,Komal,Nayak,24,9848022334,trivendram
      008,Bharathi,Nambiayar,24,9848022333,Chennai

### employee_details.txt

      001,Robin,22,newyork 
      002,BOB,23,Kolkata 
      003,Maya,23,Tokyo 
      004,Sara,25,London 
      005,David,23,Bhuwaneshwar 
      006,Maggy,22,Chennai

load data:

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray);
  
      grunt> employee_details = LOAD '/user/username/datasets/pig/employee_details.txt' USING PigStorage(',')
      as (id:int, name:chararray, age:int, city:chararray);

 cogroup:

      grunt> cogroup_data = COGROUP student_details by age, employee_details by age;   

      grunt> Dump cogroup_data;  

## Apache Pig - Join Operator  

The JOIN operator is used to combine records from two or more relations. 

Joins can be of the following types:

* Self-join
* Inner-join
* Outer-join − left join, right join, and full join  

Example:

### customers.txt ($ hdfs dfs -put customers.txt /user/username/datasets/pig/)

      1,Ramesh,32,Ahmedabad,2000.00
      2,Khilan,25,Delhi,1500.00
      3,kaushik,23,Kota,2000.00
      4,Chaitali,25,Mumbai,6500.00 
      5,Hardik,27,Bhopal,8500.00
      6,Komal,22,MP,4500.00
      7,Muffy,24,Indore,10000.00  

### orders.txt ($ hdfs dfs -put orders.txt /user/username/datasets/pig/)

      102,2009-10-08 00:00:00,3,3000
      100,2009-10-08 00:00:00,3,1500
      101,2009-11-20 00:00:00,2,1560
      103,2008-05-20 00:00:00,4,2060  

### Load data:

      grunt> customers = LOAD '/user/username/datasets/pig/customers.txt' USING PigStorage(',')
      as (id:int, name:chararray, age:int, address:chararray, salary:int);
      
      grunt> orders = LOAD '/user/username/datasets/pig/orders.txt' USING PigStorage(',')
      as (oid:int, date:chararray, customer_id:int, amount:int);     

### Self - join

Self-join is used to join a table with itself as if the table were two relations, temporarily renaming at least one relation.

      grunt> customers1 = LOAD '/user/username/datasets/pig/customers.txt' USING PigStorage(',')
      as (id:int, name:chararray, age:int, address:chararray, salary:int);
      
      grunt> customers2 = LOAD '/user/username/datasets/pig/customers.txt' USING PigStorage(',')
      as (id:int, name:chararray, age:int, address:chararray, salary:int);    

      grunt> customers3 = JOIN customers1 BY id, customers2 BY id;

      grunt> dump customers3;
              
### Inner Join

Inner Join is used quite frequently; it is also referred to as equijoin. An inner join returns rows when there is a match in both tables.

      grunt> customer_orders = JOIN customers BY id, orders BY customer_id;

      grunt> dump customer_orders;

### Left Outer Join      

The left outer Join operation returns all rows from the left table, even if there are no matches in the right relation.

      grunt> outer_left = JOIN customers BY id LEFT OUTER, orders BY customer_id;
      
      grunt> dump outer_left;

### Right Outer Join  

The right outer join operation returns all rows from the right table, even if there are no matches in the left table.

      grunt> outer_right = JOIN customers BY id RIGHT, orders BY customer_id;
      grunt> dump outer_right;

### Full Outer Join

The full outer join operation returns rows when there is a match in one of the relations.

      grunt> outer_full = JOIN customers BY id FULL OUTER, orders BY customer_id;

      grunt> Dump outer_full;       

### Using Multiple Keys 

We can perform JOIN operation using multiple keys.

employee.txt

      001,Rajiv,Reddy,21,programmer,003
      002,siddarth,Battacharya,22,programmer,003
      003,Rajesh,Khanna,22,programmer,003
      004,Preethi,Agarwal,21,programmer,003
      005,Trupthi,Mohanthy,23,programmer,003
      006,Archana,Mishra,23,programmer,003
      007,Komal,Nayak,24,teamlead,002
      008,Bharathi,Nambiayar,24,manager,001

employee_contact.txt

      001,9848022337,Rajiv@gmail.com,Hyderabad,003
      002,9848022338,siddarth@gmail.com,Kolkata,003
      003,9848022339,Rajesh@gmail.com,Delhi,003
      004,9848022330,Preethi@gmail.com,Pune,003
      005,9848022336,Trupthi@gmail.com,Bhuwaneshwar,003
      006,9848022335,Archana@gmail.com,Chennai,003
      007,9848022334,Komal@gmail.com,trivendram,002
      008,9848022333,Bharathi@gmail.com,Chennai,001  

example:

      grunt> employee = LOAD '/user/username/datasets/pig/employee.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, designation:chararray, jobid:int);
      
      grunt> employee_contact = LOAD '/user/username/datasets/pig/employee_contact.txt' USING PigStorage(',') 
      as (id:int, phone:chararray, email:chararray, city:chararray, jobid:int);         

      grunt> emp = JOIN employee BY (id,jobid), employee_contact BY (id,jobid);

      grunt> Dump emp;

## Apache Pig - CROSS Operator

The CROSS operator computes the cross-product of two or more relations. This chapter explains with example how to use the cross operator in Pig Latin.

Example:

customers.txt

      1,Ramesh,32,Ahmedabad,2000.00
      2,Khilan,25,Delhi,1500.00
      3,kaushik,23,Kota,2000.00
      4,Chaitali,25,Mumbai,6500.00
      5,Hardik,27,Bhopal,8500.00
      6,Komal,22,MP,4500.00
      7,Muffy,24,Indore,10000.00
      
orders.txt

      102,2009-10-08 00:00:00,3,3000
      100,2009-10-08 00:00:00,3,1500
      101,2009-11-20 00:00:00,2,1560
      103,2008-05-20 00:00:00,4,2060

load data:

      grunt> customers = LOAD '/user/username/datasets/pig/customers.txt' USING PigStorage(',')
      as (id:int, name:chararray, age:int, address:chararray, salary:int);
      
      grunt> orders = LOAD '/user/username/datasets/pig/orders.txt' USING PigStorage(',')
      as (oid:int, date:chararray, customer_id:int, amount:int);

cross command:

      grunt> cross_data = CROSS customers, orders;
      grunt> Dump cross_data;      

## Apache Pig - UNION Operator      

The UNION operator of Pig Latin is used to merge the content of two relations. To perform UNION operation on two relations, their columns and domains must be identical.

Example:

student_data1.txt

      001,Rajiv,Reddy,9848022337,Hyderabad
      002,siddarth,Battacharya,9848022338,Kolkata
      003,Rajesh,Khanna,9848022339,Delhi
      004,Preethi,Agarwal,9848022330,Pune
      005,Trupthi,Mohanthy,9848022336,Bhuwaneshwar
      006,Archana,Mishra,9848022335,Chennai

student_data2.txt

      7,Komal,Nayak,9848022334,trivendram
      8,Bharathi,Nambiayar,9848022333,Chennai      

load data:

      grunt> student1 = LOAD '/user/username/datasets/pig/student_data1.txt' USING PigStorage(',') 
      as (id:int, firstname:chararray, lastname:chararray, phone:chararray, city:chararray); 
      
      grunt> student2 = LOAD '/user/username/datasets/pig/student_data2.txt' USING PigStorage(',') 
      as (id:int, firstname:chararray, lastname:chararray, phone:chararray, city:chararray); 

union command:

      grunt> student = UNION student1, student2;
      grunt> Dump student;            

## Apache Pig - FILTER Operator            

The FILTER operator is used to select the required tuples from a relation based on a condition.

example:

student_details.txt

      001,Rajiv,Reddy,21,9848022337,Hyderabad
      002,siddarth,Battacharya,22,9848022338,Kolkata
      003,Rajesh,Khanna,22,9848022339,Delhi 
      004,Preethi,Agarwal,21,9848022330,Pune 
      005,Trupthi,Mohanthy,23,9848022336,Bhuwaneshwar 
      006,Archana,Mishra,23,9848022335,Chennai 
      007,Komal,Nayak,24,9848022334,trivendram 
      008,Bharathi,Nambiayar,24,9848022333,Chennai

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray); 

      grunt> filter_data = FILTER student_details BY city == 'Chennai';    

      grunt> Dump filter_data;

## Apache Pig - DISTINCT Operator 

The DISTINCT operator is used to remove redundant (duplicate) tuples from a relation.

Example:

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray); 

      grunt> distinct_data = DISTINCT student_details;   

      grunt> Dump distinct_data;

## Apache Pig - FOREACH Operator       

The FOREACH operator is used to generate specified data transformations based on the column data.

Example:
      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray); 

      grunt> foreach_data = FOREACH student_details GENERATE id,age,city;

      grunt> Dump foreach_data;

## Apache Pig - ORDER BY Operator 

The ORDER BY operator is used to display the contents of a relation in a sorted order based on one or more fields.

Example:

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray);

      grunt> order_by_data = ORDER student_details BY age DESC;

      grunt> Dump order_by_data;

## Apache Pig - LIMIT Operator    

The LIMIT operator is used to get a limited number of tuples from a relation.

Example:

      grunt> student_details = LOAD '/user/username/datasets/pig/student_details.txt' USING PigStorage(',')
      as (id:int, firstname:chararray, lastname:chararray, age:int, phone:chararray, city:chararray);

      grunt> limit_data = LIMIT student_details 4;   

      grunt> Dump limit_data;