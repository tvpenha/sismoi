require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/CWD/Historical")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
CWD_1 <- nc_open("CWDETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")
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
CWD1 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD1 = rotate(CWD1) 

#recorte espacial da área de estudo
#CWD1_mask = crop(CWD1, brasil) 

#recorte temporal no dado
CWD1_slice = subset(CWD1, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD1_ajusted = resample(CWD1_slice, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
CWD2 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_BNU-ESM_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD2 = rotate(CWD2) 

#recorte espacial da área de estudo
#CWD2_mask = crop(CWD2, brasil) 

#recorte temporal no dado
CWD2_slice = subset(CWD2, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD2_ajusted = resample(CWD2_slice, rp, method='bilinear')


# transforma o NetCDF em Raster
CWD3 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CanCM4_historical_r1i1p1_1961-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD3 = rotate(CWD3) 

#recorte espacial da área de estudo
#CWD3_mask = crop(CWD3, brasil) 

#recorte temporal no dado
#CWD3_slice = subset(CWD3, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD3_ajusted = resample(CWD3, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD4 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CanESM2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD4 = rotate(CWD4) 

#recorte espacial da área de estudo
#CWD4_mask = crop(CWD4, brasil) 

#recorte temporal no dado
CWD4_slice = subset(CWD4, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD4_ajusted = resample(CWD4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD5 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CCSM4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD5 = rotate(CWD5) 

#recorte espacial da área de estudo
#CWD5_mask = crop(CWD5, brasil) 

#recorte temporal no dado
CWD5_slice = subset(CWD5, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD5_ajusted = resample(CWD5_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
CWD6 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CESM1-FASTCHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD6 = rotate(CWD6) 

#recorte espacial da área de estudo
#CWD6_mask = crop(CWD6, brasil) 

#recorte temporal no dado
CWD6_slice = subset(CWD6, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD6_ajusted = resample(CWD6_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD7 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CMCC-CESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD7 = rotate(CWD7) 

#recorte espacial da área de estudo
#CWD7_mask = crop(CWD7, brasil) 

#recorte temporal no dado
CWD7_slice = subset(CWD7, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD7_ajusted = resample(CWD7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD8 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CMCC-CM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD8 = rotate(CWD8) 

#recorte espacial da área de estudo
#CWD8_mask = crop(CWD8, brasil) 

#recorte temporal no dado
CWD8_slice = subset(CWD8, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD8_ajusted = resample(CWD8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD9 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CMCC-CMS_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD9 = rotate(CWD9) 

#recorte espacial da área de estudo
#CWD9_mask = crop(CWD9, brasil) 

#recorte temporal no dado
CWD9_slice = subset(CWD9, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD9_ajusted = resample(CWD9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD10 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CNRM-CM5_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD10 = rotate(CWD10) 

#recorte espacial da área de estudo
#CWD10_mask = crop(CWD10, brasil) 

#recorte temporal no dado
CWD10_slice = subset(CWD10, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD10_ajusted = resample(CWD10_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD11 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_CSIRO-Mk3-6-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD11 = rotate(CWD11) 

#recorte espacial da área de estudo
#CWD11_mask = crop(CWD11, brasil) 

#recorte temporal no dado
CWD11_slice = subset(CWD11, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD11_ajusted = resample(CWD11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD12 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_FGOALS-s2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD12 = rotate(CWD12) 

#recorte espacial da área de estudo
#CWD12_mask = crop(CWD12, brasil) 

#recorte temporal no dado
CWD12_slice = subset(CWD12, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD12_ajusted = resample(CWD12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD13 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_GFDL-CM3_historical_r1i1p1_1860-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD13 = rotate(CWD13) 

#recorte espacial da área de estudo
#CWD13_mask = crop(CWD13, brasil) 

#recorte temporal no dado
CWD13_slice = subset(CWD13, 102:146) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD13_ajusted = resample(CWD13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD15 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_HadCM3_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD15 = rotate(CWD15) 

#recorte espacial da área de estudo
#CWD15_mask = crop(CWD15, brasil) 

#recorte temporal no dado
CWD15_slice = subset(CWD15, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD15_ajusted = resample(CWD15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD16 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_HadGEM2-CC_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD16 = rotate(CWD16) 

#recorte espacial da área de estudo
#CWD16_mask = crop(CWD16, brasil) 

#recorte temporal no dado
CWD16_slice = subset(CWD16, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD16_ajusted = resample(CWD16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD17 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_HadGEM2-ES_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD17 = rotate(CWD17) 

#recorte espacial da área de estudo
#CWD17_mask = crop(CWD17, brasil) 

#recorte temporal no dado
CWD17_slice = subset(CWD17, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD17_ajusted = resample(CWD17_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD18 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_IPSL-CM5A-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD18 = rotate(CWD18) 

#recorte espacial da área de estudo
#CWD18_mask = crop(CWD18, brasil) 

#recorte temporal no dado
CWD18_slice = subset(CWD18, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD18_ajusted = resample(CWD18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD19 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_IPSL-CM5A-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD19 = rotate(CWD19) 

#recorte espacial da área de estudo
#CWD19_mask = crop(CWD19, brasil) 

#recorte temporal no dado
CWD19_slice = subset(CWD19, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD19_ajusted = resample(CWD19_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD20 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_IPSL-CM5B-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD20 = rotate(CWD20) 

#recorte espacial da área de estudo
#CWD20_mask = crop(CWD20, brasil) 

#recorte temporal no dado
CWD20_slice = subset(CWD20, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD20_ajusted = resample(CWD20_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD21 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_MIROC4h_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD21 = rotate(CWD21) 

#recorte espacial da área de estudo
#CWD21_mask = crop(CWD21, brasil) 

#recorte temporal no dado
CWD21_slice = subset(CWD21, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD21_ajusted = resample(CWD21_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD22 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_MIROC5_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
CWD22 = rotate(CWD22) 

#recorte espacial da área de estudo
#CWD22_mask = crop(CWD22, brasil) 

#recorte temporal no dado
CWD22_slice = subset(CWD22, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD22_ajusted = resample(CWD22_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD23 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_MIROC-ESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD23 = rotate(CWD23) 

#recorte espacial da área de estudo
#CWD23_mask = crop(CWD23, brasil) 

#recorte temporal no dado
CWD23_slice = subset(CWD23, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD23_ajusted = resample(CWD23_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CWD24 = brick("C:/Users/inpe-eba/SISMOI/CWD/Historical/cwdETCCDI_yr_MIROC-ESM-CHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CWD24 = rotate(CWD24) 

#recorte espacial da área de estudo
#CWD24_mask = crop(CWD24, brasil) 

#recorte temporal no dado
CWD24_slice = subset(CWD24, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CWD24_ajusted = resample(CWD24_slice, rp, method="bilinear")




#cria lista de rasters
CWD_Hist = stack(CWD1_ajusted, CWD2_ajusted, CWD3_ajusted, CWD4_ajusted, CWD5_ajusted,
                 CWD6_ajusted, CWD7_ajusted, CWD8_ajusted, CWD9_ajusted, CWD10_ajusted,
                 CWD11_ajusted, CWD12_ajusted, CWD13_ajusted, 
                 CWD15_ajusted, CWD16_ajusted, CWD17_ajusted, CWD18_ajusted, CWD19_ajusted,
                 CWD20_ajusted, CWD21_ajusted, CWD22_ajusted, CWD23_ajusted, CWD24_ajusted)



#calcula a media CWD

rMean <- calc( CWD_Hist , fun = function(x){ by(x , c( rep(seq(1:45), times = 23)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

CWD_Hist_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 45)
head(dates)
tail(dates)

names(CWD_Hist_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(CWD_Hist_df, file = "CWD_Historical_mean.csv")

