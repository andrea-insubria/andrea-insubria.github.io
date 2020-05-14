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

preserveb477f803f90cb647

La linea della serie lisciata è semplicemente una media mobile all'indietro con coefficienti costanti del numero di tamponi o, molto più semplicemente la media dei precedenti sette valori compreso quello del giorno stesso. In questo modo si cerca di togliere la componente periodica connessa al giorno della settimana ed estrapolare l'andamento della serie.


:::

:::{}

#### Nuovi positivi e testati
preserveba8245b610e9af6c

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

:::{}

#### Nuovi individui testati e positivi
preserve280cb8ce37a463b9

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

::: {}

#### Positivi

preserve9bdf0f9366f6e01c

I nuovi infetti sono il numero di casi che sono stati osservati in un giorno, mentre il saldo positivi ($saldo_i$) del giorno $i$ è dato da
\[
saldo_{i} = positivi_{i-1} + nuoviCasi_{i} - guariti_{i} - decessi_{i}.
\]

:::

:::{}

#### Decomposizione positivi totali

preserve83d0f227e8550dd6

:::

:::{}


#### Decessi e guariti

preservea8461e75fa86be8a
::: 

::::

### Regionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Totale positivi

preserve14198326b87889e1



:::

:::{}
#### Numero casi giornaliero
preserve0efdc562b3ca3e51


:::

:::{}

#### Variazione positivi giornaliero
preserve28a1e0f9fe37e120


:::

::: {}

#### Numero di casi rispetto alla popolazione

preserve64730ebc9f3f5fa1

:::

:::{}

#### Numero di positivi rispetto alla popolazione

preserve4b0312686e04f3cb

:::

:::{}


#### Decessi rispetto al numero di casi

preserve7807c7852834e564

:::

:::{}
#### Tamponi per regione

preserveeab9a563e32268cc
:::
::::

### Situazione internazionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}

::: {}
#### Paesi maggiormente colpiti
preserve410503c7d43da8c3
:::

::: {}
#### Paesi maggiormente colpiti (per abitante)
preserve8e569a98bb75ca56
Numero di casi per 100 abitanti nei paesi con il maggior numero assoluto di ammalati.
:::

::: {}
#### Numero di casi per 1000 abitanti
preserve2ad4ef141ae91713
Numero di casi per 100 abitanti nei paesi con il maggior numero di ammalati ogni 1000 abitanti, in questo caso c'è una preponderanza di paesi piccoli.

:::

::: {}
#### Numero di nuovi casi giornaliero
preservec02c2019d784c48c
:::



::: {}
#### Numero di decessi rispetto alla popolazione
preservef8d1dc83fc77b2b1

:::

::: {}

#### Numero di decessi rispetto al numero di casi
preserveaaf281b704e71554
:::

:::{}
#### Diffusione in Europa per numero di decessi

preserve23783b9f5926ce05

:::

:::{}
#### Diffusione in Europa per numero di casi
preserve689b72120740e92c
:::



::::
