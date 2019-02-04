### Normalização dos Indicadores Climaticos 

# ------------------------------------------------------------------------------------------------#

require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/Produtos_finais/Normalizacao")

# Abrir shapefile

Rx1day_Hist= readOGR("C:/Users/inpe-eba/SISMOI/Produtos_finais/Indicadores/Rx1day_Historical_Mun_SAB.shp")
Rx1day_rcp45 = readOGR("C:/Users/inpe-eba/SISMOI/Produtos_finais/Indicadores/Rx1day_rcp45_Mun_SAB.shp")
Rx1day_rcp85 = readOGR("C:/Users/inpe-eba/SISMOI/Produtos_finais/Indicadores/Rx1day_rcp85_Mun_SAB.shp")

Rx1day_Hist = as.data.frame(Rx1day_Hist)
Rx1day_rcp45 = as.data.frame(Rx1day_rcp45)
Rx1day_rcp85 = as.data.frame(Rx1day_rcp85)


# separação das colunas lat lon e geocódigo

lat = Rx1day_rcp45$lat
lon = Rx1day_rcp45$lon
GEOCODMUN = Rx1day_rcp45$CD_GEOCMU

#excluir colunas
names(Rx1day_Hist)
names(Rx1day_rcp45)
names(Rx1day_rcp85)

Rx1day_Hist <- subset(Rx1day_Hist, select = -c(X, FID_Centro, NM_MUNICIP, CD_GEOCMU, UF, Semiarido,  
                                               Pop_Est_17, ORIG_FID, FID_Rx1day, Id, FID_1, FID_Rx1d_1, 
                                               Field1, lon, lat, FID_Grid, Id_1, coords.x1, coords.x2))

Rx1day_rcp45 <- subset(Rx1day_rcp45, select = -c(X, FID_Centro, NM_MUNICIP, CD_GEOCMU, UF, Semiarido,  
                                                 Pop_Est_17, ORIG_FID, Id, FID_1, FID_Rx1d_1,FID_Rx1day, 
                                                 Field1, lon, lat, FID_Grid, Id_1, coords.x1, coords.x2))

Rx1day_rcp85 <- subset(Rx1day_rcp85, select = -c(X, Id_1, FID_Centro, NM_MUNICIP, CD_GEOCMU, UF, Semiarido,  
                                                 Pop_Est_17, ORIG_FID, Id, FID_1, FID_Rx1d_1,FID_Rx1day, 
                                                 Field1, lon, lat, FID_Grid, coords.x1, coords.x2))

#recorte temporal no dado projetado

Rx1day_rcp45 = Rx1day_rcp45[c(5:54)] # 2010-2059

Rx1day_rcp85 = Rx1day_rcp85[c(5:54)] # 2010-2059



# media decadal 2010/2020/2030/2040/2050

# Função apply 'fun' to object 'x' over every 'by' columns
byapply <- function(x, by, fun, ...)
{
  # Create index list
  if (length(by) == 1)
  {
    nc <- ncol(x)
    split.index <- rep(1:ceiling(nc / by), each = by, length.out = nc)
  } else # 'by' is a vector of groups
  {
    nc <- length(by)
    split.index <- by
  }
  index.list <- split(seq(from = 1, to = nc), split.index)
  
  # Pass index list to fun using sapply() and return object
  sapply(index.list, function(i)
  {
    do.call(fun, list(x[, i], ...))
  })
}

# calculo da media decadal 

Rx1day_rcp45_mean = as.data.frame(byapply(Rx1day_rcp45, 10, rowMeans))

Rx1day_rcp85_mean = as.data.frame(byapply(Rx1day_rcp85, 10, rowMeans))



# Normalização decadal ----------------------------------------------

# Definição dos máxmios e mínimos da série histórica (1961-2005)

max = max(Rx1day_Hist)

min = min(Rx1day_Hist)

# Construindo a função de normalização de 0 a 1 
# rnorm<-function(x, minimo=0, maximo=1) {
#   for(i in 1:ncol(x)){
#     if(is.numeric(x[,i])){
#       v_min<-min(x[,i])
#       v_max<-max(x[,i])
#       for(j in 1:nrow(x)){
#         x[j,i]<-((x[j,i]-v_min)/(v_max-v_min))*((maximo-minimo)+minimo)
#       }
#     }
#   }
#   return(x) # Retornando a planilha normalizada
# }

# Construindo a função de normalização de 0 a 1 em função dos max e min da série historica
rnorm<-function(x, minimo=0, maximo=1) {
  for(i in 1:ncol(x)){
    if(is.numeric(x[,i])){
      v_min<-min(x[,i])
      v_max<-max(x[,i])
      for(j in 1:nrow(x)){
        x[j,i]<-((x[j,i]-min)/(max-min))*((maximo-minimo)+minimo)
      }
    }
  }
  return(x) # Retornando a planilha normalizada
}

# normalização para a série historica
Rx1day_rcp45_norm = rnorm(Rx1day_rcp45_mean)

Rx1day_rcp85_norm = rnorm(Rx1day_rcp85_mean)

# Normalização por década
# Rx1day_rcp45_norm = as.data.frame(c(rnorm(Rx1day_rcp45_mean[1]), 
#                                    rnorm(Rx1day_rcp45_mean[2]),
#                                    rnorm(Rx1day_rcp45_mean[3]),
#                                    rnorm(Rx1day_rcp45_mean[4]),
#                                    rnorm(Rx1day_rcp45_mean[5])))
# 
# Rx1day_rcp85_norm = as.data.frame(c(rnorm(Rx1day_rcp85_mean[1]), 
#                                    rnorm(Rx1day_rcp85_mean[2]),
#                                    rnorm(Rx1day_rcp85_mean[3]),
#                                    rnorm(Rx1day_rcp85_mean[4]),
#                                    rnorm(Rx1day_rcp85_mean[5])))

# nomeando as colunas do data frame

names(Rx1day_rcp45_norm) <- c("2010","2020", "2030", "2040", "2050")

names(Rx1day_rcp85_norm) <- c("2010","2020", "2030", "2040", "2050")

# inserção das colunas lat / lon / Geocodigo
Rx1day_rcp45_norm$lat <- c(lat)
Rx1day_rcp45_norm$lon <- c(lon)
Rx1day_rcp45_norm$GEOCMUN <- c(GEOCODMUN)

Rx1day_rcp85_norm$lat <- c(lat)
Rx1day_rcp85_norm$lon <- c(lon)
Rx1day_rcp85_norm$GEOCMUN <- c(GEOCODMUN)

# Exportar o data frame como tabela CSV

write.csv(Rx1day_rcp45_norm, file = "Rx1day_rcp45_norm.csv")

write.csv(Rx1day_rcp85_norm, file = "Rx1day_rcp85_norm.csv")

