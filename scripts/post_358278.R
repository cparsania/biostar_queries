dd <- tibble::tribble(
        ~GeneSymbol, ~EntrezID, ~TCGA_2J_AAB1_01A_11R_A41B_07, ~TCGA_2J_AAB4_01A_12R_A41B_07, ~TCGA_2J_AAB6_01A_11R_A41B_07, ~TCGA_2J_AAB8_01A_12R_A41B_07, ~TCGA_2J_AAB9_01A_11R_A41B_07, ~TCGA_2J_AABA_01A_21R_A41B_07,
             "A1BG",         1,                       81.9122,                       56.7551,                       82.5497,                       56.9307,                      105.7878,                       99.3455,
             "A1CF",     29974,                       25.3659,                       53.4512,                        8.1871,                       33.8425,                       21.4362,                       18.7882,
           "RBFOX1",     54715,                        0.4878,                        2.1044,                             0,                             0,                        1.0718,                             0,
            "GGACT",     87769,                      180.4976,                      111.0774,                      163.1228,                      185.8143,                      166.7095,                       99.2767,
            "A2ML1",    144568,                       85.8537,                             0,                     1815.7895,                       16.9213,                       642.015,                      873.6496,
              "A2M",         2,                    19703.8049,                    15837.8241,                     8517.4444,                     14413.913,                    24311.7792,                    10302.0072,
           "A4GALT",     53947,                     1541.4634,                     1154.8822,                     1121.0526,                      392.9495,                     1125.4019,                      633.1611
        )

library(tidyverse)
dd_c <- dd %>% gather( key = sample ,value = value,  -GeneSymbol , -EntrezID ) 

bb1 <- dd_c  %>% ggplot(aes(x = sample , y = value)) + geom_boxplot() + coord_flip() + theme_bw(base_size = 15) + ggtitle("Raw value") + xlab("Raw value")

bb2 <- dd_c  %>% ggplot(aes(x = sample , y = value)) + geom_boxplot() + coord_flip() + theme_bw(base_size = 15) + scale_y_log10() +  ggtitle("Log10 scale") + xlab("Log10 scale")


1000 * 10^-9
