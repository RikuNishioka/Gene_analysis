
out_path <- "/Users/nishiokariku/Desktop/test"
self_path <- "/Users/nishiokariku/Dropbox/Nishioka/Research/Code/R/Gene_analysis/module"




# devtools::install_github("YuLab-SMU/clusterProfiler.dplyr")
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
library(renv)
library(msigdbr)
library(clusterProfiler)
library(DOSE)
library(enrichplot)
library(forcats)
library(ggplot2)
library(ggridges)
library(clusterProfiler.dplyr)


source(file.path(self_path, "visualization_gsea.R"))



setwd(out_path)
data(geneList, package="DOSE")
geneset_C5 <- msigdbr(species = "Homo sapiens", category = "C5") %>% 
  dplyr::select(gs_name, entrez_gene)



#GSEA_analysis
result_gsea <- GSEA(geneList, TERM2GENE = geneset_C5)
GSEA_analysis(result_gsea, number=5)


#Gene_
geneList_name <- names(geneList)[abs(geneList) > 2]
enrich_result <- enrichDGN(geneList_name)

## Gene-Concept Network ##
## convert gene ID to Symbol
edox <- setReadable(edo, 'org.Hs.eg.db', 'ENTREZID')
p1 <- cnetplot(edox, foldChange=geneList)
## categorySize can be scaled by 'pvalue' or 'geneNum'
p2 <- cnetplot(edox, categorySize="pvalue", foldChange=geneList)
p3 <- cnetplot(edox, foldChange=geneList, circular = TRUE, colorEdge = TRUE) 
cowplot::plot_grid(p1, p2, p3, ncol=3, labels=LETTERS[1:3], rel_widths=c(.8, .8, 1.2))



# #cneplot
# p1 <- cnetplot(result_gsea, showCategory = (3*2), colorEdge = TRUE, node_label = "category")
# cowplot::plot_grid(p1, ncol=1, labels=LETTERS[1], rel_widths=c(1))

# #enrichment map
# result_gsea_2 <- mutate(result_gsea, ordering = abs(NES)) %>%
#   arrange(desc(ordering)) 
# p2 <- emapplot(result_gsea_2, showCategory = 10)
# cowplot::plot_grid(p2, ncol = 1, lables = LETTERS[1])


