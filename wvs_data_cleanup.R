# Data: Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., Diez-Medrano J., M. Lagos, P. Norris, E. Ponarin & B. Puranen (eds.). 2022. World Values Survey: Round Seven – Country-Pooled Datafile Version 6.0. Madrid, Spain & Vienna, Austria: JD Systems Institute & WVSA Secretariat. doi:10.14281/18241.24

# Load relevant libraries
library(tidyverse)
library(haven)


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

# Happiness and Well-being (Q46-Q56)
which(grepl("Q46", variables)) 
which(grepl("Q56", variables))
scale_happiness_wellbeing <- cbind(wvs7[ , 6], wvs7[ , 89:99])

# Social Capital, Trust and Organizational Membership (Q57-Q105)
which(grepl("Q57", variables))
which(grepl("Q105", variables))
scale_social_capital <- cbind(wvs7[ , 6], wvs7[ , 100:177])

# Economic Values (Q106-Q111)
which(grepl("Q106", variables))
which(grepl("Q111", variables))
scale_economic_values <- cbind(wvs7[ , 6], wvs7[ , 178:183])

# Perceptions of Corruption (Q112-Q120)
which(grepl("Q112", variables))
which(grepl("Q120", variables))
scale_corruption <- cbind(wvs7[ , 6], wvs7[ , 184:192])

# Perceptions of Migration (Q121-Q130)
which(grepl("Q121", variables))
which(grepl("Q130", variables))
scale_migration <- cbind(wvs7[ , 6], wvs7[ , 193:202])

# Perceptions of Security (Q131-Q151)
which(grepl("Q131", variables))
which(grepl("Q151", variables))
scale_security <- cbind(wvs7[ , 6], wvs7[ , 203:223])

# Index of Postmaterialsm (Q152-Q157)
which(grepl("Q152", variables))
which(grepl("Q157", variables))
scale_postmaterialism <- cbind(wvs7[ , 6], wvs7[ , 224:229])

# Perceptions about Science and Technology (Q158-Q163)
which(grepl("Q158", variables))
which(grepl("Q163", variables))
scale_science_technology <- cbind(wvs7[ , 6], wvs7[ , 230:235])

# Religious Values (Q164-Q175)
which(grepl("Q164", variables))
which(grepl("Q175", variables))
scale_religious_values <- cbind(wvs7[ , 6], wvs7[ , 236:248])

# Ethical Values (Q176-Q198)
scale_ethical_values <- cbind(wvs7[ , 6], wvs7[ , which(grepl("Q176", variables)):which(grepl("Q198", variables))])

# Political Interest and Political Participation (Q199-Q234)
scale_political_interest <- cbind(wvs7[ , 6], wvs7[ , which(grepl("Q199", variables)):which(grepl("Q234P", variables))])

# Political Culture and Political Regimes (Q235-Q259)
scale_political_culture <- cbind(wvs7[ , 6], wvs7[ , which(grepl("Q235", variables)):which(grepl("Q259", variables))])

# Demographic and Socioeconomic Variables (Q260-Q290)
demographics <- cbind(wvs7[ , 6], wvs7[ , which(grepl("Q260", variables)):which(grepl("Q290", variables))])



# --- Step 2: Clean up the data 

#isolate relevant variables
#data <- wvs7 %>% select(B_COUNTRY, )



