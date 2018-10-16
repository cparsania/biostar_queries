## Biostar post : https://www.biostars.org/p/343055/#343521

library(tidyverse)
 
file_path  = "path_to_tab_delim_file"  ## file must have colnames, where first column is geneName and all other columns are relative expression in given sample 
data <- read_delim(file_path ,delim = "\t") %>% rename_if(is.numeric ,  ~(paste("hr", seq(0,8,by = 2),sep = "_")))

## prepare data for cluster 
for_clust  <- data %>% 
        select(-1) ## remove first column which is gene id 

### kmeans
max_itr <-  50
n_clust  <-  6 
set.seed(123)
kmeans_out  <- kmeans(for_clust,n_clust,iter.max = max_itr)

## add cluster info to orig matrix 
data_with_cust_info <- data %>% 
        mutate(clust = paste("clust_", kmeans_out$cluster,sep = ""))


## visualise  each cluster 
gp <- data_with_cust_info %>% 
        gather(key = "variable" , value = "value", -c(1,7)) %>%  ### 1 is the index of column 'geneName' and 7 is the index of column 'clust'
        group_by(variable) %>%  
        mutate(row_num =  1:n()) %>% 
        ggplot(aes(x =  variable , y = value , group = row_num)) +   
        geom_point() +  
        geom_line(alpha = 1 , aes(col = as.character(clust))) + 
        theme_bw() +  
        theme(legend.position = "none" , axis.text.x = element_text(angle = 90 , vjust = 0.4)) +
        facet_wrap(~clust)


gp + theme(text = element_text(size = 20))
