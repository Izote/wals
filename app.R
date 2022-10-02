library(shiny)

server <- function(input, output) {
  
}

ui <- fluidPage(
  mainPanel(wals$codes$description[[1]])
)

shinyApp(ui = ui, server = server)
