## biostar query :  https://www.biostars.org/p/344043/#344234

library(tidyverse)
data <- read_csv("./data/breast-panel1.csv") %>% dplyr::rename( geneName = X1)

## I have change column names of your data see below.
data


## data cleaning and prepare it for heatmap ready format  
## if names are duplicated change it 
data2 <- data %>% group_by(geneName) %>% 
        mutate(n = row_number()) %>%
        mutate(geneName2 =  map(n  , function(.){ifelse( .  > 1 , paste(geneName , . ,sep = "_") , geneName)})) %>% unnest() %>% 
        ungroup() 
data2  %>% group_by(geneName2) 

data3 <- data2 %>% 
        mutate(geneName = geneName2) %>% 
        select(-geneName2 , -n ) %>% # remove un wanted columns 
        gather(key = "sampleName" , value = "z_score" , -geneName) %>% 
        separate(col = sampleName ,into = c("strain" , "cond") ,sep = "_") ## separate strain info(WT or MUT) from conditions 


## Now, data is ready. Proceed for plots 

## each sample density 

gp <- data3 %>% ggplot() + geom_density(aes(x = z_score , fill = cond), alpha = 0.5)  + theme_bw()

ggsave(gp ,filename = "biostar_query_density.png")

## preapare heatmap data. 
library(ComplexHeatmap)
for_hm <- data3 %>% 
        select(geneName, cond, z_score) %>% 
        spread(key = cond, value = z_score) %>%  
        as.data.frame(data3) %>%  
        column_to_rownames("geneName")

## heatmap column annotations 
hm_col_anno <- data3 %>% 
        select(strain , cond) %>% 
        unique() %>% 
        select(1) %>% 
        as.data.frame()
ha = HeatmapAnnotation(df = hm_col_anno)


## draw heatmap
set.seed(123)
hm <- Heatmap(for_hm , cluster_columns = F , 
              show_row_dend = T , 
              top_annotation = ha , 
              name = "Z_score" ,
              row_names_gp = gpar(fontsize = 7) , 
              column_names_gp  = gpar(fontsize = 35), 
              top_annotation_height = unit(30,"mm") , km = 10, 
              row_title_gp = gpar(fontsize = 40))

## save in the file 
png(file  = "biostar_query.png", height = 7000,width = 2000 ,res = 120)
draw(hm)
dev.off()

1



