# What: workshop
# When: 2016-10-18
# Who: LCW
# Other: nothing much...

# here is some more stuff Lee added after the first commit to see how version control handles this

######################################
# even more stuff added around 2:11 pm   ##changing this line at 2:18 deleting next line of hasshes
## deleted the line below after conn that read:  #conn <- dbConnect(SQLite(), dbname='~/Desktop/survey.sqlite')


library('RSQLite')

conn <- dbConnect(SQLite(), dbname='C:/Users/Lilli/Desktop/survey.sqlite')


tables <- dbListTables(conn)
tables 

class(tables)

surveys <- dbGetQuery(conn, 'SELECT * FROM surveys')
head(surveys)
summary(surveys)

surveys <- dbGetQuery(conn,
  'SELECT * FROM surveys 
    JOIN species ON surveys.species_id = species.species_id
    JOIN plots ON surveys.plot_id = plots.plot_id;')

surveys <- read.csv('C:/Users/Lilli/Desktop/ecology.csv')

df <- data.frame(
  x1 = c(TRUE, FALSE, TRUE),
  x2 = c(1, 'red', 2) )

str(surveys)

class(surveys$year)  #vector
head(surveys$year)
class(surveys['year'])  #dataframe
head(surveys$year)
class(surveys[,'year'])  #vector
head(surveys$year)
class(surveys[,4])  #dataframe
head(surveys$year)

#Factors

spice <- factor( c('low', 'medium', 'low', 'high'))

tabulation <- table(surveys$taxa)


dbDisconnect(conn)
rm(conn)




tabulation <- ordered(surveys$taxa)

sortTaxaBySize <- ordered(surveys$taxa, levels=c('Rodent', 'Bird', 'Rabbit', 'Reptile'))


# New example

surveys$taxa == 'Rodent'
length(surveys$taxa == 'Rodent')
dim(surveys)

surveys[surveys$taxa == 'Rodent', 'taxa']

surveys[ (surveys$year >= 1980) | (surveys$year >= 1990), 'year']
length( surveys[ (surveys$year >= 1980) & (surveys$year >= 1990), 'year'] )
length( surveys[ (surveys$year >= 1980) & (surveys$year >= 1990), 'year'] )




# New topic in class, using filter can be easier than and or logic

install.packages('dplyr')  #this package allows operations primarily on dataframes
library(dplyr)

output <- select(surveys, year, taxa, weight)
filter(surveys, taxa =='Rodent')  # dplyr::filter(surveys, taxa =='Rodent')  #is more specific to which package has the desired function 



# pipes topic, syntax is %>%

surveys %>%
  filter(taxa=='Rodent') %>%
  select(year, taxa, weight)

rodent_surveys <- surveys %>%
  filter(taxa=='Rodent') %>%
  select(year, taxa, weight)

rodent_surveys <- surveys %>%
  filter(taxa=='Rodent', year %in% seq.int(1980,1990)) %>%
  select(year, taxa, weight)


#creating new columns
surveys %>%
  mutate(weight_kg = weight / 10000)



# ggplot2

library(ggplot2)

ggplot(data = surveys,
       aes(x = weight, y=hindfoot_length, color = species_id) ) + 
  geom_point()
      



