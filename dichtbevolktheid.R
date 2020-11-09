
url="https://nl.wikipedia.org/wiki/Lijst_van_landen_naar_bevolkingsdichtheid"

urldata <- getURL("https://nl.wikipedia.org/wiki/Lijst_van_landen_naar_bevolkingsdichtheid")

data <- readHTMLTable(urldata,
                      stringsAsFactors = FALSE)

#read the hHTML table

##read the data
names(data)
head(data)
## renamed data frame x
x=data$`NULL`
head(x)
names(x)

x <- rename(x, countries=V2)





