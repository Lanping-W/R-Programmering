
library(tidyverse)
library(stringr)

#Ladda in csv-fil, gör om till dataframe
music <- read.csv("music.csv", header = TRUE)
View(music)

df_music <- as_tibble(music)
View(df_music)


#Gör så att "ranks" blir första kolumnen
music_relocate <- df_music %>% relocate(ranks)
View(music_relocate)


#Slå ihop kolumner och ta bort NA-värden
genre_ranking<- unite(music_relocate, genre_rankings, 
                       "post_metal_rank", "black_metal_rank","death_metal_rank",
                       remove=FALSE, na.rm = T)
View(genre_ranking)
genre_ranking[,4]

#Dela upp kolumnen length till minutes och seconds.
genre_ranking <- separate(genre_ranking, length, into= c("minutes","seconds") )
View(genre_ranking)

#Gruppera sedan på artist och visa högst genomsnittsrank
music_group <- genre_ranking %>% group_by(artist) %>%  summarize(mean =mean(ranks))%>% arrange(desc(mean))
View(music_group)

#Döp om genre_rankings till genres. Byt sen namn p? varje kolumn fr?n x_y_rank till x y 
#(t.ex. s? att black_metal_rank blir till black metal.
rename(genre_ranking, genres=genre_rankings)
names(genre_ranking)[4:6] <- c ("post metal","balck metal","death metal")
music_group

#Vi skapar en funktion som tar ut differensen av en artists ranking, baserat på artistnamn

diff <- function(artistname) {
  rankdiff <- genre_ranking %>%
    filter(artist == artistname) %>% 
     summarize(diff = max(ranks, na.rm=TRUE)-min(ranks, na.rm=TRUE) )
               
  return (rankdiff)
}

diff("Alcest")


#artist, mean och diff i en artistgruppering
genre_ranking %>% group_by(artist) %>% summarize(mean(ranks),diff("Mgla"))


