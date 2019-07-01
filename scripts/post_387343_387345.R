

library(Biostrings)
library(tidyverse)


## get target seq names 
target_seq_names <- c("M.Bce12308ORF4755P", "M.Bce122ORF1082P", "M.Bce12308ORF4755P", "M.Bce1254ORF9725P")


## get seq names from fasta file 
fasta_seq_names <- Biostrings::readDNAStringSet("input.fasta") %>% 
        names() %>% ## get names 
        gsub(pattern = "\\s.*" ,replacement = "" ,x = .) ##  clean headers. remove stuff after first space

fasta_seq_names

## present in both 
intersect(fasta_seq_names , target_seq_names)
