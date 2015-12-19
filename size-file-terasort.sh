#!/bin/bash
#
# Terasort benchmark for files of different sizes.
# Aliaksandr Krukau
#

hadoop_examples=/opt/hadoop/share/hadoop/mapreduce/hadoop-*examples*.jar
list_sizes=( $((10**7))  $((10**8)) $((10**9)) $((2*10**9)) $((4*10**9)) $((6*10**9)))
# Clean the directories
for n_rows in "${list_sizes[@]}"
do
    hadoop fs -rm -f -R terasort-input
    hadoop fs -rm -f -R terasort-output
    #hadoop fs -rm -f -R terasort-validate
    # Run sorting benchmark
    echo "Size of data (in Mb): $((n_rows / 10000))"
    hadoop jar $hadoop_examples teragen -Dmapred.map.tasks=64 $n_rows /user/$USER/terasort-input
    hadoop jar $hadoop_examples terasort /user/$USER/terasort-input /user/$USER/terasort-output
    #hadoop jar $hadoop_examples teravalidate -Dmapred.reduce.tasks=1 /user/$USER/terasort-output /user/$USER/terasort-validate-$n_rows >> $output_file
done
