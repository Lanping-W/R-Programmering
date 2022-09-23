
library(tidyverse)
library(stringr)
#Ladda in csv i en dataframe
df_tele <- read.csv("telemastdata.CSV") 

#Skapa en dataframe för suspects och filtrera på tidpunkter och modell av telefon
df_sus <- df_tele %>% 
  filter(phone_type=="iPhone" & between(time0,407,425)) 

#Visa en tabell med resultaten
View(df_sus)


