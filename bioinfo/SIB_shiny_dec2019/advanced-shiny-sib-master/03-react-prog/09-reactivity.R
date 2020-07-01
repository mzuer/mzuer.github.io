# Load packages ----------------------------------------------------------------
library(shiny)

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  actionButton("increment", "Increment"),
  actionButton("decrement", "Decrement"),
  actionButton("reset", "Reset"),
  h5("Value:"),
  textOutput("updated_value")
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {
  
  # create reactive value that we hold the value
  rv <- reactiveValues(x=0)
  # rv <- list(x=0)  # => will not work because rv$x is not actualized
  # start by creating the interactive value
  
  
  observeEvent(input$increment, {
    rv$x <- rv$x+1
  })
  
  observeEvent(input$decrement, {
    rv$x <- rv$x-1
  })
  
  
  observeEvent(input$reset, {
    rv$x <- 0
  })
  
  output$updated_value <- renderText({
    rv$x
  })
  
  
}

# Create the app ---------------------------------------------------------------
shinyApp(ui, server)
