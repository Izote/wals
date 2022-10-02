library(tidyverse)
library(plotly)

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
  codes = c("id", "name", "description", "chapter_id"),
  languages = c("id", "name", "macroarea", "latitude", "longitude", 
                "glotto_code", "iso_639P3_code", 
                "family", "subfamily", "genus", "genus_icon", 
                "iso_codes", "samples_100", "samples_200", 
                "country_id", "source"),
  parameters = c("id", "name", "description", "chapter_id"),
  values = c("id", "language_id", "parameter_id", "value",
             "code_id", "comment", "source", "example_id")
)

type_list <- map(name_list, ~ paste0(rep("c", length(.x)), collapse = ""))

wals <- map(names(name_list), read_wals) %>% 
  setNames(names(name_list))
