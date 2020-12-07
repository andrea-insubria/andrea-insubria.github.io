rm(list = ls())

## load packages ####
require(spdep)
require(rgdal)
require(maps)
library(maptools)
require(rosm)
require(lubridate)
library(raster)
library(prettymapr)
require(ggplot2)
library(plotly)
library(tidyverse)
require(sf)


prefixDir = '~/Documents/lavotex/lavori/covid_19/websites/hugo_universal/static/dati_protezione_civile'

temp = tail(sort(dir(paste(prefixDir,'/data/', sep = ''), 'Rdata', full.names = TRUE)),1) ## file da caricare
oggi = gsub('_', '-', substr(temp, nchar(temp)-15, nchar(temp)-6))

if ((as.Date(oggi)<today()) & (as.numeric(format(Sys.time(), '%H')) >= 16) ){
source('~/Documents/lavotex/lavori/covid_19/websites/hugo_universal/static/dati_protezione_civile/importazione_dati.R')
}


load(temp)
italyShpRegions <- st_read(paste(prefixDir,'/italy_shape/regioni/Reg01012020_g_WGS84.shp', sep = ''))
# 



## functions #####
changeRate <- function(y){
  c(NA, diff(y) / head(y, -1) * 100)
}


###############################################################
###                                                       #####
###       RAPPRESENTAZIONE DATI A LIVELLO NAZIONALE       #####
###                                                       #####
###############################################################

datiNazionali$nuovi_tamponi = c(datiNazionali$tamponi[1], diff(datiNazionali$tamponi))


## setting fonts for plotly plots ####
f1 <- list(family = "Arial, sans-serif",
           size = 18,
           color = "lightgrey" )
f2 <- list( family = "Old Standard TT, serif",
            size = 14,
            color = "black" )


## plotly graph national data ####
## nuovi casi e variazione positivi
## setting axis
axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Data', mirror = 'all', tickangle = 45, titlefont = f1) 
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Numero di casi', mirror = 'all', titlefont = f1) 

