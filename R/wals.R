library(tidyverse)

read_wals <- function(table) {
  # temporary (local) directory while development is still highly active
  file_path <- sprintf("./cldf/%s.csv", table)
  read_csv(
    file_path,
    col_names = column_names[[table]],
    col_types = column_types[[table]],
    skip = 1
  )
}

# Leave this to make building visualizations consistent, but ultimately
# a simple set of renames can more readably handle this need downstream.
column_names <- list(
  codes = c("id", "name", "value_label", "chapter_id", "value_order", "icon"),
  languages = c("id", "language_name", "macroarea", "latitude", "longitude", 
                "glotto_code", "iso_639P3_code", "family", "subfamily", "genus",
                "genus_icon", "iso_codes", "samples_100", "samples_200", 
                "country_id", "source"),
  parameters = c("id", "parameter_name", "parameter_description", "chapter_id"),
  values = c("id", "language_id", "parameter_id", "value", "code_id", "comment",
             "source", "example_id")
)

join_columns <- list(
  codes = c(1, 3, 5),
  languages = c(1, 2, 3, 4, 5, 8, 9, 10),
  parameters = c(1, 2)
)

column_types <- map(column_names, ~ paste0(rep("c", length(.x)), collapse = ""))

data_list <- map(names(column_names), read_wals) %>% 
  setNames(names(column_names))

codes <- data_list$codes
parameters <- data_list$parameters
values <- data_list$values %>% 
  left_join(
    select(data_list$codes, column_names$codes[join_columns$codes]),
    by = c("code_id" = "id")
    ) %>% 
  left_join(
    select(data_list$languages, column_names$languages[join_columns$languages]),
    by = c("language_id" = "id")
    ) %>% 
  select(-id, -language_id, -code_id, -example_id, -comment, -source)

rm(column_names, join_columns, column_types)