GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))

##select
data <- read.csv(tf)
head(data)
##select columns
select(data, month:countriesAndTerritories)

##filter
dd <-filter(data, deaths > 3000)
dd
count <- table(dd$countriesAndTerritories)
barplot(count)


dd <-dd[c(6,7)]

mymatrix <- data.matrix(dd)
mymatrix
mymatrixtrans <- t(mymatrix)
mymatrixtrans
barplot(mymatrixtrans,
xlab= 'countriesAndTerritories',
main= 'number of deaths',
col=c('blue', 'red'),
names.arg=dd$countriesAndTerritories)

##stacked barplot
##ggplot
barplot(dd$countriesAndTerritories)



data[data$countriesAndTerritories == "Netherlands",]
