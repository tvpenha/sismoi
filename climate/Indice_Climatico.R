### Calclo dos Indices Climaticos 

# ------------------------------------------------------------------------------------------------#

require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/Produtos_finais/Indice_Climatico")

#________________________________________________________________________________________________
# Cenário Otimista

# Abrir Indicadores para cenário otimista

CDD_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CDD_rcp45_norm.csv")
CWD_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CWD_rcp45_norm.csv")
CV_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CV_rcp45_norm.csv")
SPI_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/SPI_rcp45_norm.csv")
PRCPTOT_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/PRCPTOT_rcp45_norm.csv")
R95p_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/R95p_rcp45_norm.csv")
Rx1day_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/Rx1day_rcp45_norm.csv")
Rx5day_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/Rx1day_rcp45_norm.csv")

# Transformação para dataframe

CDD_rcp45 = as.data.frame(CDD_rcp45)
CWD_rcp45 = as.data.frame(CWD_rcp45)
CV_rcp45 = as.data.frame(CV_rcp45)
SPI_rcp45 = as.data.frame(SPI_rcp45)
PRCPTOT_rcp45 = as.data.frame(PRCPTOT_rcp45)
R95p_rcp45 = as.data.frame(R95p_rcp45)
Rx1day_rcp45 = as.data.frame(Rx1day_rcp45)
Rx5day_rcp45 = as.data.frame(Rx5day_rcp45)

# separação das colunas lat lon e geocódigo

lat = CDD_rcp45$lat
lon = CDD_rcp45$lon

GEOCODMUN = readOGR("C:/Users/inpe-eba/SISMOI/Produtos_finais/Indicadores/CDD_Historical_Mun_SAB.shp")
GEOCODMUN = GEOCODMUN$CD_GEOCMU
GEOCODMUN = as.character(GEOCODMUN)

#excluir colunas

CDD_rcp45 <- subset(CDD_rcp45, select = -c( X, lat, lon, GEOCMUN))
CWD_rcp45 <- subset(CWD_rcp45, select = -c( X, GEOCMUN))
CV_rcp45 <- subset(CV_rcp45, select = -c( X, GEOCMUN))
SPI_rcp45 <- subset(SPI_rcp45, select = -c( X, lat, lon, GEOCMUN))
PRCPTOT_rcp45 <- subset(PRCPTOT_rcp45, select = -c( X, GEOCMUN))
R95p_rcp45 <- subset(R95p_rcp45, select = -c( X, GEOCMUN))
Rx1day_rcp45 <- subset(Rx1day_rcp45, select = -c( X, lat, lon, GEOCMUN))
Rx5day_rcp45 <- subset(Rx5day_rcp45, select = -c( X, lat, lon, GEOCMUN))

# calculo do Indice SClimatico - Chuva

IC_chuva_rcp45 = as.data.frame((CDD_rcp45 + CV_rcp45 + (1 - PRCPTOT_rcp45) + SPI_rcp45/ 4))

IC_seco_rcp45 = as.data.frame((1.75*Rx1day_rcp45) + (0.5*Rx5day_rcp45) + (0.5*R95p_rcp45) + (0.25*CWD_rcp45)/ 4)

# normalizar Indices para 0-1

# Construindo a função de normalização de 0 a 1 
rnorm<-function(x, minimo=0, maximo=1) {
  for(i in 1:ncol(x)){
    if(is.numeric(x[,i])){
       v_min<-min(x[,i])
       v_max<-max(x[,i])
      for(j in 1:nrow(x)){
         x[j,i]<-((x[j,i]-v_min)/(v_max-v_min))*((maximo-minimo)+minimo)
         }
     }
   }
   return(x) # Retornando a planilha normalizada
}

IC_chuva_rcp45 = rnorm(IC_chuva_rcp45)

IC_seco_rcp45 = rnorm(IC_seco_rcp45)

# nomeando as colunas do data frame

names(IC_chuva_rcp45) <- c("IC_chuva_2010","IC_chuva_2020", "IC_chuva_2030", "IC_chuva_2040", "IC_chuva_2050")

names(IC_seco_rcp45) <- c("IC_seco_2010","IC_seco_2020", "IC_seco_2030", "IC_seco_2040", "IC_seco_2050")

