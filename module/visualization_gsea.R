

GSEA_analysis <- function(result_gsea, number=5){
  
  cur_dir <- getwd()
  if(!(file.exists("GSEA"))){
    dir.create("GSEA")
    dir.create(file.path("GSEA", "GSEA_plot"))
  }
  setwd(file.path(cur_dir, "GSEA"))
  #GSEA_plot
  visualize_gsea(result_gsea, number=number)
  
  #Ridge_plot
  ggsave(file="ridgeplot.png", plot=ridgeplot(result_gsea), width=14, height=20, limitsize=FALSE)
  
  #Bar_plot
  y <- mutate(result_gsea, ordering = abs(NES)) %>% arrange(desc(ordering)) 
  y_bar <- group_by(y, sign(NES)) %>% slice(1:number*2)
  p_bar = ggplot(y_bar, aes(NES, fct_reorder(Description, NES), fill = qvalues), showCategory=(number*2)) + 
    geom_bar(stat='identity') + 
    scale_fill_continuous(low='red', high='blue', guide=guide_colorbar(reverse=TRUE)) + 
    theme_minimal() + ylab(NULL) + 
    theme(text = element_text(size = 24))
  ggsave(file="barplot.png", plot=p_bar, width=35, height=15, limitsize=FALSE, bg="White")
  setwd(cur_dir)
}







visualize_gsea <- function(result_gsea, number=5){
  result_gsea_nes_upper = arrange(result_gsea, desc(NES))
  result_gsea_nes_lower = arrange(result_gsea, NES)
  
  for(i in 1:number){
    p_gsea_upper <- gseaplot(result_gsea_nes_upper, geneSetID = i, title = result_gsea_nes_upper$Description[i])
    p_gsea_lower <- gseaplot(result_gsea_nes_lower, geneSetID = i, title = result_gsea_nes_lower$Description[i])
    
    ggsave(file=file.path("GSEA_plot", paste0(result_gsea_nes_upper$Description[i], ".png")), plot=p_gsea_upper)
    ggsave(file=file.path("GSEA_plot", paste0(result_gsea_nes_lower$Description[i], ".png")), plot=p_gsea_lower)
    
  }

}


