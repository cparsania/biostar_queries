library(tidyverse)


## get input_A in R
input_A <- tibble::tribble(
        ~col_1,    ~col_2,      ~col_3, ~col_4,                                                                                                                            ~col_5,            ~col_6,
        "17",  50094737,  50094898,      1,                                                                                                                 "ENST00000007708", "ENSG00000005882",
        "17",  50096132,  50096286,      2,                                                                                                                 "ENST00000007708", "ENSG00000005882",
        "17",  50097423,  50097564,      3,                                                                                 "ENST00000007708,ENST00000503176,ENST00000614357", "ENSG00000005882",
        "17",  50105371,  50105442,      3,                                                                                 "ENST00000007708,ENST00000503176,ENST00000614357", "ENSG00000005882",
        "17",  50109957,  50111058,      1,                                                                                                                 "ENST00000007708", "ENSG00000005882",
        "17",  50109957,  50111368,      2,                                                                                                                 "ENST00000614357", "ENSG00000005882",
        "17",  50109957,  50112152,      1,                                                                                                                 "ENST00000503176", "ENSG00000005882",
         "8",  22987417,  22987563,      2,                                                                                                                 "ENST00000519685", "ENSG00000008853",
         "8",  22999579,  23000105,      1,                                                                                                                 "ENST00000251822", "ENSG00000008853",
         "8",  23004425,  23004626,      2,                                                                                                 "ENST00000251822,ENST00000519685", "ENSG00000008853",
         "8",  23005372,  23005475,      2,                                                                                                 "ENST00000251822,ENST00000519685", "ENSG00000008853",
         "8",  23006728,  23007746,      2,                                                                                                 "ENST00000251822,ENST00000519685", "ENSG00000008853",
         "8",  23015638,  23015743,      2,                                                                                                 "ENST00000251822,ENST00000519685", "ENSG00000008853",
         "8",  23017252,  23020199,      1,                                                                                                                 "ENST00000251822", "ENSG00000008853",
         "X", 119539386, 119539789,      1,                                                                                                                 "ENST00000644802", "ENSG00000018610",
         "X", 119541328, 119541420,      2,                                                                                                 "ENST00000320339,ENST00000644802", "ENSG00000018610",
         "X", 119544353, 119544491,      2,                                                                                                 "ENST00000320339,ENST00000644802", "ENSG00000018610",
         "X", 119560268, 119560385,      2,                                                                                                 "ENST00000320339,ENST00000644802", "ENSG00000018610",
         "X", 119565232, 119565401,      1,                                                                                                                 "ENST00000644802", "ENSG00000018610",
        "10",  14518560,  14521306,      1,                                                                                                                 "ENST00000181796", "ENSG00000065809",
        "10",  14521158,  14521306,      1,                                                                                                                 "ENST00000479731", "ENSG00000065809",
        "10",  14521869,  14522019,      8, "ENST00000181796,ENST00000378458,ENST00000378467,ENST00000378470,ENST00000468747,ENST00000478076,ENST00000479731,ENST00000622567", "ENSG00000065809",
        "10",  14530332,  14530515,      8, "ENST00000181796,ENST00000378458,ENST00000378467,ENST00000378470,ENST00000468747,ENST00000478076,ENST00000479731,ENST00000622567", "ENSG00000065809",
        "10",  14553322,  14553387,      2,                                                                                                 "ENST00000378458,ENST00000378467", "ENSG00000065809",
        "10",  14571763,  14572189,      2,                                                                                                 "ENST00000378458,ENST00000622567", "ENSG00000065809",
        "10",  14572229,  14572314,      1,                                                                                                                 "ENST00000479731", "ENSG00000065809",
        "10",  14667634,  14667691,      1,                                                                                                                 "ENST00000181796", "ENSG00000065809",
        "10",  14774253,  14774897,      1,                                                                                                                 "ENST00000181796", "ENSG00000065809"
        )%>% 
        rename_all(~(paste(. , "A"  , sep = "_")))

input_A 


## get input_B in R 
input_B  <- tibble::tribble(
                   ~col_1,    ~col_2, ~col_3, ~col_4,
        "ENSG00000005882",    "PDK2",      1,      3,
        "ENSG00000008853", "RHOBTB2",      1,      2,
        "ENSG00000018610", "CXorf56",     -1,      2,
        "ENSG00000065809", "FAM107B",     -1,      8
        ) %>% 
        rename_all(~(paste(. , "B"  , sep = "_")))

input_B

##  if there is a 1 value in the third column of B table
out_1  <- input_A %>% left_join(input_B ,  by = c( "col_6_A" = "col_1_B")) %>% 
        filter(col_3_B == 1) %>% ## get rows with value 1 in  third column of B table
        filter(col_4_A == col_4_B) ##   select those rows (from A table) which have the same value in the fourth column of A and B tables


out_1 

##  if there is a -1 value in the third column of B table
out_2  <- input_A %>% left_join(input_B ,  by = c( "col_6_A" = "col_1_B")) %>% 
        filter(col_3_B == -1) %>% ## get rows with value -1 in  third column of B table
        filter(col_4_A == col_4_B) ##    select those rows (from A table) which have the same value in the fourth column of A and B tables


out_2 




