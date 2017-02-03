#!/bin/bash
#Usage: sh merge_scaf.sh <path to input files> <output directory> <file suffix = fasta> <file name>
#lmc297@cornell.edu

cd $1
mkdir merged;

for f in *$3
do merge_fasta_contigs $f > merged/${f%$3}.merged.fa
done

cd merged
mkdir $2

for f in *.merged.fa
do
sed '1d' $f > ${f%.merged.fa}.noheader.fasta
echo '>'${f%.merged.fa} > ${f%.merged.fa}.header.txt
cat ${f%.merged.fa}.header.txt ${f%.merged.fa}.noheader.fasta > $2/${f%.merged.fa}.fsa
rm ${f%.merged.fa}.header.txt
rm ${f%.merged.fa}.noheader.fasta
done
cd $2
echo $4
cat *.fsa > ../$4.fsa
rm *.fsa
mv ../$4.fsa $4.fsa
