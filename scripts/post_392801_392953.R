library(tidyverse)

## cartoon expression data which has duplicated values in column 1 
set.seed(32323)
expr_data <- tibble(gene_id = sample(LETTERS[1:5] , 10 , replace = T) , expr =  rnorm(10 ,mean = 10) ) %>% arrange(gene_id)

expr_data

## if duplicate in column 1 get the observation which has highest in column 2 

expr_data %>% 
        group_by(gene_id) %>%  ## group by id column 
        dplyr::arrange(desc(expr)) %>% ## arrange each group high to low
        slice(1) ## get first row from each group

