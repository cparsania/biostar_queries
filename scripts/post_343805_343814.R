
## Biostar post : https://www.biostars.org/p/343805/#343814

library(tidyverse)
t1 <- tibble(X1 = c("a;b","c","d;e"))
t2 <- tibble(Y1 =letters[1:5] , Y2 = c("uuu","vvv","xxx","yyy","zzz") ,Y3 =c("uu","vv","xx","yy","zz"))


t3 <- t1 %>% 
        mutate(mm = map(X1, ~(strsplit(.,split = ";"))[[1]] %>% as_tibble)) %>% 
        mutate(nn  = map(mm , function(.){
                col_binds <- left_join(.,t2, by = c("value" = "Y1")) %>% 
                        unite(col = "comb",sep = "|" , Y2:Y3)
                row_binds <- col_binds %>% 
                        summarise(value  = paste0(value , collapse = ";")  , times = paste0(comb , collapse = "<\br>"))
                return(row_binds)
        })) %>% 
        select(nn) %>%
        unnest() %>% 
        dplyr::rename(X1 = value , Y2 = times) 

