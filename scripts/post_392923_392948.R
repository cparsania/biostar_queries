library(tidyverse)

## create source data table having 2 columns : pathway_id and description
source_table <- tibble::tribble(
                       ~pathway_id,                                                    ~description,
             "PTHR11566:SF148", "INTERFERON-INDUCED GTP-BINDING PROTEIN MXA-RELATED",
              "PTHR19353:SF12",                            "FATTY ACID DESATURASE 2",
              "PTHR31490:SF39",                                                   "",
               "PTHR45744:SF9",                                                   "",
             "PTHR16223:SF138",                                                   "",
               "PTHR45618:SF8",                 "MITOCHONDRIAL UNCOUPLING PROTEIN 4"
              )


## create  query table through some random pathway ids 
query_table <- tibble::tibble(pathway_id =  sample(source_table$pathway_id, 10 , replace = T))
query_table

## map desc from source table to query table 
query_table %>% dplyr::left_join(source_table ,)