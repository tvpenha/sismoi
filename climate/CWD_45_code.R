require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/CWD/rcp45")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
CWD_1 <- nc_open("CWDETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")
print(CWD_1)

# tempo
CWD_time <- nc.get.time.series(CWD_1, v="CWDETCCDI",
                              time.dim.name = "time")
head(CWD_time)
tail(CWD_time)

# get time
time <- ncvar_get(CWD_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(CWD_1,"time","units")
nt <- dim(time)

# CWD analise
CWD <- ncvar_get(CWD_1, "CWDETCCDI")
head(CWD)
tail(CWD)

#Modelo ACCESS1

# transforma o NetCDF em Raster
CWD1 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD1 = rotate(CWD1) 

#recorte espacial da área de estudo
#CWD1_mask = crop(CWD1, brasil) 

#recorte temporal no dado
#CWD1_slice = subset(CWD1, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD1_ajusted = resample(CWD1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
CWD2 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_ACCESS1-3_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD2 = rotate(CWD2) 

#recorte espacial da área de estudo
#CWD2_mask = crop(CWD2, brasil) 

#recorte temporal no dado
#CWD2_slice = subset(CWD2, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD2_ajusted = resample(CWD2, rp, method='bilinear')


# transforma o NetCDF em Raster
CWD3 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_BNU-ESM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD3 = rotate(CWD3) 

#recorte espacial da área de estudo
#CWD3_mask = crop(CWD3, brasil) 

#recorte temporal no dado
#CWD3_slice = subset(CWD3, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD3_ajusted = resample(CWD3, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD4 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CanESM2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CWD4 = rotate(CWD4) 

#recorte espacial da área de estudo
#CWD4_mask = crop(CWD4, brasil) 

#recorte temporal no dado
CWD4_slice = subset(CWD4, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD4_ajusted = resample(CWD4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD5 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CCSM4_rcp45_r1i1p1_2006-2299.nc")

#transforma a longitude de 0-360 para -180-180
CWD5 = rotate(CWD5) 

#recorte espacial da área de estudo
#CWD5_mask = crop(CWD5, brasil) 

#recorte temporal no dado
CWD5_slice = subset(CWD5, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD5_ajusted = resample(CWD5_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD6 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CMCC-CM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD6 = rotate(CWD6) 

#recorte espacial da área de estudo
#CWD6_mask = crop(CWD6, brasil) 

#recorte temporal no dado
#CWD6_slice = subset(CWD6, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD6_ajusted = resample(CWD6, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD7 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CMCC-CMS_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD7 = rotate(CWD7) 

#recorte espacial da área de estudo
#CWD7_mask = crop(CWD7, brasil) 

#recorte temporal no dado
#CWD7_slice = subset(CWD7, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD7_ajusted = resample(CWD7, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD8 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CNRM-CM5_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD8 = rotate(CWD8) 

#recorte espacial da área de estudo
#CWD8_mask = crop(CWD8, brasil) 

#recorte temporal no dado
#CWD8_slice = subset(CWD8, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD8_ajusted = resample(CWD8, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD9 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_CSIRO-Mk3-6-0_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CWD9 = rotate(CWD9) 

#recorte espacial da área de estudo
#CWD9_mask = crop(CWD9, brasil) 

#recorte temporal no dado
CWD9_slice = subset(CWD9, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD9_ajusted = resample(CWD9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD10 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_EC-EARTH_rcp45_r6i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD10 = rotate(CWD10) 

#recorte espacial da área de estudo
#CWD10_mask = crop(CWD10, brasil) 

#recorte temporal no dado
#CWD10_slice = subset(CWD10, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD10_ajusted = resample(CWD10, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD11 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_FGOALS-s2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CWD11 = rotate(CWD11) 

#recorte espacial da área de estudo
#CWD11_mask = crop(CWD11, brasil) 

#recorte temporal no dado
CWD11_slice = subset(CWD11, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD11_ajusted = resample(CWD11_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
CWD13 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_HadGEM2-CC_rcp45_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD13 = rotate(CWD13) 

#recorte espacial da área de estudo
#CWD13_mask = crop(CWD13, brasil) 

#recorte temporal no dado
CWD13_slice = subset(CWD13, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD13_ajusted = resample(CWD13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD14 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_IPSL-CM5A-LR_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CWD14 = rotate(CWD14) 

#recorte espacial da área de estudo
#CWD15_mask = crop(CWD15, brasil) 

#recorte temporal no dado
CWD14_slice = subset(CWD14, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD14_ajusted = resample(CWD14_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
CWD15 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_IPSL-CM5B-LR_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD15 = rotate(CWD15) 

#recorte espacial da área de estudo
#CWD15_mask = crop(CWD15, brasil) 

#recorte temporal no dado
#CWD15_slice = subset(CWD15, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD15_ajusted = resample(CWD15, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD16 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_MIROC-ESM_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CWD16 = rotate(CWD16) 

#recorte espacial da área de estudo
#CWD16_mask = crop(CWD16, brasil) 

#recorte temporal no dado
CWD16_slice = subset(CWD16, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD16_ajusted = resample(CWD16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD17 = brick("C:/Users/inpe-eba/SISMOI/CWD/rcp45/cwdETCCDI_yr_MIROC-ESM-CHEM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CWD17 = rotate(CWD17) 

#recorte espacial da área de estudo
#CWD17_mask = crop(CWD17, brasil) 

#recorte temporal no dado
#CWD17_slice = subset(CWD17, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD17_ajusted = resample(CWD17, rp, method="bilinear")


#cria lista de rasters
CWD_rcp45 = stack(CWD1_ajusted, CWD2_ajusted, CWD3_ajusted, CWD4_ajusted, CWD5_ajusted,
                 CWD6_ajusted, CWD7_ajusted, CWD8_ajusted, CWD9_ajusted, CWD10_ajusted,
                 CWD11_ajusted, CWD13_ajusted, CWD14_ajusted, CWD15_ajusted, 
                 CWD16_ajusted, CWD17_ajusted)


#calcula a media CWD

rMean <- calc( CWD_rcp45 , fun = function(x){ by(x , c( rep(seq(1:95), times = 16)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

CWD_rcp45_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(CWD_rcp45_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(CWD_rcp45_df, file = "CWD_rcp45_mean.csv")

