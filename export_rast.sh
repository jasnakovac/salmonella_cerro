#RASTtk annotation spreadsheet and gbk files export
#jk2739@cornell.edu

#Open RASTtk app
#Login from the command line
kbase-login <username>

#Export RAST-style spreadsheets; tab-separated text format
mkdir spreadsheets # in the Output directory
for f in *.gto
do
rast-export-genome spreadsheet_txt < ${f%.gto}.gto > spreadsheets/${f%.gto}_spreadsheet.txt
done

#Export genbank files
mkdir genbank # in the Output directory
for f in *.gto
do
rast-export-genome genbank_merged < ${f%.gto}.gto > genbank/${f%.gto}.gbk
done

#Extract unique genes for building the pangenome presence/absence matrix
cat *.txt|awk -F"\t" '{print " "$8" "}'|sort|uniq > unique.txt
