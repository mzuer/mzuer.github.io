# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(tools)

# Load data --------------------------------------------------------------------
load("movies.Rdata")

source("01-mymodules.R")

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  
  # Application title ----
  titlePanel("Movie browser - without modules"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Inputs: Select variables to plot ----
    sidebarPanel(
      
      # Select variable for y-axis ----
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis ----
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("IMDB rating" = "imdb_rating", 
                              "IMDB number of votes" = "imdb_num_votes", 
                              "Critics Score" = "critics_score", 
                              "Audience Score" = "audience_score", 
                              "Runtime" = "runtime"), 
                  selected = "critics_score"),
      
      # Select variable for color ----
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Title Type" = "title_type", 
                              "Genre" = "genre", 
                              "MPAA Rating" = "mpaa_rating", 
                              "Critics Rating" = "critics_rating", 
                              "Audience Rating" = "audience_rating"),
                  selected = "mpaa_rating"),
      
      # Set alpha level ----
      sliderInput(inputId = "alpha", 
                  label = "Alpha:", 
                  min = 0, max = 1, 
                  value = 0.5),
      
      # Set point size ----
      sliderInput(inputId = "size", 
                  label = "Size:", 
                  min = 0, max = 5, 
                  value = 2),
      
      # Show data table ----
      checkboxInput(inputId = "show_data",
                    label = "Show data table",
                    value = TRUE)
      
    ),
    
    # Output: ----
    mainPanel(
      
      # Show scatterplot ----
      tabsetPanel(id = "movies", 
                  
                  tabPanel("Documentaries", movieModuleUI("doc")),
                  tabPanel("Feature Films", movieModuleUI("feature")),
                  tabPanel("TV Movies", movieModuleUI("tv"))
      )
    )
  )
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {
  

    
  # !!! all the input$ should be passed as reactive expressions !
  
  x <- reactive(input$x)
  y <- reactive(input$y)
  z <- reactive(input$z)
  alpha <- reactive(input$alpha)
  size  <- reactive(input$size)
  show_data <- reactive(input$show_data)
  
  callModule(movieModule, "doc", data=movies, mov_title_type="Documentary",  # movies correspond to the loaded data !
                          x=x, y=y, z=z, size=size, alpha=alpha, show_data=show_data)
    
  callModule(movieModule, "feature", data=movies, mov_title_type="Feature Film",
             x=x, y=y, z=z, size=size, alpha=alpha, show_data=show_data)
  
  callModule(movieModule, "tv", data=movies, mov_title_type="TV Movie",
             x=x, y=y, z=z, size=size, alpha=alpha, show_data=show_data)
  
}

# Create the app ---------------------------------------------------------------
shinyApp(ui = ui, server = server)
