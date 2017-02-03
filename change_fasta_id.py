#!/usr/bin/python
#Usage: python change_fasta_id.py <path to directory individuals>
#lmc297@cornell.edu

from Bio.Seq import Seq
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
import sys
import os
import glob

cmdargs = str(sys.argv)

path = glob.glob("*_consensus.fasta")

for f in path:
        temp = str(f)
        tag = temp.split(".")[0]
        finalseq = open(tag+'_renamed.fasta', 'a')
        for record in SeqIO.parse(f, "fasta"):
                newseqseq = str(record.seq)
        print >> finalseq, '>'+tag
        print >>finalseq, newseqseq
        finalseq.close()
print "Sequences created!  Squad goin' up!"
