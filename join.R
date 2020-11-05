# download the dataset from ECDC to a local temporary file and copy into DF data
GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))

data <- read.csv(tf)
head(data)

dd <-select(data, month:countriesAndTerritories)
dd
###rename column name
dd <- rename(data, countries=countriesAndTerritories)

names(dd)
head(dd)

url="https://nl.wikipedia.org/wiki/Lijst_van_landen_naar_bevolkingsdichtheid"

urldata <- getURL("https://nl.wikipedia.org/wiki/Lijst_van_landen_naar_bevolkingsdichtheid")

data <- readHTMLTable(urldata,
                      stringsAsFactors = FALSE)

##read the data
x1=data$`NULL`
names(x1)

##x1 renamed to countries
x1 <- rename(x1, countries=V2)
head(x1)
dd <- rename(dd, countries=countriesAndTerritories)
##join dataset x1 and dd
head(dd)
head(x1)
# Outer join
mymergedata1 <- merge(x = dd, y = x1, by = "countries", all = TRUE)


arrange(join(x1,dd),countries)
###join 2 tables
new = x1 %>% left_join(dd, by= 'countries')
head(new)
dim(new)

###data imputation
transform(new, deaths = as.numeric(deaths))

