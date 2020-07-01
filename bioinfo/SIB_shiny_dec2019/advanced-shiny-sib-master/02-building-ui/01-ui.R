# Load packages ----------------------------------------------------------------
library(shiny)

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  selectInput(inputId = "city",
              label = "Select city",
              choices = list("Scottland" = list("Edinburgh" = "edinburgh", "Glasgow"   = "glasgow"),
                             "Switzerland"=list("Lausanne"  = "lausanne", "Zurich"    = "zurich"))),
  strong("Selected city"),
  textOutput(outputId = "selected_city")
)

# Define server ----------------------------------------------------------------
server <- function(input, output, session) {
  output$selected_city <- renderText(input$city)
}

# Create the app ---------------------------------------------------------------
shinyApp(ui, server)


# correction in 03-ui.R => the list can contain vectors instead of lists
# last version of shiny -> no error if trailing comma (forget to delete last comma)