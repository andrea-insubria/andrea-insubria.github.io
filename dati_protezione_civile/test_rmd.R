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
library(lubridate)

directory = '~/Documents/lavotex/lavori/covid_19/covid_19_RFiles/dati_protezione_civile/'
oggi = gsub('-', '_', today())

temp = tail(sort(dir('~/Documents/lavotex/lavori/covid_19/covid_19_RFiles/dati_protezione_civile/data/', 'Rdata', full.names = TRUE)),1) ## file da caricare
load(temp)


###############################################################
###                                                       #####
###       RAPPRESENTAZIONE DATI A LIVELLO REGIONALE       #####
###                                                       #####
###############################################################

## plot dati a livello regionale: totale positivi ####
## grafici ggplot ####
p = ggplot(data = datiRegioni)
p <- p + geom_line(aes(x = data, y = totale_positivi, group = denominazione_regione), size = 0.5, show.legend = FALSE) +
  geom_line(aes(x = data, y = deceduti, group = denominazione_regione), colour = I('red'), size = 0.5, show.legend = FALSE) +
  geom_line(aes(x = data, y = tamponi, group= denominazione_regione), colour = I('lightblue'), size = 0.5, show.legend = FALSE)
p <- p + labs(x = 'Data', y = 'Totale positivi', color = 'Legenda') +
    facet_wrap(~ datiRegioni$denominazione_regione, nrow = 5)

pLyRegionsTotal = ggplotly(p)

