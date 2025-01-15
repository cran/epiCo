## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----messages = FALSE, eval = TRUE, fig.cap = "Neighbor municipalities of Cundinamarca with a 0.5-hour threshold."----
library(epiCo)
library(dplyr)
library(incidence)
data(divipola_table)
cundinamarca_data <- dplyr::filter(
  divipola_table,
  NOM_DPTO == "CUNDINAMARCA"
) %>%
  select(COD_MPIO, LATITUD, LONGITUD)

cundinamarca_neighborhood <- neighborhoods(
  query_vector = cundinamarca_data$COD_MPIO,
  threshold = 0.5
)$neighbours

plot(cundinamarca_neighborhood, cbind(
  cundinamarca_data$LATITUD,
  cundinamarca_data$LONGITUD
))

## ----messages = FALSE, eval = TRUE, fig.cap="Local Moran's index clusters for the incidence of Tolima municipalities in 2019."----
data("epi_data")

data_tolima <- epi_data[lubridate::year(epi_data$fec_not) == 2019, ]
incidence_object <- incidence(
  dates = data_tolima$fec_not,
  groups = data_tolima$cod_mun_o,
  interval = "12 months"
)

morans_tolima <- morans_index(
  incidence_object = incidence_object
)
morans_tolima$plot

