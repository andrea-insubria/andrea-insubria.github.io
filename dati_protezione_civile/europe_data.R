rm(list = ls())


### load packages ####
library(tidyverse)
library(plotly)
library(sf)
library(DT)

Sys.setenv('MAPBOX_TOKEN' = 'pk.eyJ1IjoiYW5kcmVhLW0iLCJhIjoiY2s4b20zcGFpMDh5cDNldDJ4YTYwNmFlMiJ9.TReLfeIr7ZVEMYMJg2w0-g')
########################################
##   Importazione sigle internaz.   ####
##   e suddivisione in continenti   ####
##    INTERNATIONAL STATES CODES    ####
########################################

nationalCode = read_csv('~/Documents/lavotex/lavori/covid_19/websites/hugo_universal_new/dati_protezione_civile/world_shape/country-and-continent-codes-list-csv_csv.csv')

nationalCode = nationalCode %>% arrange(Continent_Code)
europeCodes = nationalCode %>% filter(Continent_Code == 'EU')


#######################################################
###         Importazione shapefile mondiali         ###
#######################################################

# worldMap = st_read('static/dati_protezione_civile/world_shape/CNTR_RG_60M_2016_3035.shp/CNTR_RG_60M_2016_3035.shp')
# worldMap = st_read('static/dati_protezione_civile/world_shape/CNTR_RG_60M_2016_3857.shp/CNTR_RG_60M_2016_3857.shp')
worldMap = st_read('dati_protezione_civile/world_shape/CNTR_RG_60M_2016_4326.shp/CNTR_RG_60M_2016_4326.shp')

# worldStates = st_read('static/dati_protezione_civile/world_shape/World_Countries/World_Countries.shp')
worldCities = st_read('dati_protezione_civile/world_shape/World_Cities/World_Cities.shp')
worldCities = cbind(worldCities, st_coordinates(worldCities))
worldCapital = worldCities %>% filter(CAPITAL == 'Y')

## this dataset is from 
## https://hub.arcgis.com/datasets/6996f03a1b364dbab4008d99380370ed_0
worldCities = st_read('~/Downloads/World_Cities/World_Cities.shp')
worldCapital = worldCities %>% filter(STATUS %in% c('National capital','National and provincial capital', 'National capital and provincial capital enclave')) %>% 
          mutate(countryterritoryCode = strtrim(GMI_ADMIN, 3))
worldCapital$countryterritoryCode[worldCapital$CNTRY_NAME == 'Montenegro'] = 'MNE'
worldCapital$countryterritoryCode[worldCapital$CNTRY_NAME == 'Romania'] = 'ROU'
worldCapital$countryterritoryCode[worldCapital$CNTRY_NAME == 'Guernsey'] = 'GGY'
worldCapital$countryterritoryCode[worldCapital$CNTRY_NAME == "Isle of Man"] = 'IMN'
worldCapital$countryterritoryCode[worldCapital$CNTRY_NAME == "Jersey"] = 'JEY'

worldCapital = cbind(worldCapital, st_coordinates(worldCapital))              

## these shapefiles are downloaded from 
## https://www.naturalearthdata.com/downloads/
## these are the same of package map
## the following includes sovereign 
# worldStates = st_read('static/dati_protezione_civile/world_shape/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp')
## the following does NOT include sovereign 
worldStates = st_read('static/dati_protezione_civile/world_shape/ne_10m_admin_0_map_units/ne_10m_admin_0_map_units.shp')

worldCountries = worldStates %>% filter(TYPE == 'Country')
europeStates = worldStates %>% filter(CONTINENT == "Europe")


#####################################################
####   import datasets from different sources    ####
#####################################################

#######################################################
##        dati da HDX sono quelli della WHO        ####
#######################################################

## see https://data.humdata.org/dataset/coronavirus-covid-19-cases-data-for-china-and-the-rest-of-the-world 
## dati odierni 
dati = read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTBI8MZx7aNt8EjYqkeojTopZKwSYGWCSKUzyS9xobrS5Tfr9SQZ_4hrp3dv6bRGkHk2dld0wRrJIeV/pub?gid=0&single=true&output=csv")

## serie dei dati 
datiHist = read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTBI8MZx7aNt8EjYqkeojTopZKwSYGWCSKUzyS9xobrS5Tfr9SQZ_4hrp3dv6bRGkHk2dld0wRrJIeV/pub?gid=32379430&single=true&output=csv")

