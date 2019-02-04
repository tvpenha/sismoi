require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/prcptot/rcp45")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
prcptot_1 <- nc_open("prcptotETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")
print(prcptot_1)

# tempo
prcptot_time <- nc.get.time.series(prcptot_1, v="prcptotETCCDI",
                              time.dim.name = "time")
head(prcptot_time)
tail(prcptot_time)

# get time
time <- ncvar_get(prcptot_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(prcptot_1,"time","units")
nt <- dim(time)

# prcptot analise
prcptot <- ncvar_get(prcptot_1, "prcptotETCCDI")
head(prcptot)
tail(prcptot)

#Modelo ACCESS1

# transforma o NetCDF em Raster
prcptot1 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot1 = rotate(prcptot1) 

#recorte espacial da área de estudo
#prcptot1_mask = crop(prcptot1, brasil) 

#recorte temporal no dado
#prcptot1_slice = subset(prcptot1, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot1_ajusted = resample(prcptot1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
prcptot2 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_ACCESS1-3_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot2 = rotate(prcptot2) 

#recorte espacial da área de estudo
#prcptot2_mask = crop(prcptot2, brasil) 

#recorte temporal no dado
#prcptot2_slice = subset(prcptot2, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot2_ajusted = resample(prcptot2, rp, method='bilinear')


# transforma o NetCDF em Raster
prcptot3 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_BNU-ESM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot3 = rotate(prcptot3) 

#recorte espacial da área de estudo
#prcptot3_mask = crop(prcptot3, brasil) 

#recorte temporal no dado
#prcptot3_slice = subset(prcptot3, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot3_ajusted = resample(prcptot3, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot4 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CanESM2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot4 = rotate(prcptot4) 

#recorte espacial da área de estudo
#prcptot4_mask = crop(prcptot4, brasil) 

#recorte temporal no dado
prcptot4_slice = subset(prcptot4, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot4_ajusted = resample(prcptot4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot5 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CCSM4_rcp45_r1i1p1_2006-2299.nc")

#transforma a longitude de 0-360 para -180-180
prcptot5 = rotate(prcptot5) 

#recorte espacial da área de estudo
#prcptot5_mask = crop(prcptot5, brasil) 

#recorte temporal no dado
prcptot5_slice = subset(prcptot5, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot5_ajusted = resample(prcptot5_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot6 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CMCC-CM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot6 = rotate(prcptot6) 

#recorte espacial da área de estudo
#prcptot6_mask = crop(prcptot6, brasil) 

#recorte temporal no dado
#prcptot6_slice = subset(prcptot6, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot6_ajusted = resample(prcptot6, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot7 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CMCC-CMS_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot7 = rotate(prcptot7) 

#recorte espacial da área de estudo
#prcptot7_mask = crop(prcptot7, brasil) 

#recorte temporal no dado
#prcptot7_slice = subset(prcptot7, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot7_ajusted = resample(prcptot7, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot8 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CNRM-CM5_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot8 = rotate(prcptot8) 

#recorte espacial da área de estudo
#prcptot8_mask = crop(prcptot8, brasil) 

#recorte temporal no dado
#prcptot8_slice = subset(prcptot8, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot8_ajusted = resample(prcptot8, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot9 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_CSIRO-Mk3-6-0_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot9 = rotate(prcptot9) 

#recorte espacial da área de estudo
#prcptot9_mask = crop(prcptot9, brasil) 

#recorte temporal no dado
prcptot9_slice = subset(prcptot9, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot9_ajusted = resample(prcptot9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot10 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_EC-EARTH_rcp45_r6i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot10 = rotate(prcptot10) 

#recorte espacial da área de estudo
#prcptot10_mask = crop(prcptot10, brasil) 

#recorte temporal no dado
#prcptot10_slice = subset(prcptot10, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot10_ajusted = resample(prcptot10, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot11 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_FGOALS-s2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot11 = rotate(prcptot11) 

#recorte espacial da área de estudo
#prcptot11_mask = crop(prcptot11, brasil) 

#recorte temporal no dado
prcptot11_slice = subset(prcptot11, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot11_ajusted = resample(prcptot11_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
prcptot13 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_HadGEM2-CC_rcp45_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot13 = rotate(prcptot13) 

#recorte espacial da área de estudo
#prcptot13_mask = crop(prcptot13, brasil) 

#recorte temporal no dado
prcptot13_slice = subset(prcptot13, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot13_ajusted = resample(prcptot13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot14 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_IPSL-CM5A-LR_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot14 = rotate(prcptot14) 

#recorte espacial da área de estudo
#prcptot15_mask = crop(prcptot15, brasil) 

#recorte temporal no dado
prcptot14_slice = subset(prcptot14, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot14_ajusted = resample(prcptot14_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
prcptot15 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_IPSL-CM5B-LR_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot15 = rotate(prcptot15) 

#recorte espacial da área de estudo
#prcptot15_mask = crop(prcptot15, brasil) 

#recorte temporal no dado
#prcptot15_slice = subset(prcptot15, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot15_ajusted = resample(prcptot15, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot16 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_MIROC-ESM_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot16 = rotate(prcptot16) 

#recorte espacial da área de estudo
#prcptot16_mask = crop(prcptot16, brasil) 

#recorte temporal no dado
prcptot16_slice = subset(prcptot16, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot16_ajusted = resample(prcptot16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot17 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp45/prcptotETCCDI_yr_MIROC-ESM-CHEM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot17 = rotate(prcptot17) 

#recorte espacial da área de estudo
#prcptot17_mask = crop(prcptot17, brasil) 

#recorte temporal no dado
#prcptot17_slice = subset(prcptot17, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot17_ajusted = resample(prcptot17, rp, method="bilinear")


#cria lista de rasters
prcptot_rcp45 = stack(prcptot1_ajusted, prcptot2_ajusted, prcptot3_ajusted, prcptot4_ajusted, prcptot5_ajusted,
                 prcptot6_ajusted, prcptot7_ajusted, prcptot8_ajusted, prcptot9_ajusted, prcptot10_ajusted,
                 prcptot11_ajusted, prcptot13_ajusted, prcptot14_ajusted, prcptot15_ajusted, 
                 prcptot16_ajusted, prcptot17_ajusted)


#calcula a media prcptot

rMean <- calc( prcptot_rcp45 , fun = function(x){ by(x , c( rep(seq(1:95), times = 16)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

prcptot_rcp45_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(prcptot_rcp45_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(prcptot_rcp45_df, file = "prcptot_rcp45_mean.csv")

