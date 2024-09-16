# Data: Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., Diez-Medrano J., M. Lagos, P. Norris, E. Ponarin & B. Puranen (eds.). 2022. World Values Survey: Round Seven – Country-Pooled Datafile Version 6.0. Madrid, Spain & Vienna, Austria: JD Systems Institute & WVSA Secretariat. doi:10.14281/18241.24

# Load relevant libraries
library(tidyverse)


# --- Step 1: Load data

#load the rds file
wvs7 <- readRDS("wvs7.RDS") #using this over the load(wvs.RData) because it's faster and I can rename the object


# --- Scales
# Getting each scale's items in a separate object

variables <- names(wvs7) #to get index of variables

# Social Values, Norms, Stereotypes (Q1-Q45)
which(grepl("Q1P", variables)) # get the index of the first variable in the scale
which(grepl("Q45P", variables)) # get the index of the last variable in the scale 
scale_socval_norms_stereo <- cbind(wvs7[ , 6], wvs7[ , 41:88])
scale_socval_norms_stereo <- scale_socval_norms_stereo[ , !grepl("_3", colnames(scale_socval_norms_stereo))]

# Happiness and Well-being (Q46-Q56)
which(grepl("Q46", variables)) 
which(grepl("Q56", variables))
scale_happiness_wellbeing <- cbind(wvs7[ , 6], wvs7[ , 89:99])
scale_happiness_wellbeing <- scale_happiness_wellbeing[ , !grepl("_3", colnames(scale_happiness_wellbeing))]

# Social Capital, Trust and Organizational Membership (Q57-Q105)
which(grepl("Q57", variables))
which(grepl("Q105", variables))
scale_social_capital <- cbind(wvs7[ , 6], wvs7[ , 100:148])
scale_social_capital <- scale_social_capital[ , !grepl("_3", colnames(scale_social_capital))]

# Economic Values (Q106-Q111)
which(grepl("Q106", variables))
which(grepl("Q111", variables))
scale_economic_values <- cbind(wvs7[ , 6], wvs7[ , 149:154])
scale_economic_values <- scale_economic_values[ , !grepl("_3", colnames(scale_economic_values))]

# --- Step 2: Clean up the data

#isolate relevant variables
wvs_relevant <- wvs7 %>% select(
  B_COUNTRY,
  
)

