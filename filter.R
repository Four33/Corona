# download the dataset from ECDC to a local temporary file and copy into DF data
GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))

##select
data <- read.csv(tf)
head(data)
filter(data, countriesAndTerritories %in% c("Netherlands", "Germany"))


select(data, countriesAndTerritories, deaths)

      filter(data, countriesAndTerritories %in% c("Netherlands", "Germany"))
      select(data,deaths)


d=data
##filter on countries
d %>% filter(countriesAndTerritories == "Netherlands")


select(d, deaths)
##select




##filter
filter(data,countriesAndTerritories== "Netherlands")
head(data)

  filter(data, countriesAndTerritories %in% c("Netherlands", "Germany"))
  skim(data)

  
