#!/bin/bash
#
# MRBench test for 50 small files
# Aliaksandr Krukau
#
hadoop_examples=/opt/hadoop/share/hadoop/mapreduce
hadoop jar $hadoop_examples/hadoop-*test*.jar mrbench -numRuns 50 \
            -baseDir ./NNBench-`hostname -s`

