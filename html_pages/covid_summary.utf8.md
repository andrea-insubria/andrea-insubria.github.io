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

preserve67a9fe989ee920bc

La linea della serie lisciata è semplicemente una media mobile all'indietro con coefficienti costanti del numero di tamponi o, molto più semplicemente la media dei precedenti sette valori compreso quello del giorno stesso. In questo modo si cerca di togliere la componente periodica connessa al giorno della settimana ed estrapolare l'andamento della serie.


:::

:::{}

#### Nuovi positivi e testati
preserve2bedc702c715b180

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

:::{}

#### Nuovi individui testati e positivi
preservee727e23fcb598f1c

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

::: {}

#### Positivi

preservedd705fd3c914cc00

I nuovi infetti sono il numero di casi che sono stati osservati in un giorno, mentre il saldo positivi ($saldo_i$) del giorno $i$ è dato da
\[
saldo_{i} = positivi_{i-1} + nuoviCasi_{i} - guariti_{i} - decessi_{i}.
\]

:::

:::{}

#### Decomposizione positivi totali

preserve5da0125d60d16134

:::

:::{}


#### Decessi e guariti

preserve8551c2f8d91d0266
::: 

::::

### Regionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Totale positivi

preserve3726b165f2f86658



:::

:::{}
#### Numero casi giornaliero
preserve938a81a7a7a798ce


:::

:::{}

#### Variazione positivi giornaliero
preserve7135c4c9069ae663


:::

::: {}

#### Numero di casi rispetto alla popolazione

preservee19b92bdecbb9281

:::

:::{}

#### Numero di positivi rispetto alla popolazione

preserve725e587cb7bfdf43

:::

:::{}


#### Decessi rispetto al numero di casi

preserve023d02534703e13e

:::

:::{}
#### Tamponi per regione

preservec7699309c6e36701
:::
::::

### Situazione internazionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}

::: {}
#### Paesi maggiormente colpiti
preserve50fa8484221af177
:::

::: {}
#### Paesi maggiormente colpiti (per abitante)
preserved87db7b12239760e
Numero di casi per 100 abitanti nei paesi con il maggior numero assoluto di ammalati.
:::

::: {}
#### Numero di casi per 1000 abitanti
preserveb8dd15dab92a8f10
Numero di casi per 100 abitanti nei paesi con il maggior numero di ammalati ogni 1000 abitanti, in questo caso c'è una preponderanza di paesi piccoli.

:::

::: {}
#### Numero di nuovi casi giornaliero
preserve8689132d9bf9ab27
:::



::: {}
#### Numero di decessi rispetto alla popolazione
preservec7ed7cf1a1cfed21

:::

::: {}

#### Numero di decessi rispetto al numero di casi
preserve0ea6435ca6feef36
:::

:::{}
#### Diffusione in Europa per numero di decessi

preservee862c888aa48d9d7

:::

:::{}
#### Diffusione in Europa per numero di casi
preserved09610fceb5a18a0
:::



::::
