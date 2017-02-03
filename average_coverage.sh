#!/bin/bash
# Usage: sh average_coverage.sh <path to input files>
#lmc297@cornell.edu
#ms984@cornell.edu

cd $1
for f in *_contigs.fasta
do
echo "Indexing $f with BBMap..."
bbmap.sh ref=$f
echo "Mapping reads to $f with BBMap..."
bbmap.sh in=${f%_contigs.fasta}_R1.trimmedP.fastq.gz in2=${f%_contigs.fasta}_R2.trimmedP.fastq.gz out=${f%_contigs.fasta}.sam
echo "SAM file created.  BBMap finished."
mv ref/ ${f%_contigs.fasta}_ref/
echo "Converting SAM to BAM with samtools..."
samtools view -Sb ${f%_contigs.fasta}.sam > ${f%_contigs.fasta}.bam
echo "BAM file created."
echo "Removing sam file..."
rm -r *.sam
echo "Sorting BAM file with samtools..."
samtools sort ${f%_contigs.fasta}.bam ${f%_contigs.fasta}_sorted
echo "Finished sorting."
echo "Indexing sorted BAM file..."
samtools index ${f%_contigs.fasta}_sorted.bam
echo "Index complete."
echo "Using samtools depth to obtain average genome coverage..."
X=$(samtools depth ${f%_contigs.fasta}_sorted.bam | awk '{sum+=$3} END { print sum/NR}');
echo "${f%_contigs.fasta}_sorted.bam";
echo "$X";
echo "${f%_contigs.fasta}_sorted.bam $X">> average_coverage.txt;
done

