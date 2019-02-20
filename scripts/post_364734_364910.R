library(tidyverse)
df <- structure(list(AGI = c("ATCG01240", "ATCG01310", "ATMG00070"), aox2_0h__1 = c(15.79105291, 14.82652303, 14.70630068), aox2_0h__2 = c(16.06494674, 14.50610036, 14.52189807), aox2_0h__3 = c(14.64596287, 14.73266459, 13.07143141), aox2_0h__4 = c(15.71713641, 15.15430026, 16.32190068 ), aox2_12h__1 = c(14.99030606, 15.08046949, 15.8317372), aox2_12h__2 = c(15.15569857, 14.98996474, 14.64862254), aox2_12h__3 = c(15.12144791, 14.90111092, 14.59618842), aox2_12h__4 = c(14.25648197, 15.09832061, 14.64442686), aox2_24h__1 = c(15.23997241, 14.80968391, 14.22573239 ), aox2_24h__2 = c(15.57551513, 14.94861669, 15.18808897), aox2_24h__3 = c(15.04928714, 14.83758685, 13.06948037), aox2_24h__4 = c(14.79035385, 14.93873234, 14.70402827), aox5_0h__1 = c(15.8245918, 14.9351844, 14.67678306), aox5_0h__2 = c(15.75108628, 14.85867002, 14.45704948 ), aox5_0h__3 = c(14.36545859, 14.79296855, 14.82177912), aox5_0h__4 = c(14.80626019, 13.43330964, 16.33482718), aox5_12h__1 = c(14.66327372, 15.22571466, 16.17761867), aox5_12h__2 = c(14.58089039, 14.98545497, 14.4331578), aox5_12h__3 = c(14.58091828, 14.86139511, 15.83898617 ), aox5_12h__4 = c(14.48097297, 15.1420725, 13.39369381), aox5_24h__1 = c(15.41855602, 14.9890092, 13.92629626), aox5_24h__2 = c(15.78386057, 15.19372889, 14.63254456), aox5_24h__3 = c(15.55321382, 14.82013321, 15.74324956), aox5_24h__4 = c(14.53085803, 15.12196994, 14.81028556 ), WT_0h__1 = c(14.0535031, 12.45484834, 14.89102226), WT_0h__2 = c(13.64720361, 15.07144643, 14.99836235), WT_0h__3 = c(14.28295759, 13.75283646, 14.98220861), WT_0h__4 = c(14.79637443, 15.1108037, 15.21711524 ), WT_12h__1 = c(15.05711898, 13.33689777, 14.81064042), WT_12h__2 = c(14.83846779, 13.62497318, 14.76356308), WT_12h__3 = c(14.77215863, 14.72814995, 13.0835214), WT_12h__4 = c(14.70685445, 14.98527337, 16.12727292), WT_24h__1 = c(15.43813077, 14.56918572, 14.92146565 ), WT_24h__2 = c(16.05986898, 14.70583866, 15.64566505), WT_24h__3 = c(14.87721853, 13.22461859, 16.34119942), WT_24h__4 = c(14.92822133, 14.74382383, 12.79146694)), class = "data.frame", row.names = c(NA, -3L))


ss <- df %>% 
        as_tibble() %>% 
        gather(key = "cond" , value = "value" , -AGI) %>% 
        separate(cond , into = c("Genotype", "Time", "Replicate") , sep = "_+") %>% 
        group_by(Genotype, Time,Replicate) 

## average out replicates 
ss_m <- ss %>% group_by(AGI, Genotype , Time) %>% summarise(replicates_mean = mean(value) , stddev = sd(value)) 

## comparing timepoint 
bplot <- ss_m %>% ggplot() + geom_boxplot(aes(x = Time, y = replicates_mean , fill = Genotype)) +  theme_bw() + theme(text = element_text(size = 20))
ggsave(filename = "boxplot.png" ,plot = bplot)


##<a href="https://ibb.co/QXYz5JZ"><img src="https://i.ibb.co/QXYz5JZ/boxplot.png" alt="boxplot" border="0"></a>

## comparing genotype 
bplot2 <- ss_m %>% ggplot() + geom_boxplot(aes(x = Genotype, y = replicates_mean , fill = Time)) +  theme_bw() + theme(text = element_text(size = 20))
ggsave(filename = "boxplot2.png" ,plot = bplot2)

## <a href="https://ibb.co/KLPBspY"><img src="https://i.ibb.co/KLPBspY/boxplot2.png" alt="boxplot2" border="0"></a>


ss_mm <- ss %>% group_by(AGI, Genotype , Time) %>% 
        summarise(replicates_mean = mean(value) , stddev = sd(value)) %>% ## add stddev and mean 
        unite(Genotype, Time , col = "Genotype_Time" , sep = "_") %>% ## unite genotype and time in a single column
        gather(key = summary_type , value = value , replicates_mean , stddev) %>% ## create summary_type variable 
        unite(Genotype_Time, summary_type , col = "Genotype_Time_summary_type",sep = "_") %>% ##create Genotype_Time_summary_type variable
        spread(Genotype_Time_summary_type , value) ## wide format 

glimpse(ss_mm)

