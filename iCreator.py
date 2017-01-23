#!/usr/bin/python
# Usage: python iCreator.py

import os,re

fileList = [f for f in os.listdir('.') if f.endswith('.trimmedP.fastq.gz')]

FSLSet = {f[0:11] for f in os.listdir('.') if f.endswith('.trimmedP.fastq.gz')}

for f in fileList:
    seHandle = open(f+'.se','w')
    seHandle.write(os.path.abspath(f)+'\n')
    seHandle.close()

indexHandle = open('index','w')
for fsl in FSLSet:
    line = [fsl,'.',[f+'.se' for f in fileList if re.match(fsl+'.+R1',f)][0],[f+'.se' for f in fileList if re.match(fsl+'.+R2',f)][0]]
    indexHandle.write('\t'.join(line)+'\n')
indexHandle.close()