datiHist$DateOfDataEntry = as.Date(datiHist$DateOfDataEntry)


################################################################
### EUROPEAN CENTRE FOR DISEASE PREVENTION AND CONTROL DATA ####
################################################################
## see https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide
## 
# read the Dataset sheet into “R”. The dataset will be called "data".
dataOrig <- read_csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na = "")

# modifiche di formato ad alcune variabili
data = dataOrig %>% mutate(dateRep = as.Date(dateRep, format = '%d/%m/%Y'), geoId = factor(geoId))

## aggiunge somme di casi cumulate per paese
data = data %>%  group_by(geoId) %>% arrange(dateRep, countriesAndTerritories) %>% mutate(cumCases = cumsum(cases), cumDeaths = cumsum(deaths))

## elimina entrate "Cases_on_an_international_conveyance_Japan"
data = data %>% filter(countriesAndTerritories != "Cases_on_an_international_conveyance_Japan") %>% 
  mutate(countriesAndTerritories = gsub('_', ' ', countriesAndTerritories))


############################################################
####                  Europe data                       ####
############################################################


# dataEurope = data %>% filter(geoId %in% europeCodes$Two_Letter_Country_Code) 
dataEurope = data %>% filter(countryterritoryCode%in% europeCodes$Three_Letter_Country_Code) 


### formatting plots ####
f1 <- list(family = "Arial, sans-serif",
           size = 18,
           color = "lightgrey" )
f2 <- list( family = "Old Standard TT, serif",
            size = 14,
            color = "black" )


## setting axis
axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Data', mirror = 'all', tickangle = 45, titlefont = f1) 

###########################
## numero totale di casi ####
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Totale casi', mirror = 'all', titlefont = f1) 
plyCases = dataEurope %>%  
  filter(dateRep >= "2020-02-20") %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~cumCases, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Casi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyCases

## proporzione di cas rispetto alla popolazione ####
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Numero di casi per 1000 abitanti', mirror = 'all', titlefont = f1) 

plyCasesRate = dataEurope %>%  mutate(cumCasesRate = cumCases / popData2018 * 1000) %>% 
  filter(dateRep >= "2020-02-20") %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~cumCasesRate, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Casi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyCasesRate

## only states with population >= 1.e7 
plyCasesRate = dataEurope %>%  mutate(cumCasesRate = cumCases / popData2018 * 1000) %>% 
  filter(dateRep >= "2020-02-20", popData2018 >= 1.e7) %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~cumCasesRate, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Casi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyCasesRate

## proporzione di nuovi casi rispetto alla popolazione ####
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Numero di nuovi casi per 100000 abitanti', mirror = 'all', titlefont = f1) 

plyNewCasesRate = dataEurope %>%  mutate(newCasesRate = cases / popData2018 * 100000) %>% 
  filter(dateRep >= "2020-02-20", popData2018 >= 1.e7) %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~newCasesRate, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Casi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyNewCasesRate

## deaths ####
## numero totale di casi ####
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Totale decessi', mirror = 'all', titlefont = f1) 
plyDeaths = dataEurope %>%  
  filter(dateRep >= "2020-02-20") %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~cumDeaths, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Decessi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyDeaths

## proporzione di cas rispetto alla popolazione ####

## only states with population >= 1.e7 
plyDeathsRate = dataEurope %>%  mutate(cumDeathsRate = cumDeaths / popData2018 * 10000) %>% 
  filter(dateRep >= "2020-02-20", popData2018 >= 1.e7) %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~cumDeathsRate, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Decessi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y, title = 'Decessi cumulati per 10000 abitanti')

plyDeathsRate

## proporzione di nuovi decessi rispetto alla popolazione ####
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Numero di nuovi decessi per 100000 abitanti', mirror = 'all', titlefont = f1) 

plyNewDeathsRate = dataEurope %>%  mutate(newDeathsRate = deaths / popData2018 * 100000) %>% 
  filter(dateRep >= "2020-02-20", popData2018 >= 1.e7) %>% group_by(geoId) %>% 
  plot_ly(x = ~dateRep, y = ~newDeathsRate, name = ~countriesAndTerritories, type = 'scatter', mode = 'lines', hovertemplate = paste('<b>Data: </b>%{x}\n', '<b>Decessi: </b>%{y}')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y)

plyNewDeathsRate






##############################################
##              plot today data             ##
##############################################

