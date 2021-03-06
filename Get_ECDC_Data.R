# To retrieve data from European Centre for Disease Prevention and Control
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
  mutate(Cont_rate = cases / popData2019 * 100)


## plotting the data
df_cln %>% 
  filter(countriesAndTerritories == "Netherlands") %>% 
  ggplot(aes(Rpt_date, Cont_rate)) +
  geom_col() +
  scale_y_continuous(labels = scales::percent_format())

