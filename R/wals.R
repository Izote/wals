library(tidyverse)

read_wals <- function(table) {
  file_path <- sprintf(
    "https://raw.githubusercontent.com/cldf-datasets/wals/master/cldf/%s.csv",
    table
    )

  read_csv(
    file_path,
    col_types = column_types[[table]]
  )
}

names_to_lower <- function(df) {
  str_to_lower(colnames(df))
}

n_cols <- list(codes = 6, languages = 16, parameters = 4, values = 8)

join_columns <- list(
  codes = c(1, 3, 5),
  languages = c(1, language = 2, 3, 4, 5, 8, 9, 10),
  parameters = c(1, 2)
)

column_types <- map(n_cols, ~ paste0(rep("c", .x, collapse = "")))

data_list <- map(names(n_cols), read_wals) %>%
  setNames(names(n_cols))

codes <- data_list$codes %>% 
  rename("label" = "Name", "order" = "Number")

parameters <- data_list$parameters %>% 
  rename("parameter" = "Name")

values <- data_list$values %>% 
  left_join(
    select(data_list$codes, join_columns$codes),
    by = c("Code_ID" = "ID")
    ) %>% 
  left_join(
    select(data_list$languages, join_columns$languages),
    by = c("Language_ID" = "ID")
    ) %>% 
  rename("label" = "Name") %>% 
  select(-ID, -Language_ID, -Code_ID, -Comment, -Source)

colnames(codes) <- names_to_lower(codes)
colnames(parameters) <- names_to_lower(parameters)
colnames(values) <- names_to_lower(values)

param_choices <- parameters$id
names(param_choices) <- sprintf("%s: %s", parameters$id, parameters$parameter)

# Temporary vector
macro_choices <- c("Africa", "Australia", "Eurasia", "North America", 
                   "Papunesia", "South America")

rm(n_cols, join_columns, column_types, data_list)
