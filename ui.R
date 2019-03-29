library(shiny)
library(MASS)
library(datasets)
library(shinythemes)
library(ggplot2)
library(shinyjs)
library(dplyr)
library(plotly)
library(psych)

Ass1 = read.csv("Ass1Data.csv", header = TRUE)
sensordata <-Ass1%>% select(15:30)
factordata <-Ass1%>% select(1:14)
choicesB<-factordata%>% select(1:4)
choicesA <- colnames(as.data.frame(choicesB))
choicesA <- choicesA[-length(choicesA)]


shinyUI(
  
  (fluidPage
   (theme = shinytheme("spacelab"),
     useShinyjs(),
     
   titlePanel("A1_Data423 - Thiwanka Jayasiri"),
      tabsetPanel( 
        
        type ="tab",
                 tabPanel("Raw_data",
                          
                          tags$div(
                            
                            tags$p(
                            "You may use the search box on specific columns to filter out the factors or num. ") 
                            # tags$p("Second paragraph"), 
                            # tags$p("Third paragraph")
                          ),
                          
                          tags$hr(),
                          fluidRow(
                            column(12,
                                   dataTableOutput('table')
                                   )
                                                      )
                          
                                                    ),
                          
                 tabPanel("Data_Type | Summary_Stat",
                                    tags$h3("Data Types"),
                                    verbatimTextOutput("datat"),
                                    tags$hr(),
                                    tags$h3("Summary Stat of Factor Data"),
                                    verbatimTextOutput("desc1"),
                                    tags$hr(),
                                    tags$h3("Summary Stat of Sensor Data"),
                                    verbatimTextOutput("summ1")
                                    # verbatimTextOutput("desc1"),
                                    # verbatimTextOutput("desc2")
                          
                                                    ),
                 tabPanel("Plot_types",
                          
                   
                          tags$h2("Intro"),
                          
                          tags$div(
                            tags$p(
                              
                              "When performing an exploratory data analysis(EDA) task we normally check on the followings"),
                                tags$li("Documentation ( data dictionary )"), 
                                tags$li("Homogeneity"),
                                tags$li	("Missing data (Missing data plot"),
                                tags$li("Distribution of the data (categorical or numerical- Histograms to check the distribution of the data.")
                              
                               ),
                          
                          
                          
                          tags$hr(),
                          tags$h3("Sample box plots with respect to sensor ~ factors."),
                          
                          tags$div(
                            tags$p("In descriptive statistics, a box plot or boxplot is a method for graphically depicting groups of numerical data through their quartiles. Box plots may also have lines extending vertically from the boxes (whiskers) indicating variability outside the upper and lower quartiles, 
                                   hence the terms box-and-whisker plot and box-and-whisker diagram. Outliers may be plotted as individual points. Box plots are non-parametric: 
                                   they display variation in samples of a statistical population without making any assumptions of the underlying statistical distribution (though Tukey's boxplot assumes symmetry for the whiskers and normality for their length). 
                                   The spacings between the different parts of the box indicate the degree of dispersion (spread) and skewness in the data, and show outliers."),
                                   
                             tags$p(" In addition to the points themselves, they allow one to visually estimate various L-estimators, notably the interquartile range, midhinge, range, mid-range, and trimean.Box plots can be drawn either horizontally or vertically"),
                            
                            tags$a(href="https://en.wikipedia.org/wiki/Box_plot" ,"Wiki-Box plot") 
                            ),
                          
                          tags$div(
                           
                            tags$br()
                            
                          ),
                          
                          
                          sliderInput("range", label = "IQR Multiplier", min = 0, max = 5, step = 0.1, value = 1.5),
                          tags$b("Notched Boxplot-Against 2 Crossed Factors| Price~Speed"),
                          plotOutput("Boxplot1"),
                          
                          tags$b("Sensor14~Priority"),
                          plotOutput("Boxplot2"),
                          tags$b("Sensor9~Scarcity"),
                          plotOutput("Boxplot3"),
                          tags$hr(),
                          tags$h3("Histogram with Y Varies"),
                          
                          sliderInput("bins","Number of breaks",1,100,50),
                          plotOutput("Hista"),
                          
                          
                          plotOutput("Hista0"),
                          
                          
                          tags$h4("Kernel density plot"),
                          plotOutput("Hista1"),
                          tags$b("Histograms can be a poor method for determining the shape of a distribution because it is so strongly affected by the number of bins used."),
                          
                          
                          
                          tags$hr(),
                          tags$h3("Missing data plots"),
                          tags$div(
                            
                            tags$br()
                            
                          ),
                          tags$b("Missing data - Sensor_data"),
                          plotOutput("Missing1"),
                          tags$b("Missing data - Factor_data"),
                          plotOutput("Missing2"),
                          tags$hr(),
                          tags$h3("Rising bar plot"),
                          
                          plotOutput("Rising"),
                          
                          tags$hr(),
                          tags$h3("Homogenity"),
                          plotOutput("Homogenity"),
                          
                          tags$div(
                          tags$p(
                            "In statistics, homogeneity and its opposite, heterogeneity, 
                            arise in describing the properties of a dataset, or several datasets. 
                            They relate to the validity of the often convenient assumption that the statistical properties of any one part of an overall dataset are the same as any other part. 
                            In meta-analysis, which combines the data from several studies, homogeneity measures the differences or similarities between the several studies ") ,
                          tags$a(href="https://en.wikipedia.org/wiki/Homogeneity_(statistics)" ,"Wiki-Homogeneity")
                          ),
                          
                          
                          tags$hr(),
                          tags$h3("Mosaic"),
                          # plotOutput("mosaic"),
                          #selectizeInput("VariablesA", label="Show variables:", choices=choicesB, multiple=TRUE, selected=choicesB),
                          plotOutput("Mosaic"),
                          tags$div(
                          tags$p(
                            "A mosaic plot (also known as a Marimekko diagram) is a graphical 
                            method for visualizing data from two or more qualitative variables.[1] It is the multidimensional extension of spineplots, which graphically display the same information for only one variable.
                            It gives an overview of the data and makes it possible to recognize relationships between different variables."
                            
                            
                          ),
                          tags$a(href="https://en.wikipedia.org/wiki/Mosaic_plot" ,"Wiki-Mosaic")
                          
                          )
                          
                          
                          )#tabpanel 
                          
                          
                          
                          )#tabsetpanel
              
              
    )
    
    
    
    
  )
  
  
  
 

  
)

