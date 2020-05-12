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




[Torna indietro](/blog/)

## {.tabset}

### Nazionale 

:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Tamponi

preserveb5d7eb30909c669c

La linea della serie lisciata è semplicemente una media mobile all'indietro con coefficienti costanti del numero di tamponi o, molto più semplicemente la media dei precedenti sette valori compreso quello del giorno stesso. In questo modo si cerca di togliere la componente periodica connessa al giorno della settimana ed estrapolare l'andamento della serie.


:::

:::{}

#### Nuovi positivi e testati
preserve4ac757a0abc326ae

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

:::{}

#### Nuovi individui testati e positivi
preserve7d65845561576ed1

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

::: {}

#### Positivi

preserve6d2671ff351d141e

I nuovi infetti sono il numero di casi che sono stati osservati in un giorno, mentre il saldo positivi ($saldo_i$) del giorno $i$ è dato da
\[
saldo_{i} = positivi_{i-1} + nuoviCasi_{i} - guariti_{i} - decessi_{i}.
\]

:::

:::{}

#### Decomposizione positivi totali

preserve24e55fde1a5c38fd

:::

:::{}


#### Decessi e guariti

preservec9f3d8e9d8c22348
::: 

::::

### Regionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Totale casi

preservecd2cb48c35018357



:::

:::{}
#### Numero casi giornaliero
preserve1efabb9c2ef0f495


:::

:::{}

#### Variazione positivi giornaliero
preserve83bfb58ee37515b0


:::

::: {}

#### Numero di casi rispetto alla popolazione

preserve02d3f2768d3650ba

:::

:::{}

#### Numero di positivi rispetto alla popolazione

preserveff817835146f38e4

:::

:::{}


#### Decessi rispetto al numero di casi

preserve41eb979656a0ace0

:::

:::{}
#### Tamponi per regione

preserveed9008e1ee681580
:::
::::

### Situazione internazionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}

::: {}
#### Paesi maggiormente colpiti
preserve03be3b9473402c05
:::

::: {}
#### Paesi maggiormente colpiti (per abitante)
preservec39cc5186004fab3
Numero di casi per 100 abitanti nei paesi con il maggior numero assoluto di ammalati.
:::

::: {}
#### Numero di casi per 1000 abitanti
preserved10956aa0d1d686e
Numero di casi per 100 abitanti nei paesi con il maggior numero di ammalati ogni 1000 abitanti, in questo caso c'è una preponderanza di paesi piccoli.

:::

::: {}
#### Numero di nuovi casi giornaliero
preserve9808a4bc4c33fc8d
:::



::: {}
#### Numero di decessi rispetto alla popolazione
preservecb40a29fd5b1fe9f

:::

::: {}

#### Numero di decessi rispetto al numero di casi
preserve6671bdf962a8885d
:::

:::{}
#### Diffusione in Europa per numero di decessi

preservee468521677998ce5

:::

:::{}
#### Diffusione in Europa per numero di casi
preserve3f8a208228d810f5
:::



::::
