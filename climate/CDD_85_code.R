require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/CDD/rcp85")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
CDD_1 <- nc_open("cddETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")
print(CDD_1)

# tempo
CDD_time <- nc.get.time.series(CDD_1, v="cddETCCDI",
                              time.dim.name = "time")
head(CDD_time)
tail(CDD_time)

# get time
time <- ncvar_get(CDD_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(CDD_1,"time","units")
nt <- dim(time)

# CDD analise
CDD <- ncvar_get(CDD_1, "cddETCCDI")
head(CDD)
tail(CDD)

#Modelo ACCESS1

# transforma o NetCDF em Raster
CDD1 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD1 = rotate(CDD1) 

#recorte espacial da área de estudo
#CDD1_mask = crop(CDD1, brasil) 

#recorte temporal no dado
#CDD1_slice = subset(CDD1, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD1_ajusted = resample(CDD1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
CDD2 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_ACCESS1-3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD2 = rotate(CDD2) 

#recorte espacial da área de estudo
#CDD2_mask = crop(CDD2, brasil) 

#recorte temporal no dado
#CDD2_slice = subset(CDD2, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD2_ajusted = resample(CDD2, rp, method='bilinear')


# transforma o NetCDF em Raster
CDD3 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_bcc-csm1-1_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CDD3 = rotate(CDD3) 

#recorte espacial da área de estudo
#CDD3_mask = crop(CDD3, brasil) 

#recorte temporal no dado
CDD3_slice = subset(CDD3, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD3_ajusted = resample(CDD3_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
#CDD4 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_bcc-csm1-1-m_rcp85_r1i1p1_2006-2099.nc")

#transforma a longitude de 0-360 para -180-180
#CDD4 = rotate(CDD4) 

#recorte espacial da área de estudo
#CDD4_mask = crop(CDD4, brasil) 

#recorte temporal no dado
#CDD4_slice = subset(CDD4, 12:56) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
#CDD4_ajusted = resample(CDD4, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD5 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_BNU-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD5 = rotate(CDD5) 

#recorte espacial da área de estudo
#CDD5_mask = crop(CDD5, brasil) 

#recorte temporal no dado
#CDD5_slice = subset(CDD5, 1:85) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD5_ajusted = resample(CDD5, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD6 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CanESM2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD6 = rotate(CDD6) 

#recorte espacial da área de estudo
#CDD6_mask = crop(CDD6, brasil) 

#recorte temporal no dado
#CDD6_slice = subset(CDD6, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD6_ajusted = resample(CDD6, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD7 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CCSM4_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CDD7 = rotate(CDD7) 

#recorte espacial da área de estudo
#CDD7_mask = crop(CDD7, brasil) 

#recorte temporal no dado
CDD7_slice = subset(CDD7, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD7_ajusted = resample(CDD7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD8 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CMCC-CM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD8 = rotate(CDD8) 

#recorte espacial da área de estudo
#CDD8_mask = crop(CDD8, brasil) 

#recorte temporal no dado
#CDD8_slice = subset(CDD8, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD8_ajusted = resample(CDD8, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD9 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CMCC-CMS_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD9 = rotate(CDD9) 

#recorte espacial da área de estudo
#CDD9_mask = crop(CDD9, brasil) 

#recorte temporal no dado
#CDD9_slice = subset(CDD9, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD9_ajusted = resample(CDD9, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD10 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CNRM-CM5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD10 = rotate(CDD10) 

#recorte espacial da área de estudo
#CDD10_mask = crop(CDD10, brasil) 

#recorte temporal no dado
#CDD10_slice = subset(CDD10, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD10_ajusted = resample(CDD10, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD11 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CSIRO-Mk3-6-0_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CDD11 = rotate(CDD11) 

#recorte espacial da área de estudo
#CDD11_mask = crop(CDD11, brasil) 

#recorte temporal no dado
CDD11_slice = subset(CDD11, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD11_ajusted = resample(CDD11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD12 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_CMCC-CESM_rcp85_r1i1p1_2000-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD12 = rotate(CDD12) 

#recorte espacial da área de estudo
#CDD11_mask = crop(CDD11, brasil) 

#recorte temporal no dado
CDD12_slice = subset(CDD12, 7:101) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD12_ajusted = resample(CDD12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD13 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_FGOALS-s2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD13 = rotate(CDD13) 

#recorte espacial da área de estudo
#CDD13_mask = crop(CDD13, brasil) 

#recorte temporal no dado
#CDD13_slice = subset(CDD13, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD13_ajusted = resample(CDD13, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD14 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_GFDL-CM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD14 = rotate(CDD14) 

#recorte espacial da área de estudo
#CDD15_mask = crop(CDD15, brasil) 

#recorte temporal no dado
#CDD14_slice = subset(CDD14, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD14_ajusted = resample(CDD14, rp, method="bilinear")



# transforma o NetCDF em Raster
CDD15 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_HadGEM2-CC_rcp85_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD15 = rotate(CDD15) 

#recorte espacial da área de estudo
#CDD15_mask = crop(CDD15, brasil) 

#recorte temporal no dado
CDD15_slice = subset(CDD15, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD15_ajusted = resample(CDD15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD16 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_HadGEM2-ES_rcp85_r1i1p1_2005-2299.nc")

#transforma a longitude de 0-360 para -180-180
CDD16 = rotate(CDD16) 

#recorte espacial da área de estudo
#CDD16_mask = crop(CDD16, brasil) 

#recorte temporal no dado
CDD16_slice = subset(CDD16, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD16_ajusted = resample(CDD16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD17 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_inmcm4_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD17 = rotate(CDD17) 

#recorte espacial da área de estudo
#CDD17_mask = crop(CDD17, brasil) 

#recorte temporal no dado
#CDD17_slice = subset(CDD17, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD17_ajusted = resample(CDD17, rp, method="bilinear")



# transforma o NetCDF em Raster
CDD18 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_IPSL-CM5A-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CDD18 = rotate(CDD18) 

#recorte espacial da área de estudo
#CDD18_mask = crop(CDD18, brasil) 

#recorte temporal no dado
CDD18_slice = subset(CDD18, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD18_ajusted = resample(CDD18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD19 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_IPSL-CM5A-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD19 = rotate(CDD19) 

#recorte espacial da área de estudo
#CDD19_mask = crop(CDD19, brasil) 

#recorte temporal no dado
#CDD19_slice = subset(CDD19, 103:147) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD19_ajusted = resample(CDD19, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD20 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_IPSL-CM5B-LR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD20 = rotate(CDD20) 

#recorte espacial da área de estudo
#CDD20_mask = crop(CDD20, brasil) 

#recorte temporal no dado
#CDD20_slice = subset(CDD20, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD20_ajusted = resample(CDD20, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD21 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MIROC5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD21 = rotate(CDD21) 

#recorte espacial da área de estudo
#CDD21_mask = crop(CDD21, brasil) 

#recorte temporal no dado
#CDD21_slice = subset(CDD21, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD21_ajusted = resample(CDD21, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD22 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MIROC-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD22 = rotate(CDD22) 

#recorte espacial da área de estudo
#CDD22_mask = crop(CDD22, brasil) 

#recorte temporal no dado
#CDD22_slice = subset(CDD22, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD22_ajusted = resample(CDD22, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD23 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MIROC-ESM-CHEM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD23 = rotate(CDD23) 

#recorte espacial da área de estudo
#CDD23_mask = crop(CDD23, brasil) 

#recorte temporal no dado
#CDD23_slice = subset(CDD23, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD23_ajusted = resample(CDD23, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD24 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MPI-ESM-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
CDD24 = rotate(CDD24) 

#recorte espacial da área de estudo
#CDD24_mask = crop(CDD24, brasil) 

#recorte temporal no dado
CDD24_slice = subset(CDD24, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD24_ajusted = resample(CDD24_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD25 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MPI-ESM-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD25 = rotate(CDD25) 

#recorte espacial da área de estudo
#CDD25_mask = crop(CDD25, brasil) 

#recorte temporal no dado
#CDD25_slice = subset(CDD25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD25_ajusted = resample(CDD25, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD26 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_MRI-CGCM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD26 = rotate(CDD25) 

#recorte espacial da área de estudo
#CDD25_mask = crop(CDD25, brasil) 

#recorte temporal no dado
#CDD26_slice = subset(CDD25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD26_ajusted = resample(CDD26, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD27 = brick("C:/Users/inpe-eba/SISMOI/CDD/rcp85/cddETCCDI_yr_NorESM1-M_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
CDD27 = rotate(CDD27) 

#recorte espacial da área de estudo
#CDD25_mask = crop(CDD25, brasil) 

#recorte temporal no dado
#CDD25_slice = subset(CDD25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD27_ajusted = resample(CDD27, rp, method="bilinear")



#cria lista de rasters
CDD_rcp85 = stack(CDD1_ajusted, CDD2_ajusted, CDD3_ajusted, CDD5_ajusted,
                 CDD6_ajusted, CDD7_ajusted, CDD8_ajusted, CDD9_ajusted, CDD10_ajusted,
                 CDD11_ajusted, CDD12_ajusted, CDD13_ajusted, CDD14_ajusted, CDD15_ajusted, 
                 CDD16_ajusted, CDD17_ajusted, CDD18_ajusted, CDD19_ajusted, CDD20_ajusted, 
                 CDD21_ajusted, CDD22_ajusted, CDD23_ajusted, CDD24_ajusted, CDD25_ajusted,
                 CDD26_ajusted, CDD27_ajusted)


#calcula a media CDD

rMean <- calc( CDD_rcp85 , fun = function(x){ by(x , c( rep(seq(1:95), times = 26)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

CDD_rcp85_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(CDD_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(CDD_rcp85_df, file = "CDD_rcp85_mean.csv")