names(CDD_rcp45) <- c("CDD_2010","CDD_2020", "CDD_2030", "CDD_2040", "CDD_2050")
names(CWD_rcp45) <- c("CWD_2010","CWD_2020", "CWD_2030", "CWD_2040", "CWD_2050")
names(CV_rcp45) <- c("CV_2010","CV_2020", "CV_2030", "CV_2040", "CV_2050")
names(SPI_rcp45) <- c("SPI_2010","SPI_2020", "SPI_2030", "SPI_2040", "SPI_2050")
names(PRCPTOT_rcp45) <- c("PRCPTOT_2010","PRCPTOT_2020", "PRCPTOT_2030", "PRCPTOT_2040", "PRCPTOT_2050")
names(R95p_rcp45) <- c("R95p_2010","R95p_2020", "R95p_2030", "R95p_2040", "R95p_2050")
names(Rx1day_rcp45) <- c("Rx1day_2010","Rx1day_2020", "Rx1day_2030", "Rx1day_2040", "Rx1day_2050")
names(Rx5day_rcp45) <- c("Rx5day_2010","Rx5day_2020", "Rx5day_2030", "Rx5day_2040", "Rx5day_2050")


# inserção das coluna Geocodigo

IC_chuva_rcp45$GEOCMUN <- c(GEOCODMUN)

IC_seco_rcp45$GEOCMUN <- c(GEOCODMUN)

#CDD_rcp45$GEOCMUN <- c(GEOCODMUN)
#CWD_rcp45$GEOCMUN <- c(GEOCODMUN)
#CV_rcp45$GEOCMUN <- c(GEOCODMUN)
#SPI_rcp45$GEOCMUN <- c(GEOCODMUN)
#PRCPTOT_rcp45$GEOCMUN <- c(GEOCODMUN)
#R95p_rcp45$GEOCMUN <- c(GEOCODMUN)
#Rx1day_rcp45$GEOCMUN <- c(GEOCODMUN)
#Rx5day_rcp45$GEOCMUN <- c(GEOCODMUN)

# Exportar o data frame como tabela CSV

write.csv(IC_chuva_rcp45, file = "IC_chuva_rcp45.csv")

write.csv(IC_seco_rcp45, file = "IC_seco_rcp45.csv")


# União de todas as tabelas em uma só

Df_rcp45 <- as.data.frame(c(IC_chuva_rcp45, IC_seco_rcp45,CDD_rcp45, CWD_rcp45, CV_rcp45, 
                  SPI_rcp45, PRCPTOT_rcp45, R95p_rcp45, Rx1day_rcp45, Rx5day_rcp45))

Df_rcp45$GEOCMUN <- c(GEOCODMUN)

write.csv(Df_rcp45, file = "Indicadores_IC_Otimista.csv")

#_____________________________________________________________________________________________
# Cenário pessimista

# Abrir Indicadores para cenário pessimista

CDD_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CDD_rcp85_norm.csv")
CWD_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CWD_rcp85_norm.csv")
CV_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/CV_rcp85_norm.csv")
SPI_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/SPI_rcp85_norm.csv")
PRCPTOT_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/PRCPTOT_rcp85_norm.csv")
R95p_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/R95p_rcp85_norm.csv")
Rx1day_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/Rx1day_rcp85_norm.csv")
Rx5day_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao/Rx1day_rcp85_norm.csv")

# Transformação para dataframe

CDD_rcp85 = as.data.frame(CDD_rcp85)
CWD_rcp85 = as.data.frame(CWD_rcp85)
CV_rcp85 = as.data.frame(CV_rcp85)
SPI_rcp85 = as.data.frame(SPI_rcp85)
PRCPTOT_rcp85 = as.data.frame(PRCPTOT_rcp85)
R95p_rcp85 = as.data.frame(R95p_rcp85)
Rx1day_rcp85 = as.data.frame(Rx1day_rcp85)
Rx5day_rcp85 = as.data.frame(Rx5day_rcp85)

# separação das colunas lat lon e geocódigo

lat = CDD_rcp85$lat
lon = CDD_rcp85$lon
GEOCODMUN = CDD_rcp85$GEOCMUN
GEOCODMUN = as.character(GEOCODMUN)

#excluir colunas

