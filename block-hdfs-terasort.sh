#!/bin/bash
#
# Terasort benchmark for different HDFS block sizes.
# Aliaksandr Krukau
#
hadoop_examples=/opt/hadoop/share/hadoop/mapreduce
hadoop jar $hadoop_examples/hadoop-*test*.jar mrbench -numRuns 50 \
                -baseDir ./NNBench-`hostname -s`

# Clean the directories
for size in "${block_size[@]}"
do
    hadoop fs -rm -f -R terasort-input
    hadoop fs -rm -f -R terasort-output
    #hadoop fs -rm -f -R terasort-validate
    # Run sorting benchmark
    echo "Block size:$size"
    hadoop jar $hadoop_examples teragen \
           -Ddfs.blocksize=$size 10000000 /user/$USER/terasort-input
    hadoop jar $hadoop_examples terasort -Ddfs.blocksize=$size \
           /user/$USER/terasort-input /user/$USER/terasort-output
    #hadoop jar $hadoop_examples teravalidate -Ddfs.blocksize=$size -Dmapred.reduce.tasks=1 /user/$USER/terasort-output /user/$USER/terasort-validate >> $output_file
done