print(pLyRegionsTotal)
# 
# ## plot_ly version ####
# f1 <- list(family = "Arial, sans-serif",
#            size = 18,
#            color = "lightgrey" )
# f2 <- list( family = "Old Standard TT, serif",
#             size = 14,
#             color = "black" )
# 
# xAxis <- list( title = "Data", titlefont = f1, showticklabels = TRUE, tickangle = 45)
# yAxis <- list( title = 'Numero totale di positivi', titlefont = f1)
# 
# fig <- plot_ly(datiRegioni, x = ~data, y = ~totale_positivi) %>% 
#   add_lines(color = ~ordered(denominazione_regione))
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
# ###############################################################
# ###                                                       #####
# ###       RAPPRESENTAZIONE DATI A LIVELLO NAZIONALE       #####
# ###                                                       #####
# ###############################################################
# 
# plot(datiNazionali$data, datiNazionali$nuovi_positivi, xlab = 'Data', ylab = 'Nuovi positivi', main = 'Andamento nuovi casi positivi', pch = 20)
# 
# ## plot of new cases Italia ####
# pNaz = ggplot(data = datiNazionali, aes(x = data))
# pNaz = pNaz + geom_point(aes(y = nuovi_positivi, col = nuovi_positivi)) + labs(title = 'Andamento nuovi casi', subtitle = '(Livello nazionale)', x = 'Data', y = 'Nuovi positivi', col = 'Nuovi casi')
# pNaz = pNaz + theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5)) 
# 
# plyNaz = ggplotly(pNaz)
# 
# ## plotly graph national data ####
# ## nuovi casi
# ## setting axis
# axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Data', mirror = 'all', tickangle = 45) 
# axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Nuovi casi positivi', mirror = 'all') 
# 
# plyNazNuovi = plot_ly(data = datiNazionali, x = ~data, y = ~nuovi_positivi, type = 'scatter', mode = 'line') %>% 
# layout(title = 'Nuovi casi a livello nazionale', xaxis = axis_x, yaxis = axis_y, xaxis = axis_x) 
# 
# ## andamento ToTALE Cai a livello nazionale ####
# ## 
# axis_x <- list(showgrid = T, zeroline = F, nticks = 20, showline = T, title = 'Data', mirror = 'all', tickangle = 45) 
# axis_y <- list(showgrid = T, zeroline = F, nticks = 10, showline = T, title = 'Casi positivi totale', mirror = 'all') 
# 
# plyNazTot = plot_ly(data = datiNazionali, x = ~data) %>%
#   add_lines(y = ~totale_positivi, name = 'Totale positivi', hovertemplate = paste('<b>Tot. pos.</b>: %%{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
#   add_lines(y = ~ricoverati_con_sintomi, name = 'Ricoverati', hovertemplate = paste('<b>Ricoverati</b>: %%{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
#   add_lines(y = ~terapia_intensiva, name = "Terapia intensiva", hovertemplate = paste('<b>Intensivi</b>: %%{y}', '<br><b>Giorno</b>: %{x}<br>')) %>% 
#   layout(title = 'Casi totali a livello nazionale', xaxis = axis_x, yaxis = axis_y, xaxis = axis_x, legend = list(x = 100, y = 0.5)) 
# 
# plyNazTot
# 
# 
# ## plot tamponi e positivi  ####
# tempData = t(as.matrix(datiNazionali[,c(3:4, 6)]))
# barplot(tempData, beside = FALSE, legend.text = names(datiNazionali)[c(3:4, 6)], args.legend = list(bty = 'n', x = 'topleft', inset = .05))
# 
# par(bg = 'gray95')
# plot(datiNazionali$data, datiNazionali$tamponi, type = 'l', xlab = 'Data', ylab = 'Numerosità', lwd = 1.5)
# lines(datiNazionali$data, datiNazionali$totale_positivi, type = 'h', lwd = 5, col = 'darkgray')
# grid(nx = 10, ny = 15, col = 'slategray')
# legend('topleft', inset = .05, col = c(1, 'darkgray'), lwd = c(1,3), legend = c('Numero tamponi', 'Tamponi positivi'), bty = 'white')
# 
# 
# ## plot tamponi positivi su totale casi e nuovi casi diagnosticati #### 
# propPositivi =  datiNazionali$totale_positivi / datiNazionali$tamponi * 100
# par(mar = c(5, 4, 4, 4) + 0.3)
# 
# plot(datiNazionali$data, propPositivi, type = 'l', col = 'darkgray', lwd = 2, xlab = 'Data', ylab = 'Proporzione tamponi positivi (%)')
# grid(nx = 10, ny = 15, col = 'gray')
# 
# op <- par(new = TRUE)
# plot(datiNazionali$data, datiNazionali$nuovi_positivi, type = 'h', col = 'darkblue', lwd = 7, axes = FALSE, xlab = '', ylab = '')
# axis(side = 4, at = pretty(datiNazionali$nuovi_positivi), col = 'darkblue')
# mtext("Nuovi casi diagnosticati", side = 4, col = "darkblue", line = 2)
# par(op)
# 
# ## ggplot2 version 
# datiNazionali$propPositivi =  datiNazionali$totale_positivi / datiNazionali$tamponi * 100
# rescaleCoeff = (max(datiNazionali$nuovi_positivi))
# pTamp = ggplot(data = datiNazionali, aes(x = data)) + geom_line(aes(y = propPositivi))
# pTamp = pTamp + geom_bar(aes(y = nuovi_positivi/rescaleCoeff*16), stat = 'identity', fill = 'darkblue') + scale_x_date(name = "Data", labels = NULL) 
# pTamp = pTamp + scale_y_continuous(name = "Proporzione tamponi positivi (%)",  sec.axis = sec_axis(~.*rescaleCoeff/16, name = "Nuovi casi diagnositicati",  labels = function(b) {format(b, scientific = FALSE)}))
# 
# ggplotly(pTamp)
# gg <- highlight(ggplotly(pTamp), "plotly_selected")
# # crosstalk::bscols(gg, DT::datatable(datiNazionali))
# 
# ## plotly version of the graph ####
# ## set multiple axis, see https://plotly.com/r/multiple-axes/
# ## for hover and text, see https://plotly.com/r/hover-text-and-formatting/
# xAxis <-  list(nticks = 20, title = 'Data', tickangle = 45) 
# yAxisPerc <- list(showgrid = T, zeroline = F, title = 'Proporzione tamponi positivi') 
# yAxisNuoviCasi <- list(nticks = 10, overlaying = 'y', side = 'right', tickfont = list(color = "darkorange"),
#   title = 'Nuovi casi')
# 
# plyTamponi <- plot_ly() 
# plyTamponi <- plyTamponi %>% 
#   add_lines(data = datiNazionali, x = ~data, y = ~propPositivi, name = '', hovertemplate = paste('<b>Proporzione</b>: %%{y:.2f}', '<br><b>Giorno</b>: %{x}<br>'), showlegend = FALSE) %>% 
#   add_bars(data = datiNazionali, x = ~data, y = ~nuovi_positivi, name = '', yaxis = "y2", hovertemplate = paste('<b>Positivi</b>: %{y}', '<br><b>Giorno</b>: %{x}<br>'), showlegend = FALSE )
# 
# plyTamponi <- plyTamponi %>% layout(
#   title = 'Casi totali a livello nazionale', yaxis = yAxisPerc, yaxis2 = yAxisNuoviCasi,   xaxis = xAxis) 
# plyTamponi
# 
# 
# 
# 
# ## barplot ####
# tempData = sweep(tempData, 2, colSums(tempData), '/')
# barplot(tempData, beside = FALSE, legend.text = names(datiNazionali)[c(3:4, 6)], args.legend = list(bty = 'n', x = 43, y = -0.1, horiz = TRUE), axes = F, space = .2)
# axis(side = 2, pos = -0.2)
# # add x-axis with offset positions, with ticks, but without labels.
# at_tick <- seq_len(ncol(tempData))* 1.2
# axis(side = 1, at = at_tick - 1/2, labels = datiNazionali$data, )
# title(main = 'Ripartizione malati di corona-Virus')
# 
# 
# barplotGgplot = expand.grid(rownames(tempData), unique(datiNazionali$data))
# barplotGgplot = data.frame(barplotGgplot, array(tempData))
# names(barplotGgplot) = c('tipo', 'data', 'freq')
# barplotGgplot$labelPos = array(t(aggregate(barplotGgplot$freq, by = list(barplotGgplot$data), cumsum)[,2]))
# 
# barplotNazionale = ggplot(data = barplotGgplot, aes(x = data, y = freq * 100, fill = tipo)) +
#   geom_bar(stat="identity") + scale_x_date(name = "Data", labels = NULL) +
#   # # geom_text(aes(y = labelPos, label = round(freq*100) ), vjust=1.6, 
#   #           color="red", size=3.5)+
#   scale_y_continuous(name = 'Proporzione malati per tipo (%)')+
#   scale_fill_brewer(palette="Paired")+
#   theme_minimal()
# barplotNazionale
# 
# ggplotly(barplotNazionale)
# 
# p = ggplot(data = datiRegioni, aes(x = data, y = totale_positivi, group= denominazione_regione))
# p <- p + geom_line(aes(linetype = denominazione_regione, color = denominazione_regione), size = 0.8)  + labs(x = 'Data', y = 'Totale positivi')
# p <- ggplotly(p)
# 
# 
# 
# 
# 
# 
# 
# ## import regions, provinces  ####
# # this import shapefile in spatialpolygondataframe
# itaShape = readOGR('../COVID-19-master/aree/geojson/dpc-covid19-ita-aree.geojson')
# 
# # download cincinnati map from OSM ####
# llCRS <- CRS("+proj=longlat +datum=WGS84") ## CRS standard
# bbox = itaShape@bbox
# 
# italy <- osm.raster(bbox, proj = llCRS, crop=TRUE)  ## cincinnati map from openstreetmap
# italy <- osm.raster(bbox, zoomin = -1, proj = llCRS, crop=TRUE)  ## cincinnati map from openstreetmap
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# dir('../COVID-19-master/dati-regioni/')
# 
# 
# dati$data <- as.Date(strtrim(dati$data,10))
# dati$codice_regione <- as.factor(dati$codice_regione)
# 







