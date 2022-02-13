library("DESeq2")
cts <- as.matrix(read.csv("counttable.txt",sep="\t",header=TRUE,check.names=FALSE,row.names=1))
head(cts)
coldata <- read.csv("coldata.txt",sep="\t",header=TRUE,check.names=FALSE,row.names=1)
head(coldata)
coldata <- coldata[,c("condition","type")]
dds<-DESeqDataSetFromMatrix(countData=cts,colData=coldata,design=~condition)
dds<-DESeq(dds)


cts <- as.matrix(read.csv("star_counts.tab",sep="\t",header=TRUE,check.names=FALSE,row.names=1))
head(cts)
coldata <- read.csv("star_data.tab",sep="\t",header=TRUE,check.names=FALSE,row.names=1)
head(coldata)
coldata <- coldata[,c("condition","type")]
dds<-DESeqDataSetFromMatrix(countData=cts,colData=coldata,design=~condition)
dds<-DESeq(dds)



library(ggplot2)
rld<-rlog(dds,blind=FALSE)
z <- plotPCA(rld)
nudge <- position_nudge(y = 3)
z + geom_label(aes(label = condition), position = nudge)
nudge <- position_nudge(y = 3)
z + geom_text(aes(label = condition), position = nudge)+ geom_point(size=2) + geom_label_repel(aes(label = rownames(data)),box.padding   = 0.35, point.padding = 0.5,segment.color = 'grey50')

library(ggplot2)
library(ggrepel)
rld<-rlog(dds,blind=FALSE)
#rld<-vst(dds, blind=FALSE)
data <- plotPCA(rld, returnData=TRUE)
percentVar <- round(100 * attr(data, "percentVar"))
qplot(data$PC1, data$PC2, color=data$group, data=data) + xlab(paste0("PC1: ",percentVar[1],"% variance")) + ylab(paste0("PC2: ",percentVar[2],"% variance")) + geom_point(size=2) + geom_label_repel(aes(label = dds$condition),box.padding   = 0.35, point.padding = 0.5,segment.color = 'grey50')

counts <- counts(dds, normalized=TRUE)
write.table(counts, file = "normalized_counts.txt", sep = "\t", quote = FALSE)

comp1 <- results(dds, contrast = c("condition", "phyB_untreated", "WT_untreated"))
resultsNames(comp1)
res1sig <- comp1[which(comp1$padj<0.05),]
write.table(res1sig, file = "Comp1_WT_untreated_vs_phyB_untreated.txt", sep = "\t", quote = FALSE)

comp2 <- results(dds, contrast = c("condition", "rbohD_untreated", "WT_untreated"))
resultsNames(comp2)
res2sig <- comp2[which(comp2$padj<0.05),]
write.table(res2sig, file = "Comp2_WT_untreated_vs_rbohD_untreated.txt", sep = "\t", quote = FALSE)

comp3 <- results(dds, contrast = c("condition", "rbohF_untreated", "WT_untreated"))
resultsNames(comp3)
res3sig <- comp3[which(comp3$padj<0.05),]
write.table(res3sig, file = "Comp3_WT_untreated_vs_rbohF_untreated.txt", sep = "\t", quote = FALSE)

comp4 <- results(dds, contrast = c("condition", "WT_white", "WT_untreated"))
resultsNames(comp4)
res4sig <- comp4[which(comp4$padj<0.05),]
write.table(res4sig, file = "Comp4_WT_untreated_vs_WT_white.txt", sep = "\t", quote = FALSE)

comp5 <- results(dds, contrast = c("condition", "WT_red", "WT_untreated"))
resultsNames(comp5)
res5sig <- comp5[which(comp5$padj<0.05),]
write.table(res5sig, file = "Comp5_WT_untreated_vs_WT_red.txt", sep = "\t", quote = FALSE)


comp6 <- results(dds, contrast = c("condition", "phyB_white", "phyB_untreated"))
resultsNames(comp6)
res6sig <- comp6[which(comp6$padj<0.05),]
write.table(res6sig, file = "Comp6_phyB_untreated_vs_phyB_white.txt", sep = "\t", quote = FALSE)

comp7 <- results(dds, contrast = c("condition", "phyB_red", "phyB_untreated"))
resultsNames(comp7)
res7sig <- comp7[which(comp7$padj<0.05),]
write.table(res7sig, file = "Comp7_phyB_untreated_vs_phyB_red.txt", sep = "\t", quote = FALSE)


comp8 <- results(dds, contrast = c("condition", "rbohD_white", "rbohD_untreated"))
resultsNames(comp8)
res8sig <- comp8[which(comp8$padj<0.05),]
write.table(res8sig, file = "Comp8_rbohD_untreated_vs_rbohD_white.txt", sep = "\t", quote = FALSE)

comp9 <- results(dds, contrast = c("condition", "rbohD_red", "rbohD_untreated"))
resultsNames(comp9)
res9sig <- comp9[which(comp9$padj<0.05),]
write.table(res9sig, file = "Comp9_rbohD_untreated_vs_rbohD_red.txt", sep = "\t", quote = FALSE)

comp10 <- results(dds, contrast = c("condition", "rbohF_white", "rbohF_untreated"))
resultsNames(comp10)
res10sig <- comp10[which(comp10$padj<0.05),]
write.table(res10sig, file = "Comp10_rbohF_untreated_vs_rbohF_white.txt", sep = "\t", quote = FALSE)

comp11 <- results(dds, contrast = c("condition", "rbohF_red", "rbohF_untreated"))
resultsNames(comp11)
res11sig <- comp11[which(comp11$padj<0.05),]
write.table(res11sig, file = "Comp11_rbohF_untreated_vs_rbohF_red.txt", sep = "\t", quote = FALSE)







