library(shiny)

server <- function(input, output) {
  output$title <- renderText({
    sprintf("Now viewing: %s", get_parameter(input$param)$name)
    })
  
  output$macro_plot <- renderPlotly({
    macro_plot(input$param)
    })
  
  output$family_plots <- renderPlotly({
    family_plots(input$param)
    })
}

ui <- fluidPage(
  title = "Browser Title",
  fluidRow(
    textOutput("title", container = h2), # manage size with CSS
    column(
      width = 12,
      selectInput("param", "Parameter", param_choices),
      ),
    ),
  hr(),
  plotlyOutput("macro_plot"),
  plotlyOutput("family_plots"),
  )

shinyApp(ui = ui, server = server)