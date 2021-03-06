
require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)

################################################################################
setwd("C:/Users/inpe-eba/SISMOI/")

# abrir o netCDF file
evsp_rcp85 <- nc_open("rcp85_mean_hist/evspsbl_Amon_modmean_rcp85_ave.nc")
evspint(evsp_rcp85)

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")

# get longitude and latitude
lon <- ncvar_get(evsp_rcp85,"lon")
nlon <- dim(lon)
head(lon)
tail(lon)
#[variando de 0� - 360�]

lat <- ncvar_get(evsp_rcp85,"lat")
nlat <- dim(lat)
head(lat)
tail(lat)
#variando de -90� - 90�]

evspint(c(nlon,nlat))

# get time
time <- ncvar_get(evsp_rcp85, "time")
time <- as.vector(time)

tunits <- ncatt_get(evsp_rcp85,"time","units")
nt <- dim(time)


# fun��o para leitura das datas no dado.

evsp_time <- nc.get.time.series(evsp_rcp85, v="evsp",
                              time.dim.name = "time")

#leitura das datas iniciais e finais
evsp_time[c(1:3, length(evsp_time) - 2:0)]

# dimens�o do dado
tmp_array <- ncvar_get(evsp_rcp85)
dim(tmp_array)

# evspecipita��o media
evspecip <- ncvar_get(evsp_rcp85, "evsp")
head(evspecip)
tail(evspecip)

# transforma o NetCDF em Raster
evsp_rcp85_brick = brick("C:/Users/inpe-eba/SISMOI/rcp85_mean_hist/evspsbl_Amon_modmean_rcp85_ave.nc")

#verificar a extens�o do dado
extent(evsp_rcp85_brick)
extent(brasil) 

#transforma a longitude de 0-360 para -180-180
evsp_rcp85_brick = rotate(evsp_rcp85_brick) 

# verifica a evspoje��o do dado
crs(brasil) 
crs(evsp_rcp85_brick)

#compatibiliza��o das evspoje��es
brasil = spTransform(brasil, crs(evsp_rcp85_brick)) 

#recorte espacial da �rea de estudo
evsp_rcp85_mask = crop(evsp_rcp85_brick, brasil) 

#recorte temporal no dado
evsp_rcp85_slice = subset(evsp_rcp85_mask, 1201:2880) # 1961-2100

#trasnforma��o do dado em dataframe

evsp_rcp85_df = as.data.frame(evsp_rcp85_slice, xy=TRUE) 

# separa��o das colunas lat lon

x = evsp_rcp85_df$x
y = evsp_rcp85_df$y

#transforma��o com fator de corre��o (sem as colunas lat lon)
fator = 86400*30
evsp_rcp85_df = evsp_rcp85_df[3:1682] * (fator)

# inser��o das colunas lat e lon
evsp_rcp85_df$x <- c(x)
evsp_rcp85_df$y <- c(y)

# reordenamento das colunas
evsp_rcp85_df = evsp_rcp85_df[c(1681,1682,1:1680)]

#definindo as datas da sequencia dos dados
dates <- seq(as.Date("1961/1/1"), by = "month", length.out = 1680)
head(dates)
tail(dates)

# nomeando as colunas do data frame
names(evsp_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))

# Exportar o data frame como tabela CSV

write.csv(evsp_rcp85_df, file = "evsp_rcp85.csv")

#plot

plot(evsp_rcp85_slice, 1)
plot(brasil, add=T)

# plot 
ggplot() +
geom_polygon(data=brasil, aes(x=long, y=lat, group=group)) +  
  geom_point(data=evsp_rcp85_df, aes(x=x, y=y), size = 1, color="red")+
  borders("world", colour="black", fill=NA) + 
  theme_void() + 
  coord_quickmap() + 
  ggtitle("Modeled evspecipitation",
          subtitle = "All models, RCP 4.5 experiment, r1i1p1 ensemble member") 


# exportar como tiff
if (require(rgdal)) {
  rf <- writeRaster(evsp_rcp85_ajusted, filename="evsp_rcp85.tif", format="GTiff", overwrite=TRUE)
}

