# System and packages-----------------------------------------------------------
library(tabulizer) # for extract_tables
library(tidyr)
library(dictionary)

# Functions---------------------------------------------------------------------
# Extracts information from a specific page of a pdf file and returns the output
# in a data frame.
extract_df <- function(file, page){
  dfraw <- extract_tables(file = file, pages = page)
  dfraw <- as.data.frame(dfraw,stringsAsFactors=F)
  return(dfraw)
}

# Tidy the data frame outputed from the function `extract_df`: rename the column
# name, output the data frame on a long format with the value in numeric
cleaned_df <- function(dfraw){
  colnames(dfraw) <-as.character(unlist(dfraw[1,]))
  colnames(dfraw)[1] <- "district"
  dfraw <- dfraw[-1:-2,]
  dfraw <- gather(dfraw,key="year",value="avrg_pop",-district)
  dfraw$district <- tolower(dfraw$district)
  dfraw <- dfraw[-which(grepl("total|urban|rural",dfraw$district)),]
  dfraw$avrg_pop <- as.numeric(dfraw$avrg_pop)
  dfraw$year <- as.numeric(dfraw$year)
  return(dfraw)
}

# Translate the district name without accent (ascii)
translate_dist <- function(dfraw){
  dfraw <- separate(dfraw,district,c("VN","ENG"),sep=" - ")
  dfraw <- dfraw[,-which(colnames(dfraw)=="VN")]
  dfraw$ENG <- gsub(pattern = "dist.", replacement="district",dfraw$ENG)
  dfraw$ENG <- translate(dfraw$ENG,vn_admin2)
  colnames(dfraw)[colnames(dfraw)=="ENG"] <- "district"
  return(dfraw)
}

# Data -------------------------------------------------------------------------

avg_pop <- extract_df(file = "data-raw/untitled.pdf", page = 9)
avg_pop <- cleaned_df(avg_pop)
avg_pop <- translate_dist(avg_pop)

male_avg_pop <- extract_df(file="data-raw/untitled.pdf", page = 10)
male_avg_pop <- cleaned_df(male_avg_pop)
male_avg_pop <- translate_dist(male_avg_pop)

female_avg_pop <- extract_df(file="data-raw/untitled.pdf", page = 11)
female_avg_pop <- cleaned_df(female_avg_pop)
female_avg_pop <- translate_dist(female_avg_pop)

# Save to package --------------------------------------------------------------

usethis::use_data(avg_pop,overwrite=T,internal = F)
usethis::use_data(male_avg_pop,overwrite=T,internal=F)
usethis::use_data(female_avg_pop,overwrite=T,internal=F)

# Empty environment ------------------------------------------------------------

rm(list = ls())
