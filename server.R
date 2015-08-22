library(dplyr)
library(tidyr)
library(shiny)

## Reading data and removing first four rows
SL1 <- read.csv("SBI1.csv", header = TRUE, sep = ";", skip = 4)
## removing last row
SL1 <- head(SL1,-1)
## Changing column names
colnames(SL1) <- c("EA", "NR")
SL1$EA <- as.character(SL1$EA)
## Adding column with english translation
SLeng <- read.csv("SBItrans.csv", header = TRUE, sep = ";")
SLeng$EA <- as.character(SLeng$EA)
SL1 <- full_join(SL1,SLeng,by = "EA")

## Function to extract total number of companies in the Netherlands for a chosen branche 
number <- function(code) SL1$NR[which(grepl(code, SL1$Eaeng))]

## Function to estimate number of companies based on chosen population using population of the Netherlands (16829289)
estimate <- function(code, population) round(SL1$NR[which(grepl(code, SL1$Eaeng))] / 16829289 * population)

shinyServer(
        function(input, output) {
                output$inputCode <- renderText({input$Code})
                output$inputPopulation <- renderText({input$Population})   
                output$estimate <- renderText({estimate(input$Code,input$Population)})
                output$number <- renderText({number(input$Code)})
        }
)
