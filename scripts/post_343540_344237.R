

## biostar query https://www.biostars.org/p/343540/#344237

data <- tibble(x  = c("a;b;c;","a2;b2;c2;","a3;b3;c3;") , y = c("x;y;z;","x2;y2;z2;","x3;y3;z3;"))


out <- data %>% mutate(pp = map(seq_along(x) , function(.) { 
        x_split <- unlist(strsplit(x[.] , ";"))
        y_split <- unlist(strsplit(y[.] , ";"))
        paste0(x_split , y_split , collapse  = "</b></br><b>")
        } )) %>% tidyr::unnest()


