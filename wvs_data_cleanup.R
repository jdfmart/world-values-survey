# --- Welcome to the code for the World Values Survey data cleanup. ---
# 
# This is unashamedly a beginner's work. I have left misteps and comments to myself in the code. 
# I encourage everyone to point out where and how it could be better - the point of this project is to improve my coding skills and knowledge.
#
# 
# Data: Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., Diez-Medrano J., M. Lagos, P. Norris, E. Ponarin & B. Puranen (eds.). 2022. World Values Survey: Round Seven – Country-Pooled Datafile Version 6.0. Madrid, Spain & Vienna, Austria: JD Systems Institute & WVSA Secretariat. doi:10.14281/18241.24
#


# Load relevant libraries
library(tidyverse)
library(haven)


# --- Step 1: Load data

#load the rds file
wvs7 <- readRDS("wvs7.RDS") #using this over the load(wvs.RData) because it's faster and I can rename the object


# --- Step 2: Clean data

# getting averages for each column by country 
wvs7_item_avg <- wvs7 %>%
  group_by(B_COUNTRY) %>%
  summarise(across(everything(), mean, na.rm = TRUE))

# how many countries
length(unique(as_factor(wvs7$B_COUNTRY))) # checks out: 66 countries.


# Scales
# Getting each scale's items in a separate object (which I see now was not necessary, but I'll keep it for now)

variables <- names(wvs7) #to get index of variables

# Social Values, Norms, Stereotypes (Q1-Q45)
which(grepl("Q1P", variables)) # get the index of the first variable in the scale
which(grepl("Q45P", variables)) # get the index of the last variable in the scale 
scale_socval_norms_stereo <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 41:88])

# Happiness and Well-being (Q46-Q56)
which(grepl("Q46", variables)) 
which(grepl("Q56", variables))
scale_happiness_wellbeing <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 89:99])

# Social Capital, Trust and Organizational Membership (Q57-Q105)
which(grepl("Q57", variables))
which(grepl("Q105", variables))
scale_social_capital <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 100:177])

# Economic Values (Q106-Q111)
which(grepl("Q106", variables))
which(grepl("Q111", variables))
scale_economic_values <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 178:183])

# Perceptions of Corruption (Q112-Q120)
which(grepl("Q112", variables))
which(grepl("Q120", variables))
scale_corruption <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 184:192])

# Perceptions of Migration (Q121-Q130)
which(grepl("Q121", variables))
which(grepl("Q130", variables))
scale_migration <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 193:202])

# Perceptions of Security (Q131-Q151)
which(grepl("Q131", variables))
which(grepl("Q151", variables))
scale_security <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 203:223])

# Index of Postmaterialsm (Q152-Q157)
which(grepl("Q152", variables))
which(grepl("Q157", variables))
scale_postmaterialism <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 224:229])

# Perceptions about Science and Technology (Q158-Q163)
which(grepl("Q158", variables))
which(grepl("Q163", variables))
scale_science_technology <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 230:235])

# Religious Values (Q164-Q175)
which(grepl("Q164", variables))
which(grepl("Q175", variables))
scale_religious_values <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , 236:248])

# decided that it could be done in a single line from here on
# Ethical Values (Q176-Q198)
scale_ethical_values <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , which(grepl("Q176", variables)):which(grepl("Q198", variables))])

# Political Interest and Political Participation (Q199-Q234)
scale_political_interest <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , which(grepl("Q199", variables)):which(grepl("Q234P", variables))])

# Political Culture and Political Regimes (Q235-Q259)
scale_political_culture <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , which(grepl("Q235", variables)):which(grepl("Q259", variables))])

# Demographic and Socioeconomic Variables (Q260-Q290)
demographics <- cbind(wvs7_item_avg[ , 6], wvs7_item_avg[ , which(grepl("Q260", variables)):which(grepl("Q290", variables))])


# --- Create the database with scale final scores
# wvs7_item_avg can be used for visualizing specific items.

# get names of every object in the environment that starts with "score_"
scales <- ls(pattern = "scale_")
length(scales) # 13 scales, correct according to the WVS project.

# lapply to create the final scores for each scale
wvs7_scales_scores <- as.data.frame(lapply(scales, function(x) {
  scale <- get(x)
  scale_mean <- rowMeans(scale, na.rm = TRUE)
  return(scale_mean)
  }))

# putting the names of the scales back
names(wvs7_scales_scores) <- scales

# adding the country column
wvs7_scales_scores <- cbind(country = as_factor(wvs7_item_avg$B_COUNTRY), scales_scores)

# add demographics
# gender: count of 1 and 2



  
#re-thing this

demographics_short <- cbind(
  wvs7 %>% 
    filter(Q260 %in% c(1, 2)) %>%
    group_by(B_COUNTRY, Q260) %>%
    count() %>%
    pivot_wider(names_from = Q260, values_from = n) %>%
    mutate(female_prop = `2` / (`1` + `2`)),
  wvs7 %>% 
    filter(Q263 %in% c(1, 2)) %>%
    group_by(B_COUNTRY, Q263) %>%
    count() %>%
    pivot_wider(names_from = Q263, values_from = n) %>%
    mutate(immigrant_prop = `2` / (`1` + `2`)))
  
  
  demographics %>% select(age = Q261, age_range = X003R))







