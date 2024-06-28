## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(epiCo)
library(incidence)

data("divipola_table")

## -----------------------------------------------------------------------------
ibague_code <- "73001" # DIVIPOLA code for the city of Ibagu<U+00E9>
year <- 2016 # Year to consult
ibague_pyramid_2016 <- population_pyramid(ibague_code, year) # Population
# pyramid (dataframe) for the city of Ibagu<U+00E9> in the year 2019
# dissagregated by sex
knitr::kable(ibague_pyramid_2016[1:5, ])

## -----------------------------------------------------------------------------
ibague_code <- "73001" # DIVIPOLA code for the city of Ibagu<U+00E9>
year <- 2019 # Year to consult
age_range <- 5 # Age range or window
ibague_pyramid_2019 <- population_pyramid(ibague_code, year,
  range = age_range,
  sex = TRUE, total = TRUE,
  plot = TRUE, language = "EN"
)

## -----------------------------------------------------------------------------
demog_data <- data.frame(
  id = c(0001, 002, 003, 004, 005, 006, 007, 008),
  ethnicity_label = c(3, 4, 2, 3, 3, 3, 2, 3),
  occupation_label = c(6111, 3221, 5113, 5133, 6111, 23, 25, 99),
  sex = c("F", "M", "F", "F", "M", "M", "F", "M"),
  stringsAsFactors = FALSE
)


ethnicities <- describe_ethnicity(demog_data$ethnicity_label, language = "EN")
knitr::kable(ethnicities)

occupations <- describe_occupation(
  isco_codes = demog_data$occupation_label,
  sex = demog_data$sex,
  plot = "treemap"
)
knitr::kable(occupations$data)

## -----------------------------------------------------------------------------
data("epi_data")

data_tolima <- epi_data[lubridate::year(epi_data$fec_not) == 2019, ]
knitr::kable(data_tolima[1:5, 4:12])

## -----------------------------------------------------------------------------
incidence_object <- incidence(
  dates = data_tolima$fec_not,
  groups = data_tolima$cod_mun_o,
  interval = "1 epiweek"
)
incidence_rate_object <- incidence_rate(incidence_object, level = 2)
knitr::kable(incidence_rate_object$counts[1:5, 1:12])

## -----------------------------------------------------------------------------
data_ibague <- data_tolima[data_tolima$cod_mun_o == 73001, ]

age_risk_data <- age_risk(
  age = as.integer(data_ibague$edad),
  population_pyramid = ibague_pyramid_2019$data,
  sex = data_ibague$sexo, plot = TRUE, language = "EN"
)

