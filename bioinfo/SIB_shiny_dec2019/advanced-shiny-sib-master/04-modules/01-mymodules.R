# Module UI --------------------------------------------------------------------
movieModuleUI <- function(id) {
  ns <- NS(id)
  # here you could also add other components ot the UI
  tagList(
    plotOutput(ns("scatterplot")),        ### !!! do not forget to specify the namespace ! => correspond here to what is used in output$() in this module file
    DT::dataTableOutput(ns("moviestable"))
  )
  
}

# Module server ----------------------------------------------------------------
movieModule <- function(input, output, session, data, mov_title_type, x, y, z, size, alpha, show_data) {
  
  # Create subsets ----
  plot_data <- reactive({
    filter(data, title_type == as.character(mov_title_type))
  })
  

    
  # Scatterplot ----
  output$scatterplot <- renderPlot({
    ggplot(data = plot_data(), aes_string(x = x(), y = y(), color = z())) +  # reactiveExpression should be called with brackets !
      geom_point(alpha = alpha(), size = size()) +
      labs(x = toTitleCase(str_replace_all(x(), "_", " ")),
           y = toTitleCase(str_replace_all(y(), "_", " ")),
           color = toTitleCase(str_replace_all(z(), "_", " "))
      )
  })

  head(    filter(data, title_type == as.character(mov_title_type)))
  
  # Table for docs ----
  output$moviestable <- DT::renderDataTable(    ### => !!! 
    if(show_data()){
      DT::datatable(data = plot_data()[, 1:7], 
                    options = list(pageLength = 10), 
                    rownames = FALSE)
    }
  )
  

}
  