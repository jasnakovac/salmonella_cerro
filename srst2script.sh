#!/bin/bash
#lmc297@cornell.edu

cd $1

for f in *_R1.trimmedP.fastq.gz
do
srst2 --forward "_R1.trimmedP" --reverse "_R2.trimmedP" --input_pe $f ${f%_R1.trimmedP.fastq.gz}_R2.trimmedP.fastq.gz --output ${f%_R1.trimmedP.fastq.gz}_test2 --log --mlst_db Salmonella_enterica.fasta --mlst_definitions senterica.txt
mv ${f%_R1.trimmedP.fastq.gz}_test2* ${f%_R1.trimmedP.fastq.gz}_srst2
done 
