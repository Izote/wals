library(shiny)

server <- function(input, output) {
  output$link_button <- renderUI({
    a(
      "View related WALS chapter",
      class = "btn btn-default",
      href = sprintf(
        "https://wals.info/chapter/%s",
        str_remove_all(input$param, "[A-Z]")
        ),
      target = "_blank"
      )
  })
  
  output$bar_plot <- renderPlotly({
    bar_plot(input$param)
    })
  
  output$heat_maps <- renderPlotly({
    heat_maps(input$param)
    })
}

ui <- fluidPage(
  title = "WALS Summary View",
  h1("WALS Summary View"),
  selectInput("param", "WALS Feature/Parameter", param_choices),
  uiOutput("link_button"),
  plotlyOutput("bar_plot"),
  hr(),
  plotlyOutput("heat_maps")
  )

shinyApp(ui = ui, server = server)