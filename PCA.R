#PCA analysis
#Input is a .csv numeric genotype file (gene presence/absence)
#jk2739@cornell.edu

library(ggplot2)
library(cluster)

#Read csv file with genotypes (binary; gene presence/absence)
data <- read.delim(file = "cerro_genematrix_102016geo.csv",header = TRUE, sep = ",")
data <- data[,2:dim(data)[2]]

#Remove constant columns function
remove.constant.values<-function(x,MARGIN,value2remove) { 
        is.constant.line<-function(x,value2remove) { return(any(x!=value2remove)) } 
        return(unlist(apply(x,MARGIN,is.constant.line,value2remove))) 
} 

#Remove constant columns x = input data, 2 = column, 0/1 = constant value to remove
data <- data[,remove.constant.values(data,2,0)] 
data <- data[,remove.constant.values(data,2,1)] 

#Assuming that the final column holds the species, this array holds the column
gene_columns <- 1:(dim(data)[2]-1)

#Perform the PCA on the binary gene matrix
pca <- prcomp(data[,gene_columns],
              center=TRUE,
              scale=TRUE)
summary(pca)

#Extract eigenvectors from pca
eigenvectors <- data.frame(pca$rotation)
eigenvectors$gene <- factor(row.names(eigenvectors))
eigenvectors$PC1

#Place the PCA coordinates back onto the dataframe
data <- cbind(data,predict(pca))
pca_columns <- (max(gene_columns) + 2):dim(data)[2]

#Plot without labels
g1 <- ggplot(data, aes(x=PC1, y=PC2, size=PC3))
g1 <- g1 + geom_point() +
        theme_bw()
g1

#Plot with labels
g2 <- ggplot(data, aes(x=PC1, y=PC2, size=PC3)) + theme_bw() + geom_point(aes(color=origin)) 
g2
