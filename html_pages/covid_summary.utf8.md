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



## {.tabset}

### Nazionale 

:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Tamponi

preserve11e76bb27fe72484

La linea della serie lisciata è semplicemente una media mobile all'indietro con coefficienti costanti del numero di tamponi o, molto più semplicemente la media dei precedenti sette valori compreso quello del giorno stesso. In questo modo si cerca di togliere la componente periodica connessa al giorno della settimana ed estrapolare l'andamento della serie.


:::

:::{}

#### Nuovi positivi e testati
preserveddd587602665fa7a

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

:::{}

#### Nuovi individui testati e positivi
preserve5c29397fca972b49

Nel grafico la linea liscia è il risultato di uno smoothing del grafico fatto con il metodo LOESS (locally estimated scatterplot smoothing). In questo modo si cerca di _estrarre_ la componente regolare dello scatterplot.

:::

::: {}

#### Positivi

preserve83e22b686fb58b1c

I nuovi infetti sono il numero di casi che sono stati osservati in un giorno, mentre il saldo positivi ($saldo_i$) del giorno $i$ è dato da
\[
saldo_{i} = positivi_{i-1} + nuoviCasi_{i} - guariti_{i} - decessi_{i}.
\]

:::

:::{}

#### Decomposizione positivi totali

preservea0d93bc0b6f384f8

:::

:::{}


#### Decessi e guariti

preserve92d4f20def844752
::: 

::::

### Regionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}


::: {}
#### Totale casi

preserve1dca906169dde6df



:::

:::{}
#### Numero casi giornaliero
preserveb7ae686d8749c936


:::

:::{}

#### Variazione positivi giornaliero
preserve76245ce12f783228


:::

::: {}

#### Numero di casi rispetto alla popolazione

preserve14e6cb565fc9f25a

:::

:::{}

#### Numero di positivi rispetto alla popolazione

preserve5c6f08c07368625b

:::

:::{}


#### Decessi rispetto al numero di casi

preserved746bf16a21c744a

:::

:::{}
#### Tamponi per regione

preservec41701704ba279f7
:::
::::

### Situazione internazionale



:::: {style="display: grid; grid-template-columns: 1fr 1fr; grid-column-gap: 10px; grid-auto-flow: row"}

::: {}
#### Paesi maggiormente colpiti
preserve0118c6cb97f5dae6
:::

::: {}
#### Paesi maggiormente colpiti (per abitante)
preservec8182334f3a62240
Numero di casi per 100 abitanti nei paesi con il maggior numero assoluto di ammalati.
:::

::: {}
#### Numero di casi per 1000 abitanti
preserve7ce2a4786f30e86d
Numero di casi per 100 abitanti nei paesi con il maggior numero di ammalati ogni 1000 abitanti, in questo caso c'è una preponderanza di paesi piccoli.

:::

::: {}
#### Numero di nuovi casi giornaliero
preserve6e0fcad6d5553101
:::



::: {}
#### Numero di decessi rispetto alla popolazione
preservef9e815c886df637e

:::

::: {}

#### Numero di decessi rispetto al numero di casi
preservececdc4adc5b60bd3
:::

:::{}
#### Diffusione in Europa per numero di decessi

preserve4b85f1ccd630cae3

:::

:::{}
#### Diffusione in Europa per numero di casi
preserveb094b890315d6b45
:::



::::
