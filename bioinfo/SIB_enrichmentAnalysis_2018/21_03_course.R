#============================================================================
# Exercise 1
#============================================================================

rat_DT <- read.delim("data/rat_KD.txt", header=T, row.names = 1)

probeQuery <- "1398751_at"

cond1_samples <- colnames(rat_DT)[grep("control.diet", colnames(rat_DT))]
cond2_samples <- colnames(rat_DT)[grep("ketogenic.diet", colnames(rat_DT))]

t.test(rat_DT[probeQuery, cond1_samples], rat_DT[probeQuery, cond2_samples])

all_t_tests <- apply(rat_DT, 1, function(x) {
  t.test(x[cond1_samples], x[cond2_samples])$p.value
})

stopifnot(length(all_t_tests) == nrow(rat_DT))

all_t_tests_adj <- p.adjust(sort(all_t_tests), method="BH")

signifThresh <- 0.01

sum(all_t_tests <= signifThresh)
# 1906
sum(all_t_tests_adj <= signifThresh)
# 11

# compute the log fold changes
all_logFC <- apply(rat_DT, 1, function(x) {
  log2(mean(x[cond1_samples])/mean(x[cond2_samples]))
})

x_logFC <- all_logFC
y_pval <- -log10(all_t_tests_adj[names(all_logFC)])
plot(x = x_logFC,
     y = y_pval,
     xlab="log2 gene expression FC",
     ylab = "-log10 adj. pval",
     pch=16, cex = 0.7)
legend("topleft", legend=paste0("n = ", length(x_logFC)), bty="n")

#============================================================================
# GSEA
#============================================================================

# source("https://bioconductor.org/biocLite.R")
# biocLite("clusterProfiler")
library(clusterProfiler)

# load data
gseaDT <- read.delim("data/GSEA_data_input.csv", header=T, sep=",", stringsAsFactors = F)

df_case1 <- data.frame(gseaDT$gene.ID, gseaDT$scores, gseaDT$case1)
colnames(df_case1) <- c("ID","score","PATHWAY")
head(df_case1)

# set score (those you get from a t-test or any other statistical test)
SCORE <- df_case1$score
names(SCORE) <- df_case1$ID
SCORE <- sort(SCORE,decreasing=TRUE)
head(SCORE)

# get phenotype (term)
term2gene_case1 <- data.frame(term=df_case1$PATHWAY, name=df_case1$ID)
head(term2gene_case1)

# run GSEA
# gsea.out_case1 <- GSEA(SCORE, TERM2GENE=term2gene_case1, nPerm=10000, pvalueCutoff=1, pAdjustMethod = "BH")
# 10000 is a good number
gsea.out_case1 <- GSEA(SCORE, TERM2GENE=term2gene_case1, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_case1, "PATHWAY")

#============================================================================
# Exercise 2
#============================================================================
# for the GSEA:
# one vector with the scores (named with gene IDs)
# one data frame with gene IDs and whether in pathway or not

# adjusted p-values as an input

# pAdjust -> only if testing > 1 pathway

### 1) 
path1DT <- read.delim("data/Pathway.csv", sep=",", stringsAsFactors = F)

term2gene_path1 <- path1DT[, c("pathways", "row.names")]
colnames(term2gene_path1) <- c("term", "name")

ttest_pvals <- sort(all_t_tests_adj, decreasing = T)

# pvalueCutoff -> 1 to see all results
gsea.out_path1 <- GSEA(ttest_pvals, TERM2GENE=term2gene_path1, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_path1, "yes")
summary(gsea.out_path1)


### 2) 
library("AnnotationDbi")
library("rat2302.db")

PROBES <- rownames(rat_DT)
OUT <- select(rat2302.db, keys = PROBES, columns = c("SYMBOL", "ENTREZID", "GENENAME"))

# warning about multi mapping; NA if not found -> but this is ok

### 3) 

riboProtGenes <- OUT$PROBEID[grepl("ribosomal protein", OUT$GENENAME)]

# OR:
riboProtGenes <- OUT$PROBEID[which(OUT$GENENAME %like% "ribosomal protein"),]
#internally, "like" uses grepl

term2gene_riboPath <- data.frame( 
  term = unlist(sapply(rownames(rat_DT), function(x) ifelse(x %in% riboProtGenes, "PATHWAY", "NO"))),
  name = rownames(rat_DT),
  stringsAsFactors=F)
rownames(term2gene_riboPath) <- NULL

# pAdjust useless because 1 pathway
gsea.out_riboPath <- GSEA(ttest_pvals, TERM2GENE=term2gene_riboPath, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_riboPath, "PATHWAY")


#============================================================================
# Exercise 3
#============================================================================

