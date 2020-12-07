## In this script we import protezione civile data on corona virus. This data are updated daylies
## and are othree kind 
##    - national 
##    - regional
##    - counties
##    
##  Once the data are downloaded, they are stored in data folder and imported in dataframe for-
##  mat


# rm(list = ls())
Sys.setenv(TZ = 'GMT')

## load packages ####
require(spdep)
require(rgdal)
require(maps)
library(maptools)
require(rosm)
require(lubridate)
library(raster)
library(prettymapr)
library(plotly)

## data importation ####
# setwd("~/Documents/lavotex/lavori/covid_19/websites/hugo_universal/static/dati_protezione_civile/")

prefixDir = "~/Documents/lavotex/lavori/covid_19/websites/hugo_universal/static/dati_protezione_civile/"
data = gsub('-', '_', today())


## data importation ####
## download data ####
fileNameNaz = paste(prefixDir,'data/dati_nazionali_', data, '.csv', sep = '')
download.file('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv', fileNameNaz) 

fileNameReg = paste(prefixDir, 'data/dati_regionali_', data, '.csv', sep = '')
download.file('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv', fileNameReg) 

fileNameProv = paste(prefixDir,'data/dati_provinciali_', data, '.csv', sep = '')
download.file('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv', fileNameProv) 


## import data ####
## dati nazionali
datiNazionali <- read.csv(fileNameNaz)

datiNazionali$originalDate = datiNazionali$data
datiNazionali$data <- strtrim(datiNazionali$data,10)
datiNazionali$data <- as.Date(strtrim(datiNazionali$data,10))

### dati regionali 
datiRegioni <- read.csv(fileNameReg)

datiRegioni$data <- strtrim(datiRegioni$data,10)
datiRegioni$data <- as.Date(strtrim(datiRegioni$data,10))

### merge trento and bolzano ####
temp = datiRegioni[datiRegioni$codice_regione == 4, c(1,7:17)]
temp = aggregate(temp[,-1], by = list(temp$data), sum)

levels(datiRegioni$denominazione_regione)[13] = 'Trentino - Alto Adige'
datiRegioni = datiRegioni[datiRegioni$denominazione_regione != "P.A. Bolzano",]
datiRegioni[datiRegioni$codice_regione == 4, 7:17] = temp[,-1]
datiRegioni$denominazione_regione = factor(datiRegioni$denominazione_regione)

### dati provinciali 
datiProvince <- read.csv(fileNameProv)

datiProvince$data <- strtrim(datiProvince$data,10)
datiProvince$data <- as.Date(strtrim(datiProvince$data,10))

save(datiRegioni, datiNazionali, datiProvince, file = paste(prefixDir, 'data/dati_', data, '.Rdata', sep = ''))


