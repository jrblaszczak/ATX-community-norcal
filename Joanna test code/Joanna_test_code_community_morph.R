#Examining SFE community data

## Load packages
lapply(c("plyr","dplyr","ggplot2","cowplot","lubridate",
         "tidyverse","data.table"), require, character.only=T)

########################################
## Compile community data
########################################
setwd("../data/morphological/raw")

df_c <- ldply(list.files(pattern = "csv"), function(filename) {
  d <- read.csv(filename)
  d$file <- filename
  return(d)
})

#Change date
df_c$Date <- as.POSIXct(as.character(df_c$field_date), format = "%m/%d/%Y")

#################################
## Explore Data Structure
#################################
levels(as.factor(df_c$site)) #RUS, SAL, SFE-M, SFE-SH
levels(as.factor(df_c$reach)) #1S, 2, 3, 4 - this differs from how we've noted it in our sampling (is it the opposite?)
levels(as.factor(df_c$sample_type)) # NT, TAC, TM
levels(as.factor(df_c$method)) # live, preserved

##################################################################
## Exploration of only SFE-M, TM, preserved
##################################################################
## Subset the larger dataframe
SFE_TMp <- df_c %>%
  filter(site == "SFE-M", sample_type == "TM", method == "preserved")
colnames(SFE_TMp)

## Rearrange and subset the columns
SFE_TMp <- SFE_TMp %>%
  select(Date, site, reach, slide_rep:phormidium_unknown, pediastrum:leptoplyngbya)

## Create a long format df for plotting
sapply(SFE_TMp, class)
## convert columns to same class
SFE_TMp[cols.num] <- sapply(SFE_TMp[cols.num],as.numeric) ###########FIX NUMERIC VERSUS INTEGER

long_SFE_TMp <- pivot_longer(data = SFE_TMp, cols = non_algal:leptoplyngbya, 
               names_to = "Identity", 
               values_to = "Pct")











