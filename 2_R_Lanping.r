
install.packages("ggforce")
library(ggforce)
library(ggplot2)
library(tidyverse)
library(stringr)

# Vi gör först en funktion för att approximera PI
set.seed(123)
pi <- function(nr_of_iterations){
  x <- runif(nr_of_iterations,0,1)  #uniform fördelning av x-koordinat mellan 0 och 1
  y <- runif(nr_of_iterations,0,1)
  r <- sqrt(x^2+y^2)
  points_within_circle <- length(which(r<=1)) #Variabler för att räkna antal punkter innanför/utanför 1
  point_outside_circle <- length(which(r>1))
  return(points_within_circle*4/nr_of_iterations)
}

pi(10)
pi(100)
pi(1000)
pi(10000)

#Visuell representation av de samplade punkterna

nr_of_iterations <- 1000
x <- runif(nr_of_iterations,0,1)
y <- runif(nr_of_iterations,0,1)
region <- sqrt(x^2+y^2)
df <- data.frame(x,y,region)
df

#för att inkludera circle arcs så använder vi oss av geom_arc, med tre st olika värden för radie
ggplot()+
  geom_point(aes(x,y,color=region,size=0.2))+
  labs(x="X value",y="Y value")+
  geom_arc(aes(x0=0,y0=0,r=0.4, start=0,end=1.57),color="yellow",size=2)+
  geom_arc(aes(x0=0,y0=0,r=0.8, start=0,end=1.57),color="red",size=2)+
  geom_arc(aes(x0=0,y0=0,r=1.0, start=0,end=1.57),color="blue",size=2)

