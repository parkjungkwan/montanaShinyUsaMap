# getwd()
# setwd("C:\\Users\\Administrator\\rlang__weekend\\USAMap")
install.packages("maps")
install.packages("mapproj")
library(maps)
library(mapproj)
library(shiny)
source("helpers.R")
counties <- readRDS("counties.rds")
head(counties)
ui <- fluidPage(
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
               information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(0, 100))
      ),
    
    mainPanel(plotOutput("map"))
  )
)

server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var, 
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    
    percent_map(var = data, 
                color = 'blue', 
                legend.title = 'TEST', 
                max = 100, 
                min = 0)
  })

}

shinyApp(ui = ui, server = server)