gseaDT <- read.delim("data/GSEA_data_input.csv", sep=",", stringsAsFactors = F)

gene_scores <- sort(setNames(gseaDT$scores, gseaDT$gene.ID), decreasing = TRUE)

term2gene_case1 <- gseaDT[,c("case1", "gene.ID")]
colnames(term2gene_case1) <- c("term", "name")
gsea.out_case1 <- GSEA(gene_scores, TERM2GENE=term2gene_case1, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_case1, "PATHWAY")
summary(gsea.out_case1)
# 0.00990099

term2gene_case2 <- gseaDT[,c("case2", "gene.ID")]
colnames(term2gene_case2) <- c("term", "name")
gsea.out_case2 <- GSEA(gene_scores, TERM2GENE=term2gene_case2, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_case2, "PATHWAY")
summary(gsea.out_case2)
# 0.00990099

term2gene_case3 <- gseaDT[,c("case3", "gene.ID")]
colnames(term2gene_case3) <- c("term", "name")
gsea.out_case3 <- GSEA(gene_scores, TERM2GENE=term2gene_case3, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_case3, "PATHWAY")
summary(gsea.out_case3)
# 0.2600000

term2gene_case4 <- gseaDT[,c("case4", "gene.ID")]
colnames(term2gene_case4) <- c("term", "name")
gsea.out_case4 <- GSEA(gene_scores, TERM2GENE=term2gene_case4, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
gseaplot(gsea.out_case4, "PATHWAY")
summary(gsea.out_case4)
# 0.25

term2gene_case5 <- gseaDT[,c("case5", "gene.ID")]
colnames(term2gene_case5) <- c("term", "name")
gsea.out_case5 <- GSEA(gene_scores, TERM2GENE=term2gene_case5, nPerm=100, pvalueCutoff=1, pAdjustMethod = "BH")
# par(mfrow=c(1,2))
gseaplot(gsea.out_case5, c("PATHWAY1")) # near the left
gseaplot(gsea.out_case5, c("PATHWAY2")) # near the left, more sparse
summary(gsea.out_case5)
# look at adj. pval
# PATHWAY 1 -  0.03030303
# PATHWAY 2 - 0.03614458


# A)
# Fisher test
scoreThresh <- 0.17
gseaDT$diff_expr <- ifelse(gseaDT$scores >= scoreThresh, "DE", "NOT_DE")


matFisher_case1 <- table(gseaDT$diff_expr, gseaDT$case1)
matFisher_case1
fisher.test(matFisher_case1)

matFisher_case2 <- table(gseaDT$diff_expr, gseaDT$case2)
matFisher_case2
fisher.test(matFisher_case2)

matFisher_case3 <- table(gseaDT$diff_expr, gseaDT$case3)
matFisher_case3
fisher.test(matFisher_case3)

matFisher_case4 <- table(gseaDT$diff_expr, gseaDT$case4)
matFisher_case4
fisher.test(matFisher_case4)

# do separately for each pathway !!!
matFisher_case5 <- table(gseaDT$diff_expr, gseaDT$case5)
matFisher_case5_a <- matFisher_case5[,1:2]
fisher.test(matFisher_case5_a)
matFisher_case5_b <- matFisher_case5[,c(1,3)]
fisher.test(matFisher_case5_b)

#============================================================================
# gseGO
#============================================================================
# gene list wwith all the scores, with gene names ensembl or entrez format

gsecc <- gseGO(geneList = geneList,
               OrgDb = org.Hs.eg.db,
               ont = "ALL",
               nPerm = 100,
               pvalueCutoff = 1,
               verbose=F)
# plot the most significant p-value
gseaplot(gsecc, geneSetId = "GO:000079")

dotplot(ego, showCategory = 30)

# see connection between the GO terms
enrichMap

# GO graph
plotGOgraph(ego)

# GO: cellular compounds, etc.
# KEGG: not ontology based, useful for disease

#============================================================================
# Exercise 4
#============================================================================
library(org.Hs.eg.db)
hspvalDT <- read.delim("data/HS_pvalues.csv", header=T, sep=",")

# 1) 
# look for GO ontologies 
geneList <- sort(setNames(hspvalDT$scores, hspvalDT$gene.ENTREZ.ID), decreasing = T)


hs_gseGO <- gseGO(geneList = geneList,
                  OrgDb = org.Hs.eg.db,
                  ont = "ALL",
                  nPerm = 1000,
                  pvalueCutoff = 1,
                  verbose=F)


resultDT <- hs_gseGO@result[,c("ID", "p.adjust")]
resultDT <- resultDT[order(resultDT$p.adjust),]
rownames(resultDT) <- NULL

dotplot(hs_gseGO, showCategory = 30)

topGO <- resultDT$ID[1]
hs_gseGO@geneSets[[topGO]]
gseaplot(hs_gseGO, geneSetID = topGO)


hs_enrichGO <- enrichGO(gene = names(geneList),
                  OrgDb = org.Hs.eg.db,
                  ont = "ALL",
                  # nPerm = 1000,
                  pvalueCutoff = 1)

barplot(hs_enrichGO, showCategory = 10)
#============================================================================
# Exercise extra
#============================================================================

rat_DT <- read.delim("data/rat_KD.txt", header=T, row.names = 1)

all_t_tests <- apply(rat_DT, 1, function(x) {
  t.test(x[cond1_samples], x[cond2_samples])$p.value
})

all_fc <- apply(rat_DT, 1, function(x) {
  log2(mean(x[cond1_samples])/mean(x[cond2_samples]))
})


all_t_tests_adj <- p.adjust(sort(all_t_tests, decreasing = T), method="BH")

MAP_GENES <- select(rat2302.db, keys = names(all_t_tests_adj), columns = c("SYMBOL", "ENTREZID", "GENENAME"))

entrez_names <- sapply(names(all_t_tests_adj), function(x) MAP_GENES$ENTREZID[MAP_GENES$PROBEID == x])
# or we could remove duplicates
entrez_names <- unlist(sapply(names(all_t_tests_adj), function(x) MAP_GENES$ENTREZID[MAP_GENES$PROBEID == x][1]))

stopifnot(names(entrez_names) == names(all_t_tests_adj))

all_t_tests_adj_entrezNames <- all_t_tests_adj
all_t_tests_adj_entrezNames <- all_t_tests_adj_entrezNames[!is.na(entrez_names)]
names(all_t_tests_adj_entrezNames) <- entrez_names[!is.na(entrez_names)]

########## GO enrichment

rat_gseGO <- gseGO(geneList = all_t_tests_adj_entrezNames,
                  OrgDb = org.Rn.eg.db,
                  ont = "ALL",
                  nPerm = 1000,
                  pvalueCutoff = 1,
                  verbose=F)

resultDT <- rat_gseGO@result[,c("ID", "p.adjust")]
resultDT <- resultDT[order(resultDT$p.adjust),]
rownames(resultDT) <- NULL

dotplot(rat_gseGO, showCategory = 10)
enrichMap(rat_gseGO)
# hack the GO error
rat_gseGO@setType <- "BP"
plotGOgraph(rat_gseGO)

# barplot works with enrichGO
# barplot(rat_gseGO, showCategory = 10)

########## KEGG enrichment

rat_gseKEGG <- gseKEGG(geneList = all_t_tests_adj_entrezNames,
                   organism = "rno",
                   keyType = "kegg",
                   nPerm = 1000,
                   pvalueCutoff = 1,
                   verbose=F)

resultDT <- rat_gseKEGG@result[,c("ID", "p.adjust")]
resultDT <- resultDT[order(resultDT$p.adjust),]
rownames(resultDT) <- NULL

########### DIRECTION UP/DOWN REGULATED
rat_DT <- read.delim("data/rat_KD.txt", header=T, row.names = 1)

MAP_GENES <- select(rat2302.db, keys = names(all_t_tests_adj), columns = c("SYMBOL", "ENTREZID", "GENENAME"))
dup_probes <- MAP_GENES$PROBEID[duplicated(MAP_GENES$PROBEID)]
MAP_GENES <- MAP_GENES[!MAP_GENES$PROBEID %in% dup_probes,]
MAP_GENES <- MAP_GENES[!is.na(MAP_GENES$ENTREZID),]
dup_entrez <- MAP_GENES$ENTREZID[duplicated(MAP_GENES$ENTREZID)]
MAP_GENES <- MAP_GENES[!MAP_GENES$ENTREZID %in% dup_entrez,]


rat_DT <- rat_DT[rownames(rat_DT) %in% MAP_GENES$PROBEID,]
rownames(rat_DT) <- unlist(sapply(rownames(rat_DT), function(x) MAP_GENES$ENTREZID[MAP_GENES$PROBEID == x]))

all_t_tests <- apply(rat_DT, 1, function(x) {
  t.test(x[cond1_samples], x[cond2_samples])$p.value
})

all_fc <- apply(rat_DT, 1, function(x) {
  log2(mean(x[cond1_samples])/mean(x[cond2_samples]))
})


# dataframe with list of scores
resExp <- data.frame(pval = all_t_tests, log2FC = all_fc, name = rownames(rat_DT), stringsAsFactors = FALSE)

# group with 3 col, ensembl/foldchange/group


