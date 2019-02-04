require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)

################################################################################
setwd("C:/Users/inpe-eba/SISMOI/Indicadores/CV")


pr_rcp45 = read.csv("C:/Users/inpe-eba/SISMOI/Variaveis/rcp45_mean_hist/pr_rcp45.csv")

pr_rcp85 = read.csv("C:/Users/inpe-eba/SISMOI/Variaveis/rcp85_mean_hist/pr_rcp85.csv")

# separação das colunas lat lon

x = pr_rcp45$lat
y = pr_rcp45$lon
z = pr_rcp45$X

#excluir colunas
pr_rcp45 <- subset(pr_rcp45, select = -c(X, lat, lon))

pr_rcp85 <- subset(pr_rcp85, select = -c(X, lat, lon))

# normalização da precipitação
pr_rcp45_norm = (pr_rcp45 - min(pr_rcp45))/(max(pr_rcp45) - min(pr_rcp45))

pr_rcp85_norm = (pr_rcp85 - min(pr_rcp85))/(max(pr_rcp85) - min(pr_rcp85))

# Calculo da media alternativo
#n <- 1:ncol(pr)
#ind <- matrix(c(n, rep(NA, 12 - ncol(pr)%%12)), byrow=TRUE, ncol=12)
#ind <- data.frame(t(na.omit(ind)))
#pr_mean = do.call(cbind, lapply(ind, function(i) rowMeans(pr[, i])))


# Function to apply 'fun' to object 'x' over every 'by' columns
# Alternatively, 'by' may be a vector of groups
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

# calculo da media
pr_rcp45_mean = byapply(pr_rcp45_norm, 12, rowMeans)

pr_rcp85_mean = byapply(pr_rcp85_norm, 12, rowMeans)

# calculo do desvio padrão
pr_rcp45_sd = byapply(pr_rcp45_norm, 12, apply, 1, sd)

pr_rcp85_sd = byapply(pr_rcp85_norm, 12, apply, 1, sd)

# calculo do Indice CV

CV_rcp45 = as.data.frame(pr_rcp45_sd / pr_rcp45_mean)

CV_rcp85 = as.data.frame(pr_rcp85_sd / pr_rcp85_mean)

# inserção das colunas lat e lon
CV_rcp45$lat <- c(x)
CV_rcp45$lon <- c(y)

CV_rcp85$lat <- c(x)
CV_rcp85$lon <- c(y)

# reordenamento das colunas
CV_rcp45 = CV_rcp45[c(141,142,1:140)]

CV_rcp85 = CV_rcp85[c(141,142,1:140)]

#definindo as datas da sequencia dos dados
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 140)
head(dates)
tail(dates)

# nomeando as colunas do data frame
names(CV_rcp45) <- c("lon","lat", paste(dates,as.character(), sep="_"))

names(CV_rcp85) <- c("lon","lat", paste(dates,as.character(), sep="_"))

# Exportar o data frame como tabela CSV

write.csv(CV_rcp45, file = "CV_rcp45.csv")

write.csv(CV_rcp85, file = "CV_rcp85.csv")
