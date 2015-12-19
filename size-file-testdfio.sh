#!/bin/bash
#
# TestDFSIO for files of different size.
# Aliaksandr Krukau
#
examples_dir=/opt/hadoop/share/hadoop/mapreduce
size_list=( $((10**3))  $((10**4)) $((2*10**4)) )
hadoop jar hadoop-*test*.jar TestDFSIO -clean
for size in "${size_list[@]}"
do
        echo "Size of each file: $size Mb"
        # Run benchmark for DFS write
        hadoop jar $examples_dir/hadoop-*test*.jar TestDFSIO -write -nrFiles 10 -fileSize $size
        # Run benchmark for DFS read
        hadoop jar $examples_dir/hadoop-*test*.jar TestDFSIO -read -nrFiles 10 -fileSize $size
        mv TestDFSIO_results.log "$size-gb-10-files.txt"
done
~

