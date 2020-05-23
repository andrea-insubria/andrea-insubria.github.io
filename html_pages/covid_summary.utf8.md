---
banner: img/banners/covid.png
title: "Riassunto dei dati sul covid-19"
date: '2020-05-12'
output: html_document
tags:
- covid
slug: covid_riassunto
---

<style type="text/css">
.main-container {
  max-width: 1500px;
  margin-left: auto;
  margin-right: auto;
}
</style>




<a href="/blog/">Torna indietro</a>

## {.tabset}

### Nazionale 

:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Tamponi

preservef52a7d7bfa60c875

La linea della serie lisciata è semplicemente una media mobile all'indietro con coefficienti costanti del numero di tamponi o, molto più semplicemente la media dei precedenti sette valori compreso quello del giorno stesso. In questo modo si cerca di togliere la componente periodica connessa al giorno della settimana ed estrapolare l'andamento della serie.


:::

:::{}

#### Nuovi positivi e testati
preserve5eb01cf5cf6f9d12

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

:::{}

#### Nuovi individui testati e positivi
preserveb82df2958449b826

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

::: {}

#### Positivi

preserve2538ff01169a0691

I nuovi infetti sono il numero di casi che sono stati osservati in un giorno, mentre il saldo positivi ($saldo_i$) del giorno $i$ è dato da
\[
saldo_{i} = positivi_{i-1} + nuoviCasi_{i} - guariti_{i} - decessi_{i}.
\]

:::

:::{}

#### Decomposizione positivi totali

preservefef94f857eabc811

:::

:::{}


#### Decessi e guariti

preserve16c778179d344d0c
::: 

::::

### Regionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Totale positivi

preservee91a2dc694716713



:::

:::{}
#### Numero casi giornaliero
preserve82887802554f68dd


:::

:::{}

#### Variazione positivi giornaliero
preserve920718e33c5b00ca


:::

::: {}

#### Numero di casi rispetto alla popolazione

preserveaf99cc8f07fb0e8f

:::

:::{}

#### Numero di positivi rispetto alla popolazione

preserve5f3846abfc2f782d

:::

:::{}


#### Decessi

preservedc90af41eac929df

:::

:::{}


#### Decessi rispetto al numero di casi

preserve153da9a2ab236bd5

:::



:::{}
#### Casi testati per regione

preserve95c155a5a0232103
:::
::::

### Situazione internazionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}

::: {}
#### Paesi maggiormente colpiti (Casi totali)
preserve48d0b2122fcc2d77
In questo grafico è rappresentato l'andamento del numero totale di casi per 15 paesi che hanno avuto il maggior numero di casi in termini assoluti.
:::


::: {}
#### Paesi maggiormente colpiti (Casi per abitante)
preserve6c1b588832ec599e
Numero di casi per 1000 abitanti nei paesi con il maggior numero assoluto di ammalati.
:::

::: {}
#### Paesi maggiormente colpiti sulla base del numero di casi per 1000 abitanti
preserve7ba4ba5222c6236d
Numero di casi per 1000 abitanti nei paesi con il maggior numero di ammalati ogni 1000 abitanti, in questo caso c'è una preponderanza di paesi piccoli.

:::

::: {}
#### Numero di nuovi casi giornaliero
preserve433b23af16e7e7a6
:::



::: {}
#### Numero di decessi rispetto alla popolazione
preservebf969cc69df770e8

:::

::: {}

#### Numero di decessi rispetto al numero di casi
preservea10fa928d6d52c10
:::

:::{}
#### Diffusione in Europa per numero di decessi

preserve7449cf3329f59fc0

:::

:::{}
#### Diffusione in Europa per numero di casi
preserve8e3b49ea74266690
:::



::::
