#dk657@cornell.edu

genes <- read.delim("unique.txt",
                    sep="\n",
                    quote="",
                    colClasses="character",
                    header=F,
                    strip.white=T)[,1]

gene_matrix <- data.frame(t(rep(0,4876)))
names(gene_matrix) <- c("isolate",genes)
gene_matrix$isolate <- as.character(gene_matrix$isolate)

for( f in list.files() ) {
        if( !grepl("spreadsheet", f) )
                next
        cat(paste(f,'\n'))
        temp <- read.delim(f,
                           header=T,
                           colClasses="character",
                           quote="",
                           strip.white=T)[,8]
        c(f,genes %in% temp)
        temp_frame <- data.frame(f,t(as.integer(genes %in% temp)))
        names(temp_frame) <- names(gene_matrix)
        gene_matrix <- rbind(gene_matrix,temp_frame)
}

gene_matrix <- gene_matrix[2:nrow(gene_matrix),]

write.table(gene_matrix,"gene_matrix.txt",row.names = F,sep = "\t")