dataEuropeShp = ungroup(dataEurope %>% filter(dateRep == max(dateRep)))
# dataEuropeShp = merge(worldCapital, dataEuropeShp) 
# dataEuropeShp = dataEuropeShp[, c(1, 4, 8, 15:17, 21:22, 25:28)]
dataEuropeShp = merge(dataEuropeShp, worldCapital) 
# st_geometry(dataEuropeShp)
dataEuropeShp = dataEuropeShp[, c(1, 2, 6, 7, 10, 11, 12, 13, 16, 20, 27, 28)]


## add rate of cases 
dataEuropeShp = dataEuropeShp %>% 
  mutate(cumCaseRate = cumCases/popData2018*1.e5, newCaseRate = cases /popData2018 * 1.e5, cumDeathsRate = cumDeaths/popData2018 *1.e5, newDeathsRate = deaths /popData2018 * 1.e5)

dataEuropeShp = dataEuropeShp %>% filter(CNTRY_NAME != 'San Marino')


europeDeathMap = dataEuropeShp %>% plot_mapbox() %>%
  add_markers(x = ~X, y = ~Y, type = 'scatter', mode = 'markers', 
              marker = list(color = 'red',
                            # size = ~your_list_of_size_values,
                            size = ~cumDeathsRate,
                            opacity = 0.5, 
                            sizemode = 'area', 
                            sizeref = .03), 
              text = paste('Decessi:', round(dataEuropeShp$cumDeathsRate, 2), '\nStato:', dataEuropeShp$CNTRY_NAME),
              hoverinfo = 'text')  %>%
  layout(mapbox = list(
    center = list(lon = 7.75, lat = 53.58),
    zoom = 3.0),
    showlegend = FALSE,
    title = 'Numero di decessi ogni 100000 abitanti')

europeDeathMap

dataCasesPublication = dataEuropeShp

dataCasesPublication = dataCasesPublication %>% 
  # select(Stato = CNTRY_NAME, Casi = cumCases, Rate = cumCaseRate) %>%
  select(CNTRY_NAME, cumCases, cumCaseRate) #%>%

library(crosstalk)
sd <- SharedData$new(dataCasesPublication)

europeCasesMap = sd %>% plot_mapbox()
europeCasesMap = europeCasesMap %>%
  add_markers(x = ~dataEuropeShp$X, y = ~dataEuropeShp$Y, type = 'scatter', mode = 'markers', 
              marker = list(color = 'red',
                            # size = ~your_list_of_size_values,
                            size = ~dataEuropeShp$cumCaseRate,
                            opacity = 0.5, 
                            sizemode = 'area', 
                            sizeref = .6), 
              text = paste('Casi:', round(dataEuropeShp$cumCaseRate, 2), '\nStato:', dataEuropeShp$CNTRY_NAME),
              hoverinfo = 'text')  %>%
  layout(mapbox = list(
    center = list(lon = 7.75, lat = 53.58),
    zoom = 3.0),
    showlegend = FALSE,
    title = 'Numero di casi ogni 100000 abitanti') 

europeCasesMap <- europeCasesMap %>%
  highlight("plotly_selected", dynamic = TRUE)

options(persistent = TRUE)

p <- sd %>% 
  datatable(rownames = FALSE)

bscols(widths = c(8,4), europeCasesMap, p)


dataCasesPublication = dataEuropeShp

dataCasesPublication = dataCasesPublication %>% 
  # select(Stato = CNTRY_NAME, Casi = cumCases, Rate = cumCaseRate) %>%
  select(CNTRY_NAME, cumCases, cumCaseRate) #%>%
  
p <- dataCasesPublication %>% datatable(rownames = FALSE, 
                                   # colnames = c('Stato', 'Totale casi', 'Casi per 1.e5 abitanti'),
                                   options = list(
                                     pagelength = 10,
                                     autoWidth = TRUE)
                                   )




dataEuropePub = as.data.frame(dataEuropeShp)

dataEuropePub <- as_tibble(dataEuropePub) %>% select(CNTRY_NAME, cumCases, cumCaseRate)



datiRegioniToday %>% plot_ly(split = ~countr, color = ~totale_positivi, type = 'scatter', mode = 'lines', line = list(width = .1), text = ~paste('<b>', DEN_REG, '<b>','\n<b>Positivi </b>:', totale_positivi), hoveron = 'fills', hoverinfo = 'text') %>%
  layout(legend = list(x = -0, y = .9,  title = list(text = 'Regione')), showlegend = FALSE) %>%
  colorbar(title = 'Totale \npositivi', x = 1, y = .85)






