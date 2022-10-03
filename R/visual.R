library(plotly)

dist_plot <- function(parameter) {
  total_count <- filter(wals, parameter_id == parameter) %>% 
    count(macroarea, name = "total")
  
  wals %>% 
    filter(parameter_id == parameter) %>% 
    group_by(macroarea, value_description) %>% 
    summarize(n = n(), .groups = "drop") %>%
    left_join(total_count, by = "macroarea") %>% 
    mutate(
      across(
        "value_description",
        factor, ordered = TRUE, levels = level_list[[parameter]]
        ),
      percent = n / total
      ) %>% 
    plot_ly(
      x = ~ macroarea, y = ~ percent,
      color = ~ value_description,
      type = "bar"
      ) %>% 
    layout(
      title = filter(data_list$parameters, id == parameter)$parameter_name
    )
}

level_list <- list(
  "2A" = c("Large (7-14)", "Average (5-6)", "Small (2-4)")
)