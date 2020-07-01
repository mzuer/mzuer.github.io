# Load packages ----------------------------------------------------------------
library(shiny)


get_thumbnail <- function(myurl, mytitle, mydesc) {
  
 
  tags$div(class="thumbnail", 
           tags$div(class="embed-responsive embed-responsive-16by9",
                    tags$iframe(class="embed-responsive-item", src=myurl, "allowfullscreen"=NA)
                    # => use =NA to include the attribute without value
           ),
           tags$div(class="caption", 
                    tags$h3(mytitle),
                    tags$div(mydesc)))
  
   
}

# Define UI --------------------------------------------------------------------
ui <- fluidPage(
  # includeHTML("youtube_thumbnail.html")
  
  # tags$div(class="thumbnail", 
  #          tags$div(class="embed-responsive embed-responsive-16by9",
  #                   tags$iframe(class="embed-responsive-item", src="https://www.youtube.com/embed/hou0lU8WMgo", "allowfullscreen"=NA)
  #                   # => use =NA to include the attribute without value
  #          ),
  #          tags$div(class="caption", 
  #                   tags$h3("You are technically correct"),
  #                   tags$div("The best kind of correct!")))
  
  get_thumbnail(myurl="https://www.youtube.com/embed/hou0lU8WMgo", 
                mytitle= "My new tit",
                mydesc="... my new desc ...")
  
  
  )
  


# Define server ----------------------------------------------------------------
server <- function(input, output, session) {}

# Create the app ---------------------------------------------------------------
shinyApp(ui, server)


# print(includeHTML("youtube_thumbnail.html"))
# <div class="thumbnail">
#   <div class="embed-responsive embed-responsive-16by9">
#   <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/hou0lU8WMgo" allowfullscreen></iframe>
#   </div>
#   <div class="caption">
#   <h3>You are technically correct</h3>
#   <div>The best kind of correct!</div>
#   </div>
#   </div>