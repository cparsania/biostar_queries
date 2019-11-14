
fasta_files <- list.files(path = "." ,pattern = "*.fasta" ,full.names = T)
n_files = length(seq_list)

seq_list <- fasta_files %>% 
        tibble::enframe() %>% 
        dplyr::mutate(seqs = purrr::map(value, ~ Biostrings::readBStringSet(..1))) %>%
        dplyr::pull(seqs)


for(i in c(1:n_files)){

        seq_list %>% 
                purrr::map( ~ purrr::pluck(..1,function(x)x[i])) %>%  
                Biostrings::BStringSetList() %>% 
                unlist() %>% Biostrings::writeXStringSet(paste("group" ,i,".fasta",sep = ""))
        
}


