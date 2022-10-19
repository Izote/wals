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

family_plot <- function(pid, macro) {
  param <- get_parameter(pid)
  
  param %>% 
    count_values(c("macroarea", "family")) %>%
    drop_na() %>%
    filter(macroarea == macro) %>% 
    plot_ly(
      y = ~ family, x = ~ label, 
      text = ~ scales::percent_format(1)(percent), 
      type = "scatter", mode = "text"
      )
}
