library(plotly)

macro_plot <- function(pid, plot_type = "bar") {
  param <- get_parameter(pid)
  
  param %>% 
    count_values("macroarea") %>% 
    plot_ly(
      x = ~ macroarea, y = ~ percent,
      color = ~ label,
      type = plot_type
      ) %>% 
    layout(
      title = param$name
    )
}

family_plot <- function(df) {
  df %>% 
    drop_na() %>% 
    plot_ly(
      x = ~ family, y = ~ label, z = ~ percent,
      type = "heatmap", colors = "Greys",
      showscale = FALSE
    ) %>% 
    layout(
      xaxis = list(tickangle = -45)
    )
}

family_plots <- function(pid) {
  values <- get_parameter(pid) %>% 
    count_values(c("macroarea", "family")) %>% 
    group_by(macroarea) %>% 
    do(fig = family_plot(.))
  
  fig <- values %>% 
    subplot(shareY = TRUE, nrows = 1)
  
  fig
}


