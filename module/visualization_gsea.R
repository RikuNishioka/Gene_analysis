
visualize_gsea <- function(result_gsea, number=5){
  result_gsea_nes_upper = arrange(result_gsea, desc(NES))
  result_gsea_nes_lower = arrange(result_gsea, NES)
  
  for(i in 1:number){
    p_gsea_upper <- gseaplot(result_gsea_nes_upper, geneSetID = i, title = result_gsea_nes_upper$Description[i])
    p_gsea_lower <- gseaplot(result_gsea_nes_lower, geneSetID = i, title = result_gsea_nes_lower$Description[i])
    
    if(!(file.exists("GSEA_plot"))){
      dir.create("GSEA_plot", recursive = T)
    }
    
    ggsave(file=file.path("GSEA_plot", paste0(result_gsea_nes_upper$Description[i], ".png")), plot=p_gsea_upper)
    ggsave(file=file.path("GSEA_plot", paste0(result_gsea_nes_lower$Description[i], ".png")), plot=p_gsea_lower)
    
  }

}