plyNazNuovi = plot_ly(data = datiNazionali, x = ~data, y = ~nuovi_positivi, type = 'scatter', mode = 'line', hovertemplate = paste('<b>Nuovi positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>'), name = 'Nuovi infetti') %>% 
  add_lines(x = ~data, y = ~nuovi_tamponi, name = 'Tamponi', hovertemplate = paste('<b>Tamponi quotidiani</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
  add_lines(x = ~data, y = ~variazione_totale_positivi, name = 'Variazione positivi', hovertemplate = paste('<b>Var. pos.</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
  layout(xaxis = axis_x, yaxis = axis_y, xaxis = axis_x, legend = list(x = .05, y = .95)) 
plyNazNuovi


## andamento ToTALE Cai a livello nazionale ####
##
axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Data', mirror = 'all', tickangle = 45)
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Casi positivi totale', mirror = 'all')

plyNazTot = plot_ly(data = datiNazionali, x = ~data) %>%
  add_lines(y = ~totale_positivi, name = 'Totale positivi', hovertemplate = paste('<b>Tot. pos.</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~totale_casi, name = 'Totale casi', hovertemplate = paste('<b>Tot. casi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~ricoverati_con_sintomi, name = 'Ricoverati', hovertemplate = paste('<b>Ricoverati</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~terapia_intensiva, name = "Terapia intensiva", hovertemplate = paste('<b>Intensivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~dimessi_guariti, name = "Dimessi", hovertemplate = paste('<b>Dimessi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~isolamento_domiciliare, name = "Isolamento", hovertemplate = paste('<b>Isolamento</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~deceduti, name = "Deceduti", hovertemplate = paste('<b>Deceduti</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_lines(y = ~tamponi, name = "Tamponi", hovertemplate = paste('<b>Tamponi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  layout(title = 'Casi totali a livello nazionale', xaxis = axis_x, yaxis = axis_y, legend = list(x = 0.1, y = 0.95))

# plyNazTot
# 
# 
# ## plot tamponi e positivi  ####
plyDecPos = plot_ly(data = datiNazionali, x = ~data) %>%
  add_bars(y = ~ricoverati_con_sintomi, name = "Ricoverati", hovertemplate = paste('<b>Ricoverati</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_bars(y = ~isolamento_domiciliare, name = 'Isolamento', hovertemplate = paste('<b>Isolamento</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
    add_bars(y = ~terapia_intensiva, name = 'Intensiva', hovertemplate = paste('<b>Intensiva</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% layout(title = 'Decomposizione positivi totali', yaxis = list(title = 'Numerosità'), barmode = 'stack')

## plotly version of the graph ####
## set multiple axis, see https://plotly.com/r/multiple-axes/
## for hover and text, see https://plotly.com/r/hover-text-and-formatting/
propPositivi =  datiNazionali$totale_positivi / datiNazionali$tamponi * 100

xAxis <-  list(nticks = 20, title = 'Data', tickangle = 45, titlefont = f1)
yAxis <-  list(nticks = 20, title = 'Numerosità', tickangle = 45, titlefont = f1)
yAxisPerc <- list(showgrid = T, zeroline = F, title = 'Proporzione tamponi positivi', titlefont = f1)
yAxisNuoviCasi <- list(nticks = 10, overlaying = 'y', side = 'right', tickfont = list(color = "darkorange"), title = 'Nuovi casi', titlefont = f1)

plyTamponi <- plot_ly() %>%
  add_lines(data = datiNazionali, x = ~data, y = ~propPositivi, name = '', hovertemplate = paste('<b>Proporzione</b>: %%{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), showlegend = FALSE) %>%
  add_bars(data = datiNazionali, x = ~data, y = ~nuovi_positivi, name = '', yaxis = "y2", hovertemplate = paste('<b>Positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>'), showlegend = FALSE ) %>%
 layout(yaxis = yAxisPerc, yaxis2 = yAxisNuoviCasi,   xaxis = xAxis)
plyTamponi


## nuovi positivi vs tamponi
axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Tamponi', mirror = 'all', tickangle = 45, titlefont = f1)
axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Nuovi casi positivi', mirror = 'all', titlefont = f1)

polyEstimate = loess(data = datiNazionali, nuovi_positivi ~ nuovi_tamponi)
newData = seq(0, 52000, length.out = 200)
previsione = predict(polyEstimate, data.frame(nuovi_tamponi = newData))

markerPers = list(color = ~as.double(data),
                  colorscale = 'Viridis',
                  colorbar = list(
                    title = 'Data',
                    tickvals = round(quantile(as.double(datiNazionali$data), seq(0,.75, by = .25))),
                    ticktext = datiNazionali$data[as.numeric(datiNazionali$data) %in% round(quantile(as.double(datiNazionali$data), seq(0,.75, by = .25)))],
                    tickmode = 'array'
                  )
)


plyTampCases = plot_ly(data = datiNazionali, x = ~nuovi_tamponi, y = ~nuovi_positivi,  type = 'scatter', mode = 'markers', marker = markerPers,  hovertemplate = paste('<b>Num. positivi</b>: %{y}', '<br><b>Tamponi</b>: %{x}<br>'), name = '') %>%
  add_lines(x = ~newData, y = ~previsione, type = 'scatter', mode = 'lines+markers', showlegend = FALSE) %>%
layout(xaxis = axis_x, yaxis = axis_y)
plyTampCases

plyTampCases = plot_ly(data = datiNazionali, x = ~newData, y = ~previsione, type = 'scatter', mode = 'lines', showlegend = FALSE, color = I('orange')) %>%
   add_trace(x = ~nuovi_tamponi, y = ~nuovi_positivi,  type = 'scatter', mode = 'markers', marker = markerPers,  hovertemplate = paste('<b>Num. positivi</b>: %{y}', '<br><b>Tamponi</b>: %{x}<br>'), name = '') %>% 
  layout(xaxis = axis_x, yaxis = axis_y)
plyTampCases


## barplot ####
tempData = datiNazionali[, c('ricoverati_con_sintomi', 'isolamento_domiciliare', 'terapia_intensiva')]
tempData = as.data.frame(sweep(tempData, 1, rowSums(tempData), '/') * 100)
tempData = cbind(data = datiNazionali$data, tempData)

yAxisPerc <- list(showgrid = T, zeroline = F, title = 'Proporzione classi (%)')

plyDecPerc= plot_ly(data = tempData, x = ~data) %>%
  add_bars(y = ~ricoverati_con_sintomi, name = "Ricoverati", hovertemplate = paste('<b>Ricoverati</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
  add_bars(y = ~isolamento_domiciliare, name = 'Isolamento', hovertemplate = paste('<b>Isolamento</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
    add_bars(y = ~terapia_intensiva, name = 'Intensiva', hovertemplate = paste('<b>Intensiva</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% layout(title = 'Ripartizione in percentuale', yaxis = list(title = 'Numerosità'), barmode = 'stack') %>%
 layout(yaxis = yAxisPerc, xaxis = xAxis)
# plyDecPerc
# 

plyDecTrend <- plot_ly(data = datiNazionali, x = ~data) %>% 
  add_lines(y = ~ricoverati_con_sintomi, name ='Ricoverati', hovertemplate = paste('<b>Ricoverati</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
  add_lines(y = ~isolamento_domiciliare, name = 'Isolamento', hovertemplate = paste('<b>Isolamento</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
  add_lines(y = ~terapia_intensiva, name = 'Intensiva', hovertemplate = paste('<b>Intensiva</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
  layout(yaxis = yAxis, xaxis = xAxis)
plyDecTrend

## tassi di variazione ####
variabili = names(datiNazionali[,3:13])
variabili = variabili[-(6:7)]

tempData = datiNazionali[,variabili]
deltaTempData = sapply(tempData, diff)
varTempData = deltaTempData / tempData[-nrow(tempData),] * 100
# names(varTempData) = paste('delta_', names(varTempData), sep = '')

datiNazionaliDelta = cbind(datiNazionali[-1,1:2],varTempData)

xAxis <-  list(nticks = 20, title = 'Data', tickangle = 45)
yAxis <- list(showgrid = T, zeroline = F, title = 'Varizioni percentuali')

plyDelta = plot_ly(data = datiNazionaliDelta, x = ~data) %>%
  add_lines(y = ~totale_positivi, name = 'Positivi', hovertemplate = paste('<b>Positivi </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(y = ~totale_casi, name = 'Infetti', hovertemplate = paste('<b>Infetti </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
add_lines(y = ~terapia_intensiva, name = 'Intensivi', hovertemplate = paste('<b>Intensivi </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(y = ~ricoverati_con_sintomi, name = 'Ricoverati', hovertemplate = paste('<b>Ricoverati </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(y = ~isolamento_domiciliare, name = 'Domiciliare', hovertemplate = paste('<b>Domiciliare </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(x = ~data[-(1:5)], y = ~dimessi_guariti[-(1:5)], name = 'Dimessi', hovertemplate = paste('<b>Dimessi</b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(y = ~deceduti, name = 'Deceduti', hovertemplate = paste('<b>Deceduti </b>: %{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  add_lines(y = ~tamponi, name = 'Tamponi', hovertemplate = paste('<b>Tamponi </b>: %{y:.2f}%', '<br><b>Giorno</b>: %{x}<br>'), line = list(shape = "spline")) %>%
  layout(yaxis = yAxis, xaxis = xAxis)
plyDelta




# p = ggplot(data = datiRegioni, aes(x = data, y = totale_positivi, group= denominazione_regione))
# p <- p + geom_line(aes(linetype = denominazione_regione, color = denominazione_regione), size = 0.8)  + labs(x = 'Data', y = 'Totale positivi')
# p <- ggplotly(p)

# ###############################################################
# ###                                                       #####
# ###       RAPPRESENTAZIONE DATI A LIVELLO REGIONALE       #####
# ###                                                       #####
# ###############################################################
# 
# ## plot dati a livello regionale: totale positivi ####
# ## grafici ggplot ####
# p = ggplot(data = datiRegioni)
# p <- p + geom_line(aes(x = data, y = totale_positivi, group = denominazione_regione), size = 0.5, show.legend = FALSE) +
#   geom_line(aes(x = data, y = deceduti, group = denominazione_regione), colour = I('red'), size = 0.5, show.legend = FALSE) +
#   geom_line(aes(x = data, y = tamponi, group= denominazione_regione), colour = I('lightblue'), size = 0.5, show.legend = FALSE) 
# p <- p + labs(x = 'Data', y = 'Totale positivi', color = 'Legenda') + 
#     facet_wrap(~ datiRegioni$denominazione_regione, nrow = 5)
# 
## plotly ####

datiRegioniToday = datiRegioni[datiRegioni$data == oggi,]
datiRegioniToday = merge(italyShpRegions, datiRegioniToday, by.x = 'COD_REG', by.y = "codice_regione")

plyCasi = subplot(
  plot_ly(datiRegioniToday, split = ~DEN_REG, color = ~totale_positivi, type = 'scatter', mode = 'lines', line = list(width = .1), text = ~paste('<b>', DEN_REG, '<b>','\n<b>Positivi </b>:', totale_positivi), hoveron = 'fills', hoverinfo = 'text') %>%
  layout(legend = list(x = -0, y = .9,  title = list(text = 'Regione')), showlegend = FALSE) %>%
  colorbar(title = 'Totale \npositivi', x = 1, y = .85),
  plot_ly(datiRegioniToday, split = ~DEN_REG, color = ~totale_casi, type = 'scatter', mode = 'lines', line = list(width = .1), text = ~paste('<b>', DEN_REG, '<b>','\n<b>casi </b>:', totale_casi), hoveron = 'fills', hoverinfo = 'text') %>%
    layout(legend = list(x = -0, y = .9,  title = list(text = 'Regione')), showlegend = FALSE) %>%
    colorbar(title = 'Totale \ncasi', x = .45, y = .85)
)
# plyCasi

# ## set colors
# library(RColorBrewer)
# paletta = viridis::viridis(20)
# paletta = colorRampPalette(paletta)(20)
# paletta = brewer.pal(16, "OrRd")
# 
# plot(datiRegioniToday[,c('totale_positivi', 'totale_casi')], lwd = .15, main = 'Totale positivi', nbreaks = 20, pal = paletta)
# 
# ggPositivi = ggplot(datiRegioniToday) +
#   geom_sf(aes(fill = totale_positivi))
# 
# plyPositivi = ggplotly(ggPositivi) %>% 
#   layout(hovertemplate = paste('<b>Positivi </b>: %{z}'))
# 
# plyPositivi = plot_ly(datiRegioniToday) 
# 
# 
# op = par(mfrow = c(2,2))
# plot(datiRegioniToday[,'totale_positivi'], lwd = .1, main = 'Totale positivi', nbreaks = 7, pal = paletta)
# plot(datiRegioniToday[,'totale_positivi'], lwd = .15, ,main = 'Totale positivi', nbreaks = 20, pal = paletta)
# plot(datiRegioniToday[,'totale_casi'], lwd = .1, main = 'Totale positivi')
# par(op)
# 
# plot_mapbox(datiRegioniToday, color = ~totale_positivi)  
# layout(legend = list(x = -0, y = .9,  title = list(text = 'Regione')))
# 
# , split = ~DEN_REG, color = ~totale_positivi, type = 'scatter', mode = 'lines', line = list(width = .1), hovertemplate = paste('<b>Positivi </b>: %{color:colors}')
# 
# ## plot_ly version ####
# 
# xAxis <- list( title = "Data", titlefont = f1, showticklabels = TRUE, tickangle = 45)
# yAxis <- list( title = 'Numero totale di positivi', titlefont = f1)
# 
# fig <- plot_ly(datiRegioni, x = ~data, y = ~totale_positivi) %>% 
#   add_lines(color = ~ordered(denominazione_regione), hovertemplate = paste('<b>Positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>'))
# 
# plyRegTot <- fig %>% layout(xaxis = xAxis, yaxis = yAxis)
# plyRegTot
# 
# ## plot dati a livello regionale: nuovi casi ####
# yAxis <- list( title = 'Nuovi casi', titlefont = f1)
# 
# fig <- plot_ly(datiRegioni, x = ~data, y = ~nuovi_positivi) %>% 
#   add_lines(color = ~ordered(denominazione_regione))
# 
# plyRegNuovi <- fig %>% layout(xaxis = xAxis, yaxis = yAxis)
# plyRegNuovi
# 
# # versione con faceting
# # p = ggplot(data = datiRegioni)
# # p <- p + geom_line(aes(x = data, y = nuovi_positivi, group= denominazione_regione), size = 0.5, show.legend = FALSE)  + labs(x = 'Data', y = 'Nuovi positivi')
# # p <- p + facet_wrap(~ datiRegioni$denominazione_regione, nrow = 5)
# # 
# # pLyRegionsNew = ggplotly(p)
# 
# # ## import regions, provinces  ####
# # # this import shapefile in spatialpolygondataframe
# # itaShape = readOGR('../COVID-19-master/aree/geojson/dpc-covid19-ita-aree.geojson')
# # 
# # # download cincinnati map from OSM ####
# # llCRS <- CRS("+proj=longlat +datum=WGS84") ## CRS standard
# # bbox = itaShape@bbox
# # 
# # italy <- osm.raster(bbox, proj = llCRS, crop=TRUE)  ## cincinnati map from openstreetmap
# # italy <- osm.raster(bbox, zoomin = -1, proj = llCRS, crop=TRUE)  ## cincinnati map from openstreetmap
# # 
# # 
# # dir('../COVID-19-master/dati-regioni/')
# # 
# # 
# # dati$data <- as.Date(strtrim(dati$data,10))
# # dati$codice_regione <- as.factor(dati$codice_regione)
# 
# 
# ## Lombardia e Veneto ####
# lvData = subset(datiRegioni, datiRegioni$denominazione_regione %in% c('Lombardia', 'Emilia-Romagna', 'Veneto', 'Piemonte'))
# yAxis <- list( title = 'Numero totale di positivi', titlefont = f1)
# 
# plyLom <- plot_ly(data = lvData, x = ~data) %>%
#   add_lines(y = ~totale_positivi, color = ~ordered(denominazione_regione), hovertemplate = paste('<b>Positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
#   add_lines(x = ~datiNazionali$data, y = ~datiNazionali$totale_casi, name = 'Italia', hovertemplate = paste('<b>Positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>')) %>%
#   add_lines(x = ~datiNazionali$data, y = ~aggregate(lvData$totale_positivi, by = list(lvData$data), sum)[,2], hovertemplate = paste('<b>Positivi reg.</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>'), name = 'Tot. regioni') %>% 
#   layout(xaxis = xAxis, yaxis = yAxis)
# 
# plyLom
# 
# 
# fig <- plot_ly(data = lvData, x = ~data) %>% 
#   add_lines(, y = ~nuovi_positivi, color = ~ordered(denominazione_regione))
# 




































