# To retreive data from European Centre for Disease Prevention and Control
# source: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide

## housekeeping
library(utils)
library(httr)
library(tidyverse)

# download the dataset from ECDC to a local temporary file and copy into DF data
GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))
data <- read.csv(tf)

## clean dataset
df_cln <- data %>%
  mutate(Rpt_date = as.Date(as.character(dateRep), "%d/%m/%Y")) %>% 
  mutate(Cont_rate = cases / popData2018 * 100)