CDD_rcp85 <- subset(CDD_rcp85, select = -c( X, lat, lon, GEOCMUN))
CWD_rcp85 <- subset(CWD_rcp85, select = -c( X, GEOCMUN))
CV_rcp85 <- subset(CV_rcp85, select = -c( X, GEOCMUN))
SPI_rcp85 <- subset(SPI_rcp85, select = -c( X, lat, lon, GEOCMUN))
PRCPTOT_rcp85 <- subset(PRCPTOT_rcp85, select = -c( X, GEOCMUN))
R95p_rcp85 <- subset(R95p_rcp85, select = -c( X, GEOCMUN))
Rx1day_rcp85 <- subset(Rx1day_rcp85, select = -c( X, lat, lon, GEOCMUN))
Rx5day_rcp85 <- subset(Rx5day_rcp85, select = -c( X, lat, lon, GEOCMUN))

# calculo do Indice SClimatico - Chuva

IC_chuva_rcp85 = as.data.frame((CDD_rcp85 + CV_rcp85 + (1 - PRCPTOT_rcp85) + SPI_rcp85/ 4))

IC_seco_rcp85 = as.data.frame((1.75*Rx1day_rcp85) + (0.5*Rx5day_rcp85) + (0.5*R95p_rcp85) + (0.25*CWD_rcp85)/ 4)

# normalizar Indices para 0-1

# Construindo a função de normalização de 0 a 1 
rnorm<-function(x, minimo=0, maximo=1) {
  for(i in 1:ncol(x)){
    if(is.numeric(x[,i])){
      v_min<-min(x[,i])
      v_max<-max(x[,i])
      for(j in 1:nrow(x)){
        x[j,i]<-((x[j,i]-v_min)/(v_max-v_min))*((maximo-minimo)+minimo)
      }
    }
  }
  return(x) # Retornando a planilha normalizada
}

IC_chuva_rcp85 = rnorm(IC_chuva_rcp85)

IC_seco_rcp85 = rnorm(IC_seco_rcp85)

# nomeando as colunas do data frame

names(IC_chuva_rcp85) <- c("IC_chuva_2010","IC_chuva_2020", "IC_chuva_2030", "IC_chuva_2040", "IC_chuva_2050")

names(IC_seco_rcp85) <- c("IC_seco_2010","IC_seco_2020", "IC_seco_2030", "IC_seco_2040", "IC_seco_2050")

names(CDD_rcp85) <- c("CDD_2010","CDD_2020", "CDD_2030", "CDD_2040", "CDD_2050")
names(CWD_rcp85) <- c("CWD_2010","CWD_2020", "CWD_2030", "CWD_2040", "CWD_2050")
names(CV_rcp85) <- c("CV_2010","CV_2020", "CV_2030", "CV_2040", "CV_2050")
names(SPI_rcp85) <- c("SPI_2010","SPI_2020", "SPI_2030", "SPI_2040", "SPI_2050")
names(PRCPTOT_rcp85) <- c("PRCPTOT_2010","PRCPTOT_2020", "PRCPTOT_2030", "PRCPTOT_2040", "PRCPTOT_2050")
names(R95p_rcp85) <- c("R95p_2010","R95p_2020", "R95p_2030", "R95p_2040", "R95p_2050")
names(Rx1day_rcp85) <- c("Rx1day_2010","Rx1day_2020", "Rx1day_2030", "Rx1day_2040", "Rx1day_2050")
names(Rx5day_rcp85) <- c("Rx5day_2010","Rx5day_2020", "Rx5day_2030", "Rx5day_2040", "Rx5day_2050")

# inserção das coluna Geocodigo

IC_chuva_rcp85$GEOCMUN <- c(GEOCODMUN)

IC_seco_rcp85$GEOCMUN <- c(GEOCODMUN)

# Exportar o data frame como tabela CSV

write.csv(IC_chuva_rcp85, file = "IC_chuva_rcp85.csv")

write.csv(IC_seco_rcp85, file = "IC_seco_rcp85.csv")


# União de todas as tabelas em uma só

Df_rcp85 <- as.data.frame(c(IC_chuva_rcp85, IC_seco_rcp85,CDD_rcp85, CWD_rcp85, CV_rcp85, 
                            SPI_rcp85, PRCPTOT_rcp85, R95p_rcp85, Rx1day_rcp85, Rx5day_rcp85))

Df_rcp85$GEOCMUN <- c(GEOCODMUN)

write.csv(Df_rcp85, file = "Indicadores_IC_Pessimista.csv")

