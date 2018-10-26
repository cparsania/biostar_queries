
#post : https://www.biostars.org/p/344161/#344260

library(tidyverse)
data <- tibble(plant = c("tomato","tomato","tomato","solanus" ,"solanus","solanus") , tissue = c("leaf" ,"root","shoot","leaf","root","shoot") , count = c(1,4,5,3,2,4))
data %>% spread(key = tissue ,  value = count)
