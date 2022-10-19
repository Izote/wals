get_parameter <- function(pid) {
  param_list <- list(
    name = filter(parameters, id == pid)$parameter,
    codes = filter(codes, parameter_id == pid),
    values = filter(values, parameter_id == pid)
  )
  
  param_list$value_levels <- arrange(param_list$codes, desc(order))$label
  
  param_list
}

count_values <- function(param_list, grp_vars, as_pct = TRUE) {
  if (!"value_label" %in% grp_vars) {
    grp_vars <- c(grp_vars, "label")
  }
  
  df <- param_list$values %>% 
    group_by(across(all_of(grp_vars))) %>% 
    summarize(n = n(), .groups = "drop")
  
  if (as_pct) {
    total_vars <- grp_vars[grp_vars != "label"]
    totals <- param_list$values %>% 
      count(across(all_of(total_vars)), name = "total_n")
    
    
    df <- df %>% 
      left_join(totals, by = total_vars) %>% 
      mutate(percent = n / total_n)
  }
  
  df %>% 
    mutate(
      across("label", factor, ordered = TRUE, levels = param_list$value_levels)
      )
}
