require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/CDD/Historical")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
CDD_1 <- nc_open("cddETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")
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
CDD1 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD1 = rotate(CDD1) 

#recorte espacial da área de estudo
#CDD1_mask = crop(CDD1, brasil) 

#recorte temporal no dado
CDD1_slice = subset(CDD1, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD1_ajusted = resample(CDD1_slice, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
CDD2 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_bcc-csm1-1_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
CDD2 = rotate(CDD2) 

#recorte espacial da área de estudo
#CDD2_mask = crop(CDD2, brasil) 

#recorte temporal no dado
CDD2_slice = subset(CDD2, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD2_ajusted = resample(CDD2_slice, rp, method='bilinear')


# transforma o NetCDF em Raster
CDD3 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_bcc-csm1-1-m_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
CDD3 = rotate(CDD3) 

#recorte espacial da área de estudo
#CDD3_mask = crop(CDD3, brasil) 

#recorte temporal no dado
CDD3_slice = subset(CDD3, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD3_ajusted = resample(CDD3_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD4 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_BNU-ESM_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD4 = rotate(CDD4) 

#recorte espacial da área de estudo
#CDD4_mask = crop(CDD4, brasil) 

#recorte temporal no dado
CDD4_slice = subset(CDD4, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD4_ajusted = resample(CDD4_slice, rp, method="bilinear")

# transforma o NetCDF em Raster
CDD5 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CanCM4_historical_r1i1p1_1961-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD5 = rotate(CDD5) 

#recorte espacial da área de estudo
#CDD5_mask = crop(CDD5, brasil) 

#recorte temporal no dado
CDD5_slice = subset(CDD5, 1:45) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD5_ajusted = resample(CDD5_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
CDD6 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CanESM2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD6 = rotate(CDD6) 

#recorte espacial da área de estudo
#CDD6_mask = crop(CDD6, brasil) 

#recorte temporal no dado
CDD6_slice = subset(CDD6, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD6_ajusted = resample(CDD6_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD7 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CCSM4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD7 = rotate(CDD7) 

#recorte espacial da área de estudo
#CDD7_mask = crop(CDD7, brasil) 

#recorte temporal no dado
CDD7_slice = subset(CDD7, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD7_ajusted = resample(CDD7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD8 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CESM1-FASTCHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD8 = rotate(CDD8) 

#recorte espacial da área de estudo
#CDD8_mask = crop(CDD8, brasil) 

#recorte temporal no dado
CDD8_slice = subset(CDD8, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD8_ajusted = resample(CDD8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD9 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CMCC-CESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD9 = rotate(CDD9) 

#recorte espacial da área de estudo
#CDD9_mask = crop(CDD9, brasil) 

#recorte temporal no dado
CDD9_slice = subset(CDD9, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD9_ajusted = resample(CDD9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD10 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CMCC-CM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD10 = rotate(CDD10) 

#recorte espacial da área de estudo
#CDD10_mask = crop(CDD10, brasil) 

#recorte temporal no dado
CDD10_slice = subset(CDD10, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD10_ajusted = resample(CDD10_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD11 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CMCC-CMS_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD11 = rotate(CDD11) 

#recorte espacial da área de estudo
#CDD11_mask = crop(CDD11, brasil) 

#recorte temporal no dado
CDD11_slice = subset(CDD11, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD11_ajusted = resample(CDD11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD12 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CNRM-CM5_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD12 = rotate(CDD12) 

#recorte espacial da área de estudo
#CDD12_mask = crop(CDD12, brasil) 

#recorte temporal no dado
CDD12_slice = subset(CDD12, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD12_ajusted = resample(CDD12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD13 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_CSIRO-Mk3-6-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD13 = rotate(CDD13) 

#recorte espacial da área de estudo
#CDD13_mask = crop(CDD13, brasil) 

#recorte temporal no dado
CDD13_slice = subset(CDD13, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD13_ajusted = resample(CDD13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD15 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_FGOALS-s2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD15 = rotate(CDD15) 

#recorte espacial da área de estudo
#CDD15_mask = crop(CDD15, brasil) 

#recorte temporal no dado
CDD15_slice = subset(CDD15, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD15_ajusted = resample(CDD15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD16 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_GFDL-CM3_historical_r1i1p1_1860-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD16 = rotate(CDD16) 

#recorte espacial da área de estudo
#CDD16_mask = crop(CDD16, brasil) 

#recorte temporal no dado
CDD16_slice = subset(CDD16, 102:146) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD16_ajusted = resample(CDD16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD17 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_HadCM3_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD17 = rotate(CDD17) 

#recorte espacial da área de estudo
#CDD17_mask = crop(CDD17, brasil) 

#recorte temporal no dado
CDD17_slice = subset(CDD17, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD17_ajusted = resample(CDD17_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
CDD18 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_HadGEM2-CC_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD18 = rotate(CDD18) 

#recorte espacial da área de estudo
#CDD18_mask = crop(CDD18, brasil) 

#recorte temporal no dado
CDD18_slice = subset(CDD18, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD18_ajusted = resample(CDD18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD19 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_HadGEM2-ES_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD19 = rotate(CDD19) 

#recorte espacial da área de estudo
#CDD19_mask = crop(CDD19, brasil) 

#recorte temporal no dado
CDD19_slice = subset(CDD19, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD19_ajusted = resample(CDD19_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD20 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_inmcm4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD20 = rotate(CDD20) 

#recorte espacial da área de estudo
#CDD20_mask = crop(CDD20, brasil) 

#recorte temporal no dado
CDD20_slice = subset(CDD20, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD20_ajusted = resample(CDD20_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD21 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_IPSL-CM5A-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD21 = rotate(CDD21) 

#recorte espacial da área de estudo
#CDD21_mask = crop(CDD21, brasil) 

#recorte temporal no dado
CDD21_slice = subset(CDD21, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD21_ajusted = resample(CDD21_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD22 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_IPSL-CM5A-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD22 = rotate(CDD22) 

#recorte espacial da área de estudo
#CDD22_mask = crop(CDD22, brasil) 

#recorte temporal no dado
CDD22_slice = subset(CDD22, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD22_ajusted = resample(CDD22_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD23 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_IPSL-CM5B-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD23 = rotate(CDD23) 

#recorte espacial da área de estudo
#CDD23_mask = crop(CDD23, brasil) 

#recorte temporal no dado
CDD23_slice = subset(CDD23, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD23_ajusted = resample(CDD23_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD24 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MIROC4h_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD24 = rotate(CDD24) 

#recorte espacial da área de estudo
#CDD24_mask = crop(CDD24, brasil) 

#recorte temporal no dado
CDD24_slice = subset(CDD24, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD24_ajusted = resample(CDD24_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD25 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MIROC5_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
CDD25 = rotate(CDD25) 

#recorte espacial da área de estudo
#CDD25_mask = crop(CDD25, brasil) 

#recorte temporal no dado
CDD25_slice = subset(CDD25, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD25_ajusted = resample(CDD25_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD26 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MIROC-ESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD26 = rotate(CDD26) 

#recorte espacial da área de estudo
#CDD26_mask = crop(CDD26, brasil) 

#recorte temporal no dado
CDD26_slice = subset(CDD26, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD26_ajusted = resample(CDD26_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD27 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MIROC-ESM-CHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD27 = rotate(CDD27) 

#recorte espacial da área de estudo
#CDD27_mask = crop(CDD27, brasil) 

#recorte temporal no dado
CDD27_slice = subset(CDD27, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD27_ajusted = resample(CDD27_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD28 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MPI-ESM-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD28 = rotate(CDD28) 

#recorte espacial da área de estudo
#CDD28_mask = crop(CDD28, brasil) 

#recorte temporal no dado
CDD28_slice = subset(CDD28, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD28_ajusted = resample(CDD28_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD29 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MPI-ESM-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD29 = rotate(CDD29) 

#recorte espacial da área de estudo
#CDD29_mask = crop(CDD29, brasil) 

#recorte temporal no dado
CDD29_slice = subset(CDD29, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD29_ajusted = resample(CDD29_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD30 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MPI-ESM-P_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD30 = rotate(CDD30) 

#recorte espacial da área de estudo
#CDD30_mask = crop(CDD30, brasil) 

#recorte temporal no dado
CDD30_slice = subset(CDD30, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD30_ajusted = resample(CDD30_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD31 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_MRI-CGCM3_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD31 = rotate(CDD31) 

#recorte espacial da área de estudo
#CDD31_mask = crop(CDD31, brasil) 

#recorte temporal no dado
CDD31_slice = subset(CDD31, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD31_ajusted = resample(CDD31_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
CDD32 = brick("C:/Users/inpe-eba/SISMOI/CDD/Historical/cddETCCDI_yr_NorESM1-M_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
CDD32 = rotate(CDD32) 

#recorte espacial da área de estudo
#CDD32_mask = crop(CDD32, brasil) 

#recorte temporal no dado
CDD32_slice = subset(CDD32, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
CDD32_ajusted = resample(CDD32_slice, rp, method="bilinear")



#cria lista de rasters
CDD_Hist = stack(CDD1_ajusted, CDD2_ajusted, CDD3_ajusted, CDD4_ajusted, CDD5_ajusted,
                 CDD6_ajusted, CDD7_ajusted, CDD8_ajusted, CDD9_ajusted, CDD10_ajusted,
                 CDD11_ajusted, CDD12_ajusted, CDD13_ajusted, 
                 CDD15_ajusted, CDD16_ajusted, CDD17_ajusted, CDD18_ajusted, CDD19_ajusted,
                 CDD20_ajusted, CDD21_ajusted, CDD22_ajusted, CDD23_ajusted, CDD24_ajusted, 
                 CDD25_ajusted, CDD26_ajusted, CDD27_ajusted, CDD28_ajusted, CDD29_ajusted, 
                 CDD30_ajusted, CDD31_ajusted, CDD32_ajusted)



#calcula a media CDD

rMean <- calc( CDD_Hist , fun = function(x){ by(x , c( rep(seq(1:45), times = 31)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

CDD_Hist_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 45)
head(dates)
tail(dates)

names(CDD_Hist_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(CDD_Hist_df, file = "CDD_Historical_mean.csv")

