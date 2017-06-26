#!/usr/bin/python
#Usage: python multifasta_creator.py <path to input files>
#lmc297@cornell.edu

from Bio.Seq import Seq
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
import sys
import os
import glob

cmdargs = str(sys.argv)

os.chdir(sys.argv[1])

path = glob.glob("*_renamed.fasta")

for f in path:
	finalseq = open('cortex_alignment.fasta', 'a')
        for record in SeqIO.parse(f, "fasta"):
		newseqid = str(record.id)
                newseqseq = str(record.seq)
        print >> finalseq, '>'+newseqid
        print >>finalseq, newseqseq
        finalseq.close()
