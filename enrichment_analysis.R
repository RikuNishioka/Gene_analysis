
out_path <- "/Users/nishiokariku/Desktop/test"
self_path <- "/Users/nishiokariku/Dropbox/Nishioka/Research/Code/R/Gene_analysis/module"




# devtools::install_github("YuLab-SMU/clusterProfiler.dplyr")
# library(msigdbr)
library(clusterProfiler)
library(DOSE)
library(enrichplot)
# library(forcats)
library(ggplot2)
# library(ggstance)
library(clusterProfiler.dplyr)


source(file.path(self_path, "visualization_gsea.R"))



setwd(out_path)
data(geneList, package="DOSE")
geneset_C5 <- msigdbr(species = "Homo sapiens", category = "C5") %>% 
  dplyr::select(gs_name, entrez_gene)


result_gsea <- GSEA(geneList, TERM2GENE = geneset_C5)

#ridgeplot
ggsave(file=file.path(out_path, "ridgeplot.png"), plot=ridgeplot(result_gsea), width=14, height=20, limitsize=FALSE)

#dotplot
plot_dotplot = dotplot(result_gsea, showCategory = 10, font.size = 8,
                       x = "GeneRatio",   # option -> c("GeneRatio", "Count")
                       color = "p.adjust")   # option -> c("pvalue", "p.adjust", "qvalue")

#GSEAplot
visualize_gsea(result_gsea, number=5)







