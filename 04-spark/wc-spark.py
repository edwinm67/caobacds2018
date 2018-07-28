from pyspark import SparkContext
import sys

sc = SparkContext("yarn", "Simple WC")

inputdir = "hdfs:///datasets/gutenberg-small/*.txt"
outputdir = "hdfs:///tmp/salida500"

text_file = sc.textFile(inputdir)
counts = text_file.flatMap(lambda line: line.split(" ")) \
    .map(lambda word: (word, 1)) \
    .reduceByKey(lambda a, b: a + b)
counts.saveAsTextFile(outputdir)
