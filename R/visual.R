library(plotly)

dist_plot <- function() {
  total_count <- filter(wals, parameter_id == "2A") %>% 
    count(macroarea, name = "total")
  
  wals %>% 
    filter(parameter_id == "2A") %>% 
    group_by(macroarea, value_description) %>% 
    summarize(n = n(), .groups = "drop") %>%
    left_join(total_count, by = "macroarea") %>% 
    mutate(
      across("value_description", factor, ordered = TRUE,
             levels = c("Large (7-14)", "Average (5-6)", "Small (2-4)")),
      percent = n / total
      ) %>% 
    plot_ly(
      x = ~ macroarea, y = ~ percent,
      color = ~ value_description,
      type = "bar"
      )
}
