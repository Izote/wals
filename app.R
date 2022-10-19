library(shiny)

server <- function(input, output) {
  output$title <- renderText({
    sprintf("Now viewing: %s", get_parameter(input$param)$name)
    })
  
  output$macro_plot <- renderPlotly({
    macro_plot(input$param)
    })
  
  output$family_plot <- renderPlotly({
    family_plot(input$param, input$macro)
    })
}

ui <- fluidPage(
  title = "Browser Title",
  fluidRow(
    textOutput("title", container = h2), # manage size with CSS
    column(
      width = 4,
      selectInput("param", "Parameter", param_choices),
      ),
    column(
      width = 4, 
      selectInput("macro", "Macroarea", macro_choices)
      ),
    column(width = 4),
    ),
  hr(),
  plotlyOutput("macro_plot"),
  plotlyOutput("family_plot"),
  )

shinyApp(ui = ui, server = server)