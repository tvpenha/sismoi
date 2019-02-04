require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
PRCPTOT_1 <- nc_open("PRCPTOTETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")
print(PRCPTOT_1)

# tempo
PRCPTOT_time <- nc.get.time.series(PRCPTOT_1, v="PRCPTOTETCCDI",
                              time.dim.name = "time")
head(PRCPTOT_time)
tail(PRCPTOT_time)

# get time
time <- ncvar_get(PRCPTOT_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(PRCPTOT_1,"time","units")
nt <- dim(time)

# PRCPTOT analise
PRCPTOT <- ncvar_get(PRCPTOT_1, "PRCPTOTETCCDI")
head(PRCPTOT)
tail(PRCPTOT)

#Modelo ACCESS1

# transforma o NetCDF em Raster
PRCPTOT1 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT1 = rotate(PRCPTOT1) 

#recorte espacial da área de estudo
#PRCPTOT1_mask = crop(PRCPTOT1, brasil) 

#recorte temporal no dado
PRCPTOT1_slice = subset(PRCPTOT1, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT1_ajusted = resample(PRCPTOT1_slice, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
PRCPTOT2 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_BNU-ESM_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT2 = rotate(PRCPTOT2) 

#recorte espacial da área de estudo
#PRCPTOT2_mask = crop(PRCPTOT2, brasil) 

#recorte temporal no dado
PRCPTOT2_slice = subset(PRCPTOT2, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT2_ajusted = resample(PRCPTOT2_slice, rp, method='bilinear')


# transforma o NetCDF em Raster
PRCPTOT3 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CanCM4_historical_r1i1p1_1961-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT3 = rotate(PRCPTOT3) 

#recorte espacial da área de estudo
#PRCPTOT3_mask = crop(PRCPTOT3, brasil) 

#recorte temporal no dado
#PRCPTOT3_slice = subset(PRCPTOT3, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT3_ajusted = resample(PRCPTOT3, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT4 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CanESM2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT4 = rotate(PRCPTOT4) 

#recorte espacial da área de estudo
#PRCPTOT4_mask = crop(PRCPTOT4, brasil) 

#recorte temporal no dado
PRCPTOT4_slice = subset(PRCPTOT4, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT4_ajusted = resample(PRCPTOT4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT5 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CCSM4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT5 = rotate(PRCPTOT5) 

#recorte espacial da área de estudo
#PRCPTOT5_mask = crop(PRCPTOT5, brasil) 

#recorte temporal no dado
PRCPTOT5_slice = subset(PRCPTOT5, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT5_ajusted = resample(PRCPTOT5_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
PRCPTOT6 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CESM1-FASTCHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT6 = rotate(PRCPTOT6) 

#recorte espacial da área de estudo
#PRCPTOT6_mask = crop(PRCPTOT6, brasil) 

#recorte temporal no dado
PRCPTOT6_slice = subset(PRCPTOT6, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT6_ajusted = resample(PRCPTOT6_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT7 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CMCC-CESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT7 = rotate(PRCPTOT7) 

#recorte espacial da área de estudo
#PRCPTOT7_mask = crop(PRCPTOT7, brasil) 

#recorte temporal no dado
PRCPTOT7_slice = subset(PRCPTOT7, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT7_ajusted = resample(PRCPTOT7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT8 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CMCC-CM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT8 = rotate(PRCPTOT8) 

#recorte espacial da área de estudo
#PRCPTOT8_mask = crop(PRCPTOT8, brasil) 

#recorte temporal no dado
PRCPTOT8_slice = subset(PRCPTOT8, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT8_ajusted = resample(PRCPTOT8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT9 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CMCC-CMS_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT9 = rotate(PRCPTOT9) 

#recorte espacial da área de estudo
#PRCPTOT9_mask = crop(PRCPTOT9, brasil) 

#recorte temporal no dado
PRCPTOT9_slice = subset(PRCPTOT9, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT9_ajusted = resample(PRCPTOT9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT10 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CNRM-CM5_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT10 = rotate(PRCPTOT10) 

#recorte espacial da área de estudo
#PRCPTOT10_mask = crop(PRCPTOT10, brasil) 

#recorte temporal no dado
PRCPTOT10_slice = subset(PRCPTOT10, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT10_ajusted = resample(PRCPTOT10_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT11 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_CSIRO-Mk3-6-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT11 = rotate(PRCPTOT11) 

#recorte espacial da área de estudo
#PRCPTOT11_mask = crop(PRCPTOT11, brasil) 

#recorte temporal no dado
PRCPTOT11_slice = subset(PRCPTOT11, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT11_ajusted = resample(PRCPTOT11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT12 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_FGOALS-s2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT12 = rotate(PRCPTOT12) 

#recorte espacial da área de estudo
#PRCPTOT12_mask = crop(PRCPTOT12, brasil) 

#recorte temporal no dado
PRCPTOT12_slice = subset(PRCPTOT12, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT12_ajusted = resample(PRCPTOT12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT13 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_GFDL-CM3_historical_r1i1p1_1860-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT13 = rotate(PRCPTOT13) 

#recorte espacial da área de estudo
#PRCPTOT13_mask = crop(PRCPTOT13, brasil) 

#recorte temporal no dado
PRCPTOT13_slice = subset(PRCPTOT13, 102:146) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT13_ajusted = resample(PRCPTOT13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT15 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_HadCM3_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT15 = rotate(PRCPTOT15) 

#recorte espacial da área de estudo
#PRCPTOT15_mask = crop(PRCPTOT15, brasil) 

#recorte temporal no dado
PRCPTOT15_slice = subset(PRCPTOT15, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT15_ajusted = resample(PRCPTOT15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT16 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_HadGEM2-CC_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT16 = rotate(PRCPTOT16) 

#recorte espacial da área de estudo
#PRCPTOT16_mask = crop(PRCPTOT16, brasil) 

#recorte temporal no dado
PRCPTOT16_slice = subset(PRCPTOT16, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT16_ajusted = resample(PRCPTOT16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT17 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_HadGEM2-ES_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT17 = rotate(PRCPTOT17) 

#recorte espacial da área de estudo
#PRCPTOT17_mask = crop(PRCPTOT17, brasil) 

#recorte temporal no dado
PRCPTOT17_slice = subset(PRCPTOT17, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT17_ajusted = resample(PRCPTOT17_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT18 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_IPSL-CM5A-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT18 = rotate(PRCPTOT18) 

#recorte espacial da área de estudo
#PRCPTOT18_mask = crop(PRCPTOT18, brasil) 

#recorte temporal no dado
PRCPTOT18_slice = subset(PRCPTOT18, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT18_ajusted = resample(PRCPTOT18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT19 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_IPSL-CM5A-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT19 = rotate(PRCPTOT19) 

#recorte espacial da área de estudo
#PRCPTOT19_mask = crop(PRCPTOT19, brasil) 

#recorte temporal no dado
PRCPTOT19_slice = subset(PRCPTOT19, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT19_ajusted = resample(PRCPTOT19_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT20 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_IPSL-CM5B-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT20 = rotate(PRCPTOT20) 

#recorte espacial da área de estudo
#PRCPTOT20_mask = crop(PRCPTOT20, brasil) 

#recorte temporal no dado
PRCPTOT20_slice = subset(PRCPTOT20, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT20_ajusted = resample(PRCPTOT20_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT21 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_MIROC4h_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT21 = rotate(PRCPTOT21) 

#recorte espacial da área de estudo
#PRCPTOT21_mask = crop(PRCPTOT21, brasil) 

#recorte temporal no dado
PRCPTOT21_slice = subset(PRCPTOT21, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT21_ajusted = resample(PRCPTOT21_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT22 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_MIROC5_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT22 = rotate(PRCPTOT22) 

#recorte espacial da área de estudo
#PRCPTOT22_mask = crop(PRCPTOT22, brasil) 

#recorte temporal no dado
PRCPTOT22_slice = subset(PRCPTOT22, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT22_ajusted = resample(PRCPTOT22_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT23 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_MIROC-ESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT23 = rotate(PRCPTOT23) 

#recorte espacial da área de estudo
#PRCPTOT23_mask = crop(PRCPTOT23, brasil) 

#recorte temporal no dado
PRCPTOT23_slice = subset(PRCPTOT23, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT23_ajusted = resample(PRCPTOT23_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
PRCPTOT24 = brick("C:/Users/inpe-eba/SISMOI/PRCPTOT/Historical/prcptotETCCDI_yr_MIROC-ESM-CHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
PRCPTOT24 = rotate(PRCPTOT24) 

#recorte espacial da área de estudo
#PRCPTOT24_mask = crop(PRCPTOT24, brasil) 

#recorte temporal no dado
PRCPTOT24_slice = subset(PRCPTOT24, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
PRCPTOT24_ajusted = resample(PRCPTOT24_slice, rp, method="bilinear")




#cria lista de rasters
PRCPTOT_Hist = stack(PRCPTOT1_ajusted, PRCPTOT2_ajusted, PRCPTOT3_ajusted, PRCPTOT4_ajusted, PRCPTOT5_ajusted,
                 PRCPTOT6_ajusted, PRCPTOT7_ajusted, PRCPTOT8_ajusted, PRCPTOT9_ajusted, PRCPTOT10_ajusted,
                 PRCPTOT11_ajusted, PRCPTOT12_ajusted, PRCPTOT13_ajusted, 
                 PRCPTOT15_ajusted, PRCPTOT16_ajusted, PRCPTOT17_ajusted, PRCPTOT18_ajusted, PRCPTOT19_ajusted,
                 PRCPTOT20_ajusted, PRCPTOT21_ajusted, PRCPTOT22_ajusted, PRCPTOT23_ajusted, PRCPTOT24_ajusted)



#calcula a media PRCPTOT

rMean <- calc( PRCPTOT_Hist , fun = function(x){ by(x , c( rep(seq(1:45), times = 23)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

PRCPTOT_Hist_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 45)
head(dates)
tail(dates)

names(PRCPTOT_Hist_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(PRCPTOT_Hist_df, file = "PRCPTOT_Historical_mean.csv")

