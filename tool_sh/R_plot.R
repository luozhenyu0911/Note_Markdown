

paper_theme <- theme(plot.title = element_text(colour = 'black', size = 8),
                     axis.title.x = element_text(colour = 'black', size = 8), 
                     axis.text.x  = element_text(colour = 'black', size = 8), 
                     axis.title.y = element_text(colour = 'black', size = 8),
                     axis.text.y  = element_text(colour = 'black', size = 8),
                     axis.ticks.length = unit(0.15, "cm"),
                     panel.background = element_blank(), 
                     plot.margin = unit(c(0.25, 0.25, 0.25, 0.25), "cm"),
                     axis.line = element_line(colour = "black"),
                     legend.title = element_text(colour = 'black', size = 8),
                     legend.text = element_text(colour = 'black', size = 8), 
                     strip.text.x = element_text(colour = 'black', size = 8),
                     strip.text.y = element_text(colour = 'black', size = 8))

theme(axis.text.x  = element_text(size = 5, angle = 90, vjust = 0.5, hjust = 1),
        legend.position = "top",
        legend.key.size = unit(3, "mm"),
        legend.margin = margin(0, 0, 0, 0)) + 







