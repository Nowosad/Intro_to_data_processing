## ---- eval=FALSE---------------------------------------------------------
## library('gapminder')

## ------------------------------------------------------------------------
gapminder <- readRDS('data/gapminder.rds')

## ------------------------------------------------------------------------
head(gapminder)

## ------------------------------------------------------------------------
gapminder$country

## ------------------------------------------------------------------------
countries <- gapminder$country
countries

## ------------------------------------------------------------------------
head(gapminder)

## ------------------------------------------------------------------------
gapminder[3, ]

## ------------------------------------------------------------------------
gapminder[2, 3]

## ------------------------------------------------------------------------
gapminder[-(1:1650), 3]

## ------------------------------------------------------------------------
gapminder[c(2,4), -3]

## ------------------------------------------------------------------------
gapminder[c(2,4), c("country", "pop")]

## ------------------------------------------------------------------------
gapminder[gapminder$lifeExp>82, c("country", "pop")]

## ------------------------------------------------------------------------
subset(gapminder, pop>1000000000)

## ------------------------------------------------------------------------
subset(gapminder, pop>1000000000 & country=='India')

## ------------------------------------------------------------------------
subset(gapminder, pop>1000000000 | continent=='Oceania')

## ------------------------------------------------------------------------
africa <- subset(gapminder, continent=='Africa')
africa

## ------------------------------------------------------------------------
year_2007 <- gapminder[gapminder$year==2007, ]
year_2007

## ---- eval=FALSE---------------------------------------------------------
## gapminder[2, 1]
## gapminder[1, 3]
## gapminder[, 1]
## gapminder[1]
## gapminder[1, ]
## gapminder[0, 3]
## gapminder[-2, ]
## gapminder[, -1]
## gapminder[c(1,5,7), ]
## gapminder[, c(1,2)]
## gapminder[gapminder$pop<100000, ]
## gapminder[gapminder$year==1952, c(4)]

## ---- eval=FALSE---------------------------------------------------------
## gapminder$lifeExp

## ---- echo=FALSE---------------------------------------------------------
head(gapminder$lifeExp)

## ---- eval=FALSE---------------------------------------------------------
## gapminder$continent

## ---- echo=FALSE---------------------------------------------------------
head(gapminder$continent)

## ------------------------------------------------------------------------
# install.packages('dplyr')
# devtools::install_github("tidyverse/dplyr")
library('dplyr')

## ------------------------------------------------------------------------
gapminder_sel1 <- select(gapminder, country, year, pop)

## ------------------------------------------------------------------------
gapminder_sel2 <- select(gapminder, -continent)

## ------------------------------------------------------------------------
gapminder_arr1 <- arrange(gapminder, lifeExp)

## ------------------------------------------------------------------------
gapminder_arr1 <- arrange(gapminder, desc(lifeExp))

## ------------------------------------------------------------------------
gapminder_fil1 <- filter(gapminder, year == 2007)

## ------------------------------------------------------------------------
gapminder_fil2 <- filter(gapminder, year == 2007 & pop <= 999999)

## ------------------------------------------------------------------------
gapminder_fil2 <- filter(gapminder, continent != 'Asia' |  lifeExp < 30)

## ------------------------------------------------------------------------
gapminder_mut1 <- mutate(gapminder, gdp_mil = (gdpPercap * pop) / 1000000)

## ------------------------------------------------------------------------
gapminder_sum1 <- summarize(gapminder, mean_le = mean(lifeExp))

## ---- echo=FALSE---------------------------------------------------------
gapminder_sum1

## ------------------------------------------------------------------------
gapminder_sum2 <- summarize(gapminder, 
                            mean_le = mean(lifeExp), 
                            min_le = min(lifeExp), 
                            max_le = max(lifeExp))

## ---- echo=FALSE---------------------------------------------------------
gapminder_sum2

## ------------------------------------------------------------------------
gapminder2007 <- filter(gapminder, year == 2007)
gapminder_grp1 <- group_by(gapminder2007, continent)

## ---- echo=FALSE---------------------------------------------------------
head(gapminder_grp1)

## ------------------------------------------------------------------------
gapminder_grp1 <- summarize(gapminder_grp1, mean_lifeExp = mean(lifeExp))

## ------------------------------------------------------------------------
# install.packages('tidyr')
library('tidyr')

## ------------------------------------------------------------------------
gapminder_sel <- select(gapminder, -continent, -lifeExp, -gdpPercap)
gapminder_spread <- spread(gapminder_sel, country, pop)

## ------------------------------------------------------------------------
gapminder_gather <- gather(gapminder_spread, country, pop, -year)

## ------------------------------------------------------------------------
gapminder_sel <- select(gapminder, country, continent, pop)
gapminder_africa <- filter(gapminder_sel, continent=='Africa')

## ------------------------------------------------------------------------
gapminder_africa <- filter(select(gapminder, country, continent, pop), continent=='Africa')

## ------------------------------------------------------------------------
gapminder_africa <- gapminder %>% 
        select(country, continent, pop) %>% 
        filter(continent=='Africa')

## ------------------------------------------------------------------------
gapminder_proc <- gapminder %>% 
        filter(continent=='Europe', year==2007) %>% 
        mutate(pop_in_thousands=pop/1000) %>% 
        select(country, gdpPercap, pop_in_thousands) %>% 
        gather(key, value, gdpPercap, pop_in_thousands)

