df <- read_excel('popu.xlsx')
head(df)

GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))

data <- read.csv(tf)
head(data)

## clean dataset
df_cln <- data %>%
  mutate(Rpt_date = as.Date(as.character(dateRep), "%d/%m/%Y")) %>% 
  mutate(Cont_rate = cases / popData2019 * 100)


###rename column
dd <- rename(data, countries=countriesAndTerritories)
dd
###select columns
dd <-select(dd, month:countries)
head(dd)

###join datasets
mymergedata1 <- merge(x = df, y = dd, by = "countries", all = TRUE)
head(mymergedata1)
mymergedata1 <- mymergedata1[complete.cases(mymergedata1),]
mymergedata1
dim(mymergedata1)
###barplot
numbers <-filter(mymergedata1, deaths > 2000)
numbers
count <- table(numbers$countries)
barplot(count)
###coloured
g <- ggplot(numbers, aes(deaths))
g + geom_bar()
df <- mymergedata1
df
pl <- ggplot(df, aes(x=population))
print(pl + geom_bar(color='blue', fill='blue'))
###filter countries
df %>% 
  select(countries, deaths) %>% 
  filter(countries %in% c("Netherlands", "Germany"))
g <- ggplot(df, aes(countries, deaths))
p <- g + geom_point()
p
#######plot countries
ggplot(df, aes(x = deaths, y = population, col= "blue")) +
  geom_point()
#########df countries
jCountries <- c("Germany", "Netherlands")
ggplot(subset(df, countries %in% jCountries),
       aes(x = month, y = deaths, color = countries)) + geom_line() + geom_point()

## plotting the data
df %>% 
  filter(countriesAndTerritories == "Netherlands") %>% 
  ggplot(aes(Rpt_date, Cont_rate)) +
  geom_col() +
  scale_y_continuous(labels = scales::percent_format())





      
##plots
cc <- c("India", "Netherlands", "Germany", "Belgium")
head(cc)
ggplot(data = cc) +
  geom_bar(mapping = aes(x = countries, fill = deaths))

##maak een barplot
barplot(df$deaths,
        xlab='countries',
        ylab = 'deaths',
        main='countries vs deaths',
        col = 'blue')
      