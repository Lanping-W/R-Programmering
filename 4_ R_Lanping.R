
install.packages("psych")
library(tidyverse)
library(ggplot2)
library(stringr)
library(psych)

#ladda in data-set LungCap
df_lung <- read.csv("LungCap.csv", stringsAsFactors = T)
df_lung

#Gör en boxplot för att se om det finns outliers
boxplot(df_lung)

#på rad 89 så har vi en outlier som vi väljer att inte ha med i modellen pga orealistiska värden
df_lung <- df_lung[-89,]
head(df_lung)

#generera slumpmässig seed
set.seed(123) 

#dela upp data i train (för träning) och test (för verifiering)
#denna kod är baserad på Evas demokod från föreläsning 10
index <-  sample(1:nrow(df_lung), 0.7*nrow(df_lung)) 
train_data <-  df_lung[index,] 
test_data <-  df_lung[-index,]

#vi kollar hur det ser ut med alla kolumner som features för att 
#avgöra vilka vi kan plocka bort från resultatet
lin_mod <- lm(LungCap ~ ., data = train_data)
summary(lin_mod)

#av resultatet från ovan ser vi att vi kan plocka bort new_var1,2,4,5,6
#p.g.a Pr(>|t|) ger höga värden för null-hypotes
lin_mod <- lm(LungCap ~ Age + Height + new_var3, data = train_data)
summary(lin_mod)
#vi får r squared 0.858 vilket är godkänt, vi kan även se att r squared inte har ändrats


pred <- predict(lin_mod, test_data)
summary(pred)
