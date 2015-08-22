library(dplyr)
library(tidyr)
library(shiny)
setwd("./Data")

## OBTAINING LIST FOR SELECT BOX
## Reading data from translation file
CH1 <- read.csv("SBItrans.csv", header = TRUE, sep = ";")
## Renaming column headers
colnames(CH1) <- c("EA", "Branche")
## Setting column branche to character
CH1$Branche <- as.character(CH1$Branche)
## Selecting one column for select box
CH1code <- select(CH1, Branche)

shinyUI(pageWithSidebar(
        headerPanel("SBI Estimater"),
        sidebarPanel(
                selectInput("Code", label = h3("Select branche"), 
                CH1code,
                selected = 1),
                hr(),
                sliderInput('Population', 'Choose population of town or region',value = 200000, min = 0, max = 650000, step = 1000, ticks = FALSE)
        ),
        mainPanel(
                   h4('For this branche:'),
                   verbatimTextOutput("inputCode"),
                   h4('Of which there is this number of companies in total in the Netherlands:'),
                   verbatimTextOutput("number"),
                   h4('The estimated number of companies for the chosen population is:'),
                   verbatimTextOutput("estimate"),
                   h6('This application estimates the number of companies in a town or region of the Netherlands for specific branches. It uses national data and calculates an estimate by multiplying the national number of companies with the fraction of the population of the Netherlands that lives in a town or region.'),
                   h6('It uses the codes for branches based on the "Standaard Bedrijfs Indeling" (english: "Standard Industrial Classification"). These codes are based on the "International Standard Industrial Classification", which is maintained by the UN. The SBI-codes are maintained by the dutch Central Bureau of Statistics (CBS)'),
                   h6('The branche code is chosen from the select box "Select Branche" '),
                   h6('The slider is used to set the number of inhabitants of a certain town or region. The slider is set to a maximum of 650.000, which covers the number of inhabitants of most regions in the Netherlands (Except the 5 largest of the 40 regions). The Netherlands is divided in 40 socalled COROP-regions, for economic statistics.'),
                   h6('The data used are obtained by means of the statline application from the CBS, (www.statline.cbs.nl). The statline application generates tables depending on selections you make. There is an english button, by which you can acces a selection of the available data. The data are open data, so check it out!')
                                  )
))
