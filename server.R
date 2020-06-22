library(shiny)
library(vcd)
library(MASS)
library(RColorBrewer)
library(datasets)
library(corrgram)
library(visdat)
library(forecast)
library(tidytext)
library(tidyverse)
library(janeaustenr)
library(stringr)
library(wordcloud)
library(reshape2)
library(pls)
library(dplyr)
library(shinyjs)
library(ggplot2)
library(ggmosaic)
library(scales)
library(plotly)
library(psych)

Ass1 <- read.csv("Ass1Data.csv", header = TRUE)
sensordata <-Ass1%>% select(15:30)
factordata <-Ass1%>% select(1:14)
choicesB<-factordata%>% select(1:10)
choicesA <- colnames(as.data.frame(choicesB))
choicesA <- choicesA[-length(choicesA)]

#x = scale(sensordata,center = input$center, scale = input$scale)
#b = scale(factordata,center = inpurt$center,scale = inpurt$scale)

shinyServer(function(input,output,session){
# Summary statistics 
output$datat <-renderPrint({
  str(Ass1)
})  
output$summ1 <- renderPrint({
  summary(sensordata)
})  
output$summ <- renderPrint({
  summary(factordata)
})  
output$desc1 <- renderPrint({
  describe(factordata)
})  
output$desc2 <- renderPrint({
  summary(sensordata)
})  

#-----------------------------------Plots-----------------------------#
#Boxplots
output$Boxplot1 <- renderPlot({
  boxplot(sensor1~Price*Speed,data=Ass1,notch =TRUE,col =(c("gold","darkgreen")),xlab ="price & Speed",breaks =input$range)
  })  
output$Boxplot2 <- renderPlot({
  with(Ass1,boxplot(sensor14~Priority,breaks=input$range))
})  
output$Boxplot3 <- renderPlot({
  ggplot(Ass1,aes(x=sensor9 , y = Scarcity))+
    geom_boxplot(fill="skyblue",aes(group =cut_width(sensor9,0.5)),breaks=input$range)
})
#Histogram
output$Hista <- renderPlot({
  with(Ass1,hist(Ass1$Y,breaks = input$bins)) 
})  
output$Hista0 <- renderPlot({
  x <- Ass1$Y
  h<-hist(x, breaks=input$bins, col="green", xlab="Y", 
          main="Histogram with Normal Curve") 
  xfit<-seq(min(x),max(x),length=40) 
  yfit<-dnorm(xfit,mean=mean(x),sd=sd(x)) 
  yfit <- yfit*diff(h$mids[1:2])*length(x) 
  lines(xfit, yfit, col="blue", lwd=2) 
})
output$Hista1<- renderPlot({
    d <- density(Ass1$Y) # returns the density data 
  plot(d) # plots the results 
})
output$Missing1 <- renderPlot({
  vis_miss(sensordata, sort_miss=FALSE)
})
output$Missing2 <- renderPlot({
  vis_miss(factordata, sort_miss=FALSE)
})
output$Rising <- renderPlot({
  cols <- c("Y", "sensor1") # choose the numeric columns
  d <- Ass1[,cols]  # filter out non-numeric columns
  for (col in 1:ncol(d)) {
    d[,col] <- d[order(d[,col]),col] #sort each column in ascending order
  }
  d <- scale(x = d, center = TRUE, scale = TRUE)  # scale so they can be graphed with a y shared axis
  mypalette <- rainbow(ncol(d))
  matplot(y = d, type = "l", xlab = "Observations", ylab="Values", lty = 1, lwd=1, col = mypalette, main="Rising Order chart")
  legend(legend = colnames(d), x = "topleft", y = "top", lty = 1, lwd = 1, col = mypalette, ncol = round(ncol(d)^0.3))
})
output$Homogenity <- renderPlot({
  cols <- c("Y","sensor1","sensor2","sensor7","sensor12") # choose the numeric columns
  numData <- scale(Ass1[,cols], center = TRUE, scale = TRUE) # Normalise so they can share a common y axis
  matplot(numData, type = "l", col = alpha(rainbow(ncol(numData)), 0.4), main ="Homogenity" )
}) 
#mosaic-plot
#ggmosaic
output$Mosaic <- renderPlot({
 mosaicplot(~Price + Speed  ,data = factordata, color =2:3, las = 1)
})
#-----------------------------------------raw-data--------------------------------------#
output$table<- renderDataTable(Ass1)
})
