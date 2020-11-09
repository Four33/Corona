GET("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", 
    authenticate(":", ":", type="ntlm"), 
    write_disk(tf <- tempfile(fileext = ".csv")))

##select
data <- read.csv(tf)
head(data)
mydata <-filter(data, deaths > 1000)
mydata
####barplot with > deaths
ggplot(data = country,
       aes(x = reorder(countriesAndTerritories, deaths), y = deaths,
           fill = deaths > 3000))+ 
  geom_bar(stat = "identity")+
  coord_flip()

####countries with > 3000 deaths
dd <-filter(data, deaths > 3000)
dd
str(dd)
qplot(countriesAndTerritories, color = deaths, data = dd)
p <- ggplot(dd, aes(factor(countriesAndTerritories)))
p + geom_bar(fill = "red")

##barplots reorder
       ggplot(data = dd,
              aes(x = reorder(countriesAndTerritories, deaths), y = deaths))+
         geom_bar(stat = "identity")+
         coord_flip()

       
       
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


data[data$countriesAndTerritories == "Netherlands",]
