library(tidyverse)

dengue <- readRDS("~/sinan_data/treated/den/den_2010_2022_ind.rds")

dengue %>% 
  mutate(
    teste = case_when(
      NU_IDADE_N > 4120 ~ "weird 1: > 4120",
      NU_IDADE_N < 1000 ~ "weird 2: < 1000",
      NU_IDADE_N <= 4120 & NU_IDADE_N > 4000  ~ "Idade em anos",
      NU_IDADE_N == 4000  ~ "0 anos?",
      NU_IDADE_N < 4000 & NU_IDADE_N > 3000  ~ "Idade em meses",
      NU_IDADE_N == 3000  ~ "0 meses?",
      NU_IDADE_N < 3000 & NU_IDADE_N > 2000  ~ "Idade em dias",
      NU_IDADE_N == 2000  ~ "0 dias?",
      NU_IDADE_N < 2000 & NU_IDADE_N > 1000  ~ "Idade em horas",
      NU_IDADE_N == 1000  ~ "0 horas?",
    )
  ) %>% 
  group_by(teste) %>% 
  tally()
