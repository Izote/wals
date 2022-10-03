library(shiny)

server <- function(input, output) {
  output$dist_plot <- renderPlotly({dist_plot("2A")})
}

ui <- fluidPage(
  mainPanel(
    plotlyOutput("dist_plot")
  )
)

shinyApp(ui = ui, server = server)
