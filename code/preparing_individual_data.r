# Read and create the aggregated dataset

library(tidyverse)
library(read.dbc)
library(gtsummary)

# Crude data obtained from SINAN 
dir("~/sinan_data/dengue/")



# 2000 - 2006 -------------------------------------------------------------



years = 2000:2006
dengue.list <- vector(mode = "list", length = length(years))
names(dengue.list) = years


# years[7] # 2006!
for(k in 1:7){
  aux <- read.dbc(paste0("~/sinan_data/dengue/DENGBR",
                         ifelse(years[k]<2010, "0", ""),
                         years[k]-2000, ".dbc"))

  dengue.list[[k]] <- aux %>%
    select( ID_MN_RESI, DT_SIN_PRI, DT_NOTIFIC,
            NU_IDADE,
            # NU_IDADE_N,
            CS_SEXO,
            CON_CLASSI,
            RESUL_VIRA,
            # CLASSI_FIN,
            CON_EVOLUC, CON_DT_OBI
    )
  cat(years[k], dim( dengue.list[[k]] ), "\n")
  rm(aux)
  gc()
}

dengue.2000_2006 <- dengue.list %>% bind_rows(.id = "Ano")

dengue.2000_2006 %>% saveRDS("~/sinan_data/treated/den/den_2000_2006_ind.rds")



# 2007-2009 ---------------------------------------------------------------


years = 2007:2009
dengue.list <- vector(mode = "list", length = length(years))
names(dengue.list) = years

# 2007

k = 1; years[k]

aux <- read.dbc(paste0("~/sinan_data/dengue/DENGBR",
                       ifelse(years[k]<2010, "0", ""),
                       years[k]-2000, ".dbc"))

dengue.list[[k]] <- aux %>%
  select( ID_MN_RESI, DT_SIN_PRI, DT_NOTIFIC, DT_DIGITA,
          NU_IDADE_N,
          CS_SEXO,
          CLASSI_FIN, CRITERIO,
          # CON_CLASSI,
          SOROTIPO,
          EVOLUCAO, DT_OBITO
  )

# # 2008 (problema!)
k=2; years[k]
aux <- shp::read_dbf("~/sinan_data/dengue/DENGBR08.dbf")
dengue.list[[2]] <- aux %>%
  select( ID_MN_RESI, DT_SIN_PRI, DT_NOTIFIC, DT_DIGITA,
          NU_IDADE_N,
          CS_SEXO,
          CLASSI_FIN, CRITERIO,
          # CON_CLASSI,
          SOROTIPO,
          EVOLUCAO, DT_OBITO
  ) %>% #head() %>% View()
  mutate(
    ID_MN_RESI = factor(ID_MN_RESI),
    DT_SIN_PRI = ymd(DT_SIN_PRI),
    DT_NOTIFIC = ymd(DT_NOTIFIC),
    DT_DIGITA = ymd(DT_DIGITA),
    NU_IDADE_N = as.integer(NU_IDADE_N),
    CS_SEXO = factor(CS_SEXO),
    CLASSI_FIN = factor(CLASSI_FIN),
    CRITERIO = factor(CRITERIO),
    SOROTIPO = as.factor(SOROTIPO),
    EVOLUCAO = as.factor(EVOLUCAO), 
    DT_OBITO = ymd(DT_OBITO)
  )


## 2009

k = 3; years[3]
aux <- read.dbc(paste0("~/sinan_data/dengue/DENGBR09.dbc"))

dengue.list[[k]] <- aux %>%
  select( ID_MN_RESI, DT_SIN_PRI, DT_NOTIFIC, DT_DIGITA,
          NU_IDADE_N,
          CS_SEXO,
          CLASSI_FIN, CRITERIO,
          # CON_CLASSI,
          SOROTIPO,
          EVOLUCAO, DT_OBITO
  )


dengue.2007_2009 <- dengue.list %>% bind_rows(.id = "Ano")

dengue.2007_2009 %>% saveRDS("~/sinan_data/treated/den/den_2007_2009_ind.rds")



# 2010-2022 ---------------------------------------------------------------


years = 2010:2022
dengue.list <- vector(mode = "list", length = length(years))
names(dengue.list) = years

# years[7] # 2006!
for(k in 1:length(years)){
  aux <- read.dbc(paste0("~/sinan_data/dengue/DENGBR", 
                         ifelse(years[k]<2010, "0", ""),
                         years[k]-2000, ".dbc"))
  
  if(is.null(aux$DT_DIGITA)){
    aux$DT_DIGITA = NA
  }
  

  dengue.list[[k]] <- aux %>%
    select( ID_MN_RESI, DT_SIN_PRI, DT_NOTIFIC, DT_DIGITA,
            NU_IDADE_N,
            CS_SEXO,
            CLASSI_FIN, CRITERIO,
            # CON_CLASSI,
            SOROTIPO,
            EVOLUCAO, DT_OBITO
    )
  
  cat(years[k], dim( dengue.list[[k]] ), "\n")
  rm(aux)
  gc()
  
}

dengue.2010_2022 <- dengue.list %>% bind_rows(.id = "Ano")

dengue.2010_2022 %>% saveRDS("~/sinan_data/treated/den/den_2010_2022_ind.rds")
