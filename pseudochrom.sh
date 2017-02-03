#!/bin/bash
#Usage: sh pseudochrom.sh <path to input files>
#lmc297@cornell.edu

cd $1
mkdir original_contigs

for f in *.fasta
do
cp $f original_contigs
sed -i 's/^>NODE.*/NNnnNNnnNNnnNNnn/' $f
sed -i "1i >${f}" $f
awk '/^>/{print s? s"\n"$0:$0;s="";next}{s=s sprintf("%s",$0)}END{if(s)print s}' $f > ${f%.fasta}_pseudochrom.fasta
rm -r $f
done
