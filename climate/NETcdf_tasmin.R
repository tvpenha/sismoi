
require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)

################################################################################
setwd("C:/Users/inpe-eba/SISMOI/")

# abrir o netCDF file
tasmin_rcp85 <- nc_open("rcp85_mean_hist/tasmin_Amon_modmean_rcp85_ave.nc")
tasminint(tasmin_rcp85)

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")

# get longitude and latitude
lon <- ncvar_get(tasmin_rcp85,"lon")
nlon <- dim(lon)
head(lon)
tail(lon)
#[variando de 0º - 360º]

lat <- ncvar_get(tasmin_rcp85,"lat")
nlat <- dim(lat)
head(lat)
tail(lat)
#variando de -90º - 90º]

tasminint(c(nlon,nlat))

# get time
time <- ncvar_get(tasmin_rcp85, "time")
time <- as.vector(time)

tunits <- ncatt_get(tasmin_rcp85,"time","units")
nt <- dim(time)


# função para leitura das datas no dado.

tasmin_time <- nc.get.time.series(tasmin_rcp85, v="tasmin",
                              time.dim.name = "time")

#leitura das datas iniciais e finais
tasmin_time[c(1:3, length(tasmin_time) - 2:0)]

# dimensão do dado
tmp_array <- ncvar_get(tasmin_rcp85)
dim(tmp_array)

# tasminecipitação media
tasminecip <- ncvar_get(tasmin_rcp85, "tasmin")
head(tasminecip)
tail(tasminecip)

# transforma o NetCDF em Raster
tasmin_rcp85_brick = brick("C:/Users/inpe-eba/SISMOI/rcp85_mean_hist/tasmin_Amon_modmean_rcp85_ave.nc")

#verificar a extensão do dado
extent(tasmin_rcp85_brick)
extent(brasil) 

#transforma a longitude de 0-360 para -180-180
tasmin_rcp85_brick = rotate(tasmin_rcp85_brick) 

# verifica a tasminojeção do dado
crs(brasil) 
crs(tasmin_rcp85_brick)

#compatibilização das tasminojeções
brasil = spTransform(brasil, crs(tasmin_rcp85_brick)) 

#recorte espacial da área de estudo
tasmin_rcp85_mask = crop(tasmin_rcp85_brick, brasil) 

#recorte temporal no dado
tasmin_rcp85_slice = subset(tasmin_rcp85_mask, 1201:2880) # 1961-2100

#trasnformação do dado em dataframe

tasmin_rcp85_df = as.data.frame(tasmin_rcp85_slice, xy=TRUE) 

# separação das colunas lat lon

x = tasmin_rcp85_df$x
y = tasmin_rcp85_df$y

#transformação com fator de correção (sem as colunas lat lon)
fator = -273.15
tasmin_rcp85_df = tasmin_rcp85_df[3:1682] + fator

# inserção das colunas lat e lon
tasmin_rcp85_df$x <- c(x)
tasmin_rcp85_df$y <- c(y)

# reordenamento das colunas
tasmin_rcp85_df = tasmin_rcp85_df[c(1681,1682,1:1680)]

#definindo as datas da sequencia dos dados
dates <- seq(as.Date("1961/1/1"), by = "month", length.out = 1680)
head(dates)
tail(dates)

# nomeando as colunas do data frame
names(tasmin_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))

# Exportar o data frame como tabela CSV

write.csv(tasmin_rcp85_df, file = "tasmin_rcp85.csv")

#plot

plot(tasmin_rcp85_slice, 1)
plot(brasil, add=T)

# plot 
ggplot() +
geom_polygon(data=brasil, aes(x=long, y=lat, group=group)) +  
  geom_point(data=tasmin_rcp85_df, aes(x=x, y=y), size = 1, color="red")+
  borders("world", colour="black", fill=NA) + 
  theme_void() + 
  coord_quickmap() + 
  ggtitle("Modeled tasminecipitation",
          subtitle = "All models, RCP 4.5 experiment, r1i1p1 ensemble member") 


# exportar como tiff
if (require(rgdal)) {
  rf <- writeRaster(tasmin_rcp85_ajusted, filename="tasmin_rcp85.tif", format="GTiff", overwrite=TRUE)
}

