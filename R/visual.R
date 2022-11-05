library(plotly)

bar_plot <- function(pid, plot_type = "bar") {
  param <- get_parameter(pid)
  
  param %>% 
    count_values("macroarea") %>% 
    plot_ly(
      x = ~ macroarea, y = ~ percent,
      color = ~ label,
      type = plot_type
      ) %>%
    add_trace(
      hovertemplate = "%{x}: %{y:.0%}<extra></extra>"
      ) %>% 
    layout(
      plot_bgcolor="#CCCCCC",
      title = "Parameter distribution by linguistic macroarea",
      xaxis = list(title = NA_character_),
      yaxis = list(title = NA_character_),
      legend = list(orientation = "h")
    )
}

heat_map <- function(df) {
  df %>% 
    drop_na() %>% 
    plot_ly(
      x = ~ family, y = ~ label, z = ~ percent,
      type = "heatmap",
      zauto = FALSE,
      zmin = 0.0, zmax = 1.0,
      coloraxis = "coloraxis",
      hoverongaps = FALSE
    ) %>% 
    add_trace(
      hovertemplate = "%{x}: %{z:.0%}<extra></extra>"
    ) %>% 
    layout(
      plot_bgcolor="#CCCCCC",
      coloraxis = list(colorscale = list(
        list(NA, "#CCCCCC"),
        list(0, "#00353D"),
        list(1, "#5DE9FE")
      )),
      xaxis = list(
        title = NA_character_,
        tickangle = -45
        ),
      yaxis = list(
        title = NA_character_
      )
    )
}

heat_maps <- function(pid) {
  values <- get_parameter(pid) %>% 
    count_values(c("macroarea", "family")) %>% 
    group_by(macroarea) %>% 
    do(fig = heat_map(.))
  
  fig <- values %>% 
    subplot(shareY = TRUE, nrows = 1) %>% 
    layout(title = "Parameter distribution by language family")
  
  fig
}


