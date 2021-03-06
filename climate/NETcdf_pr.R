
require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)

################################################################################
setwd("C:/Users/inpe-eba/SISMOI/")

# abrir o netCDF file
pr_rcp85 <- nc_open("rcp85_mean_hist/pr_Amon_modmean_rcp85_ave.nc")
print(pr_rcp85)

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")

# get longitude and latitude
lon <- ncvar_get(pr_rcp85,"lon")
nlon <- dim(lon)
head(lon)
tail(lon)
#[variando de 0� - 360�]

lat <- ncvar_get(pr_rcp85,"lat")
nlat <- dim(lat)
head(lat)
tail(lat)
#variando de -90� - 90�]

print(c(nlon,nlat))

# get time
time <- ncvar_get(pr_rcp85, "time")
time <- as.vector(time)

tunits <- ncatt_get(pr_rcp85,"time","units")
nt <- dim(time)


# fun��o para leitura das datas no dado.

pr_time <- nc.get.time.series(pr_rcp85, v="pr",
                              time.dim.name = "time")

#leitura das datas iniciais e finais
pr_time[c(1:3, length(pr_time) - 2:0)]

# dimens�o do dado
tmp_array <- ncvar_get(pr_rcp85)
dim(tmp_array)

# precipita��o media
precip <- ncvar_get(pr_rcp85, "pr")
head(precip)
tail(precip)

#[ varia de 30mmm at� 110mm aproximadamente]



# transforma o NetCDF em Raster
pr_rcp85_brick = brick("C:/Users/inpe-eba/SISMOI/rcp85_mean_hist/pr_Amon_modmean_rcp85_ave.nc")

#verificar a extens�o do dado
extent(pr_rcp85_brick)
extent(brasil) 

#transforma a longitude de 0-360 para -180-180
pr_rcp85_brick = rotate(pr_rcp85_brick) 

# verifica a proje��o do dado
crs(brasil) 
crs(pr_rcp85_brick)

#compatibiliza��o das proje��es
brasil = spTransform(brasil, crs(pr_rcp85_brick)) 

#recorte espacial da �rea de estudo
pr_rcp85_mask = crop(pr_rcp85_brick, brasil) 

#recorte temporal no dado
pr_rcp85_slice = subset(pr_rcp85_mask, 1201:2880) # 1961-2100

#trasnforma��o do dado em dataframe

pr_rcp85_df = as.data.frame(pr_rcp85_slice, xy=TRUE) 

# separa��o das colunas lat lon

x = pr_rcp85_df$x
y = pr_rcp85_df$y

#transforma��o com fator de corre��o (sem as colunas lat lon)
fator = 86400*30
pr_rcp85_df = pr_rcp85_df[3:1682] * (fator)

# inser��o das colunas lat e lon
pr_rcp85_df$x <- c(x)
pr_rcp85_df$y <- c(y)

# reordenamento das colunas
pr_rcp85_df = pr_rcp85_df[c(1681,1682,1:1680)]

#definindo as datas da sequencia dos dados
dates <- seq(as.Date("1961/1/1"), by = "month", length.out = 1680)
head(dates)
tail(dates)

# nomeando as colunas do data frame
names(pr_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))

# Exportar o data frame como tabela CSV

write.csv(pr_rcp85_df, file = "pr_rcp85.csv")

#plot

plot(pr_rcp85_slice, 1)
plot(brasil, add=T)

# plot 
ggplot() +
geom_polygon(data=brasil, aes(x=long, y=lat, group=group)) +  
  geom_point(data=pr_rcp85_df, aes(x=x, y=y), size = 1, color="red")+
  borders("world", colour="black", fill=NA) + 
  theme_void() + 
  coord_quickmap() + 
  ggtitle("Modeled precipitation",
          subtitle = "All models, RCP 4.5 experiment, r1i1p1 ensemble member") 


# exportar como tiff
if (require(rgdal)) {
  rf <- writeRaster(pr_rcp85_ajusted, filename="pr_rcp85.tif", format="GTiff", overwrite=TRUE)
}

