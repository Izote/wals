get_parameter <- function(pid) {
  list(
    name = filter(parameters, id == pid)$parameter_name,
    codes = filter(codes, name == pid),
    values = filter(values, parameter_id == pid) 
  )
}

count_values <- function(pid_df, pid_levels, grp_vars, as_pct = TRUE) {
  if (!"value_label" %in% grp_vars) {
    grp_vars <- c(grp_vars, "value_label")
  }
  
  df <- pid_df %>% 
    group_by(across(grp_vars)) %>% 
    summarize(n = n(), .groups = "drop")
  
  if (as_pct) {
    total_vars <- grp_vars[grp_vars != "value_label"]
    totals <- pid_df %>% 
      count(across(all_of(total_vars)), name = "total_n")
    
    
    df <- df %>% 
      left_join(totals, by = total_vars) %>% 
      mutate(percent = n / total_n)
  }
  
  df %>% 
    mutate(across("value_label", factor, ordered = TRUE, levels = pid_levels))
}
