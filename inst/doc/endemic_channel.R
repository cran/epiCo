## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo = FALSE, out.width = '100%', fig.cap='Example of an endemic channel figure with the Safety, Warning, and Epidemic bands.'----
knitr::include_graphics(
  path = file.path("..", "man", "figures", "endemic_channel_figure.png"),
  error = FALSE
)

## -----------------------------------------------------------------------------
library(epiCo)
library(incidence)

data("epi_data")
data_event <- epi_data

data_ibague <- data_event[data_event$cod_mun_o == 73001, ]

## Building the historic incidence data

incidence_historic <- incidence(data_ibague$fec_not,
  interval = "1 epiweek"
)

knitr::kable(incidence_historic[1:5, ])

## ----fig.cap="Dengue endemic channel for Ibagué in 2021"----------------------
observations <- sample(5:40, 52, replace = TRUE)

outlier_years <- c(2016, 2019)

ibague_endemic_chanel <- endemic_channel(
  incidence_historic = incidence_historic,
  observations = observations,
  method = "geometric",
  outlier_years = outlier_years,
  plot = TRUE
)

