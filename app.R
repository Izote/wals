library(shiny)

server <- function(input, output) {
  output$dist_plot <- renderPlotly({dist_plot(input$pid_selection)})
}

ui <- fluidPage(
  title = "Browser Title",
  fluidRow(
    column(
      width = 4,
      h1("Visual Title"),
      selectInput("pid_selection", "Label", parameters$id)
      ),
    # Placeholder columns, assuming additional controls.
    column(width = 4),
    column(width = 4),
    ),
  hr(),
  plotlyOutput("dist_plot")
  )

shinyApp(ui = ui, server = server)
