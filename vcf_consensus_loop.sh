#!/bin/bash
#Usage: sh vcf_consensus_loop.sh <path to input files> <reference.fasta>
#lmc297@cornell.edu

cd $1

for f in *.vcf.gz
do
cat $2 | vcf-consensus $f > ${f%.vcf.gz}_consensus.fasta
done
