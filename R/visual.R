library(plotly)

dist_plot <- function(pid) {
  param <- get_parameter(pid)
  
  # TODO
  # This should be packed as output from get_parameter.
  value_levels <- arrange(param$codes, desc(value_order))$value_label
  
  total_count <- param$values %>% 
    count(macroarea, name = "total")
  
  # TODO
  # `count_values` should just have the `param` list passed to it instead
  # of the first two arguments. This assumes prior TODO was accomplished.
  count_values(param$values, value_levels, "macroarea") %>% 
    plot_ly(
      x = ~ macroarea, y = ~ percent,
      color = ~ value_label,
      type = "bar"
      ) %>% 
    layout(
      title = param$name
    )
}
