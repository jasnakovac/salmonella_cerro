#RASTtk batch genome annotation
#jk2739@cornell.edu

#Open RASTtk app
#Login from the command line
kbase-login <username>

#Move all the contig files in the ToSubmit directory
#Convert fasta files into genome typed objects
cd <path to ToSubmit directory>

for f in *.fasta 
do
rast-create-genome --scientific-name "${f%.fasta}" --genetic-code 11 --domain Bacteria --contigs $f > ToSubmit/${f%.fasta}
done

#Submit a genome batch for annotation (NOTE: there is a limit for the number of characters in file names)
rast-process-genome-batch ToSubmit 

#Save a job id
#Use a job id to follow a job progress
rast-query-genome-batch <job_id> > rast_job_id.txt
