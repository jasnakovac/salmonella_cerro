# load data
odata <- read.delim(file = "cerro_genematrix.txt",header = TRUE, sep = "\t")

# change rownames to isolate names 
rownames(odata)<-odata[,1]
odata<-odata[,2:ncol(odata)]

# get rid of all 0 columns
no_zeros<-odata[,which(!apply(odata,2,FUN = function(x){all(x == 0)}))] 

# get rid of all 1 columns
no_all<-no_zeros[,which(!apply(no_zeros,2,FUN = function(x){all(x == 1)}))]

# Fisher's Exact Test
genep<-c()
all.genes<-c()
final<-no_all

# create a column in a dataset called classes where you specify the class of each isolate
final$classes <- ifelse(grepl("CTX_",rownames(final)), "CTX", "Other")

# create the final table
final<-cbind(final$classes,final[,1:ncol(final)-1])

# loop through all genes and do fisher.test; isolate class is in column 1
for( gene in 2:length(final) ) {
  temp_table <- table(final[,c(1,gene)])
  # if there are more than 5 copies of the gene and less than n-5, do fisher.test
  if ( (sum(temp_table[,1])>5) & (sum(temp_table[,2])>5) ){
    all.genes<-append(all.genes,colnames(final)[gene])
    print(temp_table)
    mytest<-fisher.test(temp_table)
    print(fisher.test(temp_table))
    genep<-append(genep,mytest$p.value)
  }
}

# all p values
genep
genenames<-which(genep<0.05) 
genenames

# p<0.05
genep[genenames]

# names of genes with p<0.05
all.genes[genenames]

# control FDR
new_p<-p.adjust(p = genep,method = "hochberg")
newgenenames<-which(new_p<0.05)

# corrected p,0.05
pvalues <- new_p[newgenenames]

# names of genes with corrected p<0.05
gene_names <- all.genes[newgenenames]
gene_names
