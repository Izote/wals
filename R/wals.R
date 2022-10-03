library(tidyverse)

read_wals <- function(table) {
  # temporary (local) directory while development is still highly active
  file_path <- sprintf("./cldf/%s.csv", table)
  read_csv(
    file_path,
    col_names = name_list[[table]],
    col_types = type_list[[table]],
    skip = 1
  )
}

name_list <- list(
  codes = c("id", "name", "value_description", "chapter_id"),
  languages = c("id", "language_name", "macroarea", "latitude", "longitude", 
                "glotto_code", "iso_639P3_code", 
                "family", "subfamily", "genus", "genus_icon", 
                "iso_codes", "samples_100", "samples_200", 
                "country_id", "source"),
  parameters = c("id", "parameter_name", "parameter_description", "chapter_id"),
  values = c("id", "language_id", "parameter_id", "value",
             "code_id", "comment", "source", "example_id")
)

column_list <- list(
  codes = c(1, 3),
  languages = c(1, 2, 3, 4, 5, 8, 9, 10),
  parameters = c(1, 2)
)

type_list <- map(name_list, ~ paste0(rep("c", length(.x)), collapse = ""))

data_list <- map(names(name_list), read_wals) %>% 
  setNames(names(name_list))


wals <- data_list$values %>% 
  left_join(
    select(data_list$codes, name_list$codes[column_list$codes]),
    by = c("code_id" = "id")
    ) %>% 
  left_join(
    select(data_list$languages, name_list$languages[column_list$languages]),
    by = c("language_id" = "id")
    ) %>% 
  select(-id, -language_id, -code_id, -example_id, -comment, -source)
