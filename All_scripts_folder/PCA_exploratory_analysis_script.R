library("DESeq2")
cts <- as.matrix(read.csv("counttable.txt",sep="\t",header=TRUE,check.names=FALSE,row.names=1))
head(cts)
coldata <- read.csv("coldata.txt",sep=",",header=TRUE,check.names=FALSE,row.names=1)
head(coldata)
coldata <- coldata[,c("condition","type")]
dds<-DESeqDataSetFromMatrix(countData=cts,colData=coldata,design=~condition)
dds<-DESeq(dds)

counts1 <- counts(dds, normalized=TRUE)
write.csv(counts1, "normalized_counts.csv", quote = FALSE)

library(tidyverse)
library(ggrepel)
#?read_csv
trans_cts <- read_csv("normalized_counts.csv")
glimpse(trans_cts)
sample_info <- read_csv("coldata.txt")
glimpse(sample_info)
pca_matrix <- trans_cts %>% 
  column_to_rownames("genes") %>% 
  as.matrix() %>% 
  t()
sample_pca <- prcomp(pca_matrix)
pca_matrix[1:10, 1:5]
glimpse(sample_pca)
as_tibble(pca_matrix, rownames = "sample")

#Create a vector with variance by each of 72 PC axis
pc_eigenvalues <- sample_pca$sdev^2
# create a "tibble" manually with 
# a variable indicating the PC number
# and a variable with the variances
pc_eigenvalues <- tibble(PC = factor(1:length(pc_eigenvalues)), 
                         variance = pc_eigenvalues) %>% 
  # add a new column with the percent variance
  mutate(pct = variance/sum(variance)*100) %>% 
  # add another column with the cumulative variance explained
  mutate(pct_cum = cumsum(pct))
pc_eigenvalues
pc_eigenvalues %>% 
  ggplot(aes(x = PC)) +
  geom_col(aes(y = pct)) +
  geom_line(aes(y = pct_cum, group = 1)) + 
  geom_point(aes(y = pct_cum)) +
  labs(x = "Principal component", y = "Fraction variance explained")
#Visualising samples on PC space
pc_scores <- sample_pca$x
pc_scores <- pc_scores %>% 
  # convert to a tibble retaining the sample names as a new column
  as_tibble(rownames = "sample")

# print the result
pc_scores

pca_plot <- sample_pca$x %>% 
  # convert it to a tibble
  as_tibble(rownames = "sample") %>% 
  # join with "sample_info" table
  full_join(sample_info, by = "sample") %>% 
  # make the plot
  ggplot(aes(x = PC1, y = PC2, 
             colour = condition)) +
  geom_point()+
  geom_label_repel(aes(label = sample),box.padding   = 0.35, point.padding = 0.5,segment.color = 'grey50')
pca_plot
###Exploring correlation between genes and PCs

pc_loadings <- sample_pca$rotation
pc_loadings <- pc_loadings %>% 
  as_tibble(rownames = "gene")
pc_loadings
# print the result
glimpse(pc_loadings)
#rm(top_loadings)

top_genes_desc <- pc_loadings %>% 
  #filter out values with pc loadings 0
  filter(PC1 != 0) %>% 
  filter(PC2 != 0) %>% 
  filter(PC3 != 0) %>% 
  filter(PC4 != 0) %>% 
  filter(PC5 != 0) %>% 
  # select only the PCs we are interested in
  dplyr::select("gene", PC1, PC2, PC3, PC4, PC5) %>% 
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  arrange(desc(abs(loading))) %>% 
  # take the 100 top rows
  slice(1:250) %>% 
  # arrange by ascending order of loading
  #arrange(abs(loading)) %>% 
  # take the 100 top rows
  #slice(1:150) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()
top_genes_desc
top_loadings_desc <- pc_loadings %>% 
  filter(gene %in% top_genes_desc)
top_loadings_desc
write.table(top_loadings_desc, file = "4.top_500_PC_eigenvalues.txt", sep = "\t", quote = F, row.names = F)


top_genes_asc <- pc_loadings %>% 
  #filter out values with pc loadings 0
  filter(PC1 != 0) %>% 
  filter(PC2 != 0) %>% 
  filter(PC3 != 0) %>% 
  filter(PC4 != 0) %>% 
  filter(PC5 != 0) %>% 
  # select only the PCs we are interested in
  dplyr::select("gene", PC1, PC2, PC3, PC4, PC5) %>% 
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  #arrange(desc(abs(loading))) %>% 
  # take the 100 top rows
  #slice(1:150) %>% 
  # arrange by ascending order of loading
  arrange(abs(loading)) %>% 
  # take the 100 top rows
  slice(1:30) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()

top_genes_asc
top_loadings_asc <- pc_loadings %>% 
  filter(gene %in% top_genes_asc)
top_loadings_asc

write.table(top_loadings_asc, file = "4.bottom_150_genes_PC_eigenvalues_WT_singleMutants.txt", sep = "\t", quote = F, row.names = F)

##All genes
top_genes_all <- pc_loadings %>% 
  #filter out values with pc loadings 0
  # filter(PC1 != 0) %>% 
  # filter(PC2 != 0) %>% 
  # filter(PC3 != 0) %>% 
  # filter(PC4 != 0) %>% 
  # filter(PC5 != 0) %>% 
  # select only the PCs we are interested in
  dplyr::select("gene", PC1, PC2, PC3, PC4, PC5) %>% 
  # convert to a "long" format
  pivot_longer(matches("PC"), names_to = "PC", values_to = "loading") %>% 
  # for each PC
  group_by(PC) %>% 
  # arrange by descending order of loading
  # arrange(desc(abs(loading))) %>% 
  # take the 100 top rows
  #slice(1:60) %>% 
  # arrange by ascending order of loading
  #arrange(abs(loading)) %>% 
  # take the 100 top rows
  #slice(1:150) %>% 
  # pull the gene column as a vector
  pull(gene) %>% 
  # ensure only unique genes are retained
  unique()
top_genes_all
top_loadings_all <- pc_loadings %>% 
  filter(gene %in% top_genes_all)
top_loadings_all
write.table(top_loadings_all, file = "4.All_genes_PC_eigenvalues_WT_singleMutants.txt", sep = "\t", quote = F, row.names = F)
