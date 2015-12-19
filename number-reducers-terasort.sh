#!/bin/bash
#
# MRBench test for 50 small files
# Aliaksandr Krukau
#

hadoop_examples=/opt/hadoop/share/hadoop/mapreduce/hadoop-*examples*.jar
list_reduces=( 1 4 8 16 32 64)
n_rows=40000000
for n_reduces in "${list_reduces[@]}"
do
    # Clean the directories
    hadoop fs -rm -f -R terasort-input
    hadoop fs -rm -f -R terasort-output
    #hadoop fs -rm -f -R terasort-validate
    # Run sorting benchmark
    echo "Reduces: $((n_reduces))"
    hadoop jar $hadoop_examples teragen  $n_rows /user/$USER/terasort-input
    hadoop jar $hadoop_examples terasort -Dmapred.reduce.tasks=$((n_reduces)) /user/$USER/terasort-input /user/$USER/terasort-output
    #hadoop jar $hadoop_examples teravalidate -Dmapred.reduce.tasks=1 /user/$USER/terasort-output /user/$USER/terasort-validate-$n_rows >> $output_file
done
