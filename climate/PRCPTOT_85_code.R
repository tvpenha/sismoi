require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/prcptot/rcp85")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
prcptot_1 <- nc_open("prcptotETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")
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
prcptot1 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot1 = rotate(prcptot1) 

#recorte espacial da �rea de estudo
#prcptot1_mask = crop(prcptot1, brasil) 

#recorte temporal no dado
#prcptot1_slice = subset(prcptot1, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot1_ajusted = resample(prcptot1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
prcptot2 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_ACCESS1-3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot2 = rotate(prcptot2) 

#recorte espacial da �rea de estudo
#prcptot2_mask = crop(prcptot2, brasil) 

#recorte temporal no dado
#prcptot2_slice = subset(prcptot2, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot2_ajusted = resample(prcptot2, rp, method='bilinear')


# transforma o NetCDF em Raster
prcptot3 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_bcc-csm1-1_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot3 = rotate(prcptot3) 

#recorte espacial da �rea de estudo
#prcptot3_mask = crop(prcptot3, brasil) 

#recorte temporal no dado
prcptot3_slice = subset(prcptot3, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot3_ajusted = resample(prcptot3_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot4 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_bcc-csm1-1-m_rcp85_r1i1p1_2006-2099.nc")

#transforma a longitude de 0-360 para -180-180
prcptot4 = rotate(prcptot4) 

#recorte espacial da �rea de estudo
#prcptot4_mask = crop(prcptot4, brasil) 

#recorte temporal no dado
#prcptot4_slice = subset(prcptot4, 12:56) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot4_ajusted = resample(prcptot4, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot5 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_BNU-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot5 = rotate(prcptot5) 

#recorte espacial da �rea de estudo
#prcptot5_mask = crop(prcptot5, brasil) 

#recorte temporal no dado
#prcptot5_slice = subset(prcptot5, 1:85) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot5_ajusted = resample(prcptot5, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot6 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CanESM2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot6 = rotate(prcptot6) 

#recorte espacial da �rea de estudo
#prcptot6_mask = crop(prcptot6, brasil) 

#recorte temporal no dado
#prcptot6_slice = subset(prcptot6, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot6_ajusted = resample(prcptot6, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot7 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CCSM4_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot7 = rotate(prcptot7) 

#recorte espacial da �rea de estudo
#prcptot7_mask = crop(prcptot7, brasil) 

#recorte temporal no dado
prcptot7_slice = subset(prcptot7, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot7_ajusted = resample(prcptot7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot8 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CMCC-CESM_rcp85_r1i1p1_2000-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot8 = rotate(prcptot8) 

#recorte espacial da �rea de estudo
#prcptot8_mask = crop(prcptot8, brasil) 

#recorte temporal no dado
prcptot8_slice = subset(prcptot8, 7:101) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot8_ajusted = resample(prcptot8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot9 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CMCC-CM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot9 = rotate(prcptot9) 

#recorte espacial da �rea de estudo
#prcptot9_mask = crop(prcptot9, brasil) 

#recorte temporal no dado
#prcptot9_slice = subset(prcptot9, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot9_ajusted = resample(prcptot9, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot10 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CMCC-CMS_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot10 = rotate(prcptot10) 

#recorte espacial da �rea de estudo
#prcptot10_mask = crop(prcptot10, brasil) 

#recorte temporal no dado
#prcptot10_slice = subset(prcptot10, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot10_ajusted = resample(prcptot10, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot11 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CNRM-CM5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot11 = rotate(prcptot11) 

#recorte espacial da �rea de estudo
#prcptot11_mask = crop(prcptot11, brasil) 

#recorte temporal no dado
prcptot11_slice = subset(prcptot11, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot11_ajusted = resample(prcptot11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot12 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_CSIRO-Mk3-6-0_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot12 = rotate(prcptot12) 

#recorte espacial da �rea de estudo
#prcptot11_mask = crop(prcptot11, brasil) 

#recorte temporal no dado
prcptot12_slice = subset(prcptot12, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot12_ajusted = resample(prcptot12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot13 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_FGOALS-s2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot13 = rotate(prcptot13) 

#recorte espacial da �rea de estudo
#prcptot13_mask = crop(prcptot13, brasil) 

#recorte temporal no dado
prcptot13_slice = subset(prcptot13, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot13_ajusted = resample(prcptot13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot14 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_GFDL-CM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot14 = rotate(prcptot14) 

#recorte espacial da �rea de estudo
#prcptot15_mask = crop(prcptot15, brasil) 

#recorte temporal no dado
#prcptot14_slice = subset(prcptot14, 2:96) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot14_ajusted = resample(prcptot14, rp, method="bilinear")



# transforma o NetCDF em Raster
prcptot15 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_HadGEM2-CC_rcp85_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot15 = rotate(prcptot15) 

#recorte espacial da �rea de estudo
#prcptot15_mask = crop(prcptot15, brasil) 

#recorte temporal no dado
prcptot15_slice = subset(prcptot15, 2:96) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot15_ajusted = resample(prcptot15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot16 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_HadGEM2-ES_rcp85_r1i1p1_2005-2299.nc")

#transforma a longitude de 0-360 para -180-180
prcptot16 = rotate(prcptot16) 

#recorte espacial da �rea de estudo
#prcptot16_mask = crop(prcptot16, brasil) 

#recorte temporal no dado
prcptot16_slice = subset(prcptot16, 2:96) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot16_ajusted = resample(prcptot16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot17 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_inmcm4_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot17 = rotate(prcptot17) 

#recorte espacial da �rea de estudo
#prcptot17_mask = crop(prcptot17, brasil) 

#recorte temporal no dado
#prcptot17_slice = subset(prcptot17, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot17_ajusted = resample(prcptot17, rp, method="bilinear")



# transforma o NetCDF em Raster
prcptot18 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_IPSL-CM5A-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot18 = rotate(prcptot18) 

#recorte espacial da �rea de estudo
#prcptot18_mask = crop(prcptot18, brasil) 

#recorte temporal no dado
prcptot18_slice = subset(prcptot18, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot18_ajusted = resample(prcptot18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot19 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_IPSL-CM5A-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot19 = rotate(prcptot19) 

#recorte espacial da �rea de estudo
#prcptot19_mask = crop(prcptot19, brasil) 

#recorte temporal no dado
#prcptot19_slice = subset(prcptot19, 103:147) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot19_ajusted = resample(prcptot19, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot20 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_IPSL-CM5B-LR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot20 = rotate(prcptot20) 

#recorte espacial da �rea de estudo
#prcptot20_mask = crop(prcptot20, brasil) 

#recorte temporal no dado
#prcptot20_slice = subset(prcptot20, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot20_ajusted = resample(prcptot20, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot21 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MIROC5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot21 = rotate(prcptot21) 

#recorte espacial da �rea de estudo
#prcptot21_mask = crop(prcptot21, brasil) 

#recorte temporal no dado
#prcptot21_slice = subset(prcptot21, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot21_ajusted = resample(prcptot21, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot22 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MIROC-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot22 = rotate(prcptot22) 

#recorte espacial da �rea de estudo
#prcptot22_mask = crop(prcptot22, brasil) 

#recorte temporal no dado
#prcptot22_slice = subset(prcptot22, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot22_ajusted = resample(prcptot22, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot23 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MIROC-ESM-CHEM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot23 = rotate(prcptot23) 

#recorte espacial da �rea de estudo
#prcptot23_mask = crop(prcptot23, brasil) 

#recorte temporal no dado
#prcptot23_slice = subset(prcptot23, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot23_ajusted = resample(prcptot23, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot24 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MPI-ESM-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
prcptot24 = rotate(prcptot24) 

#recorte espacial da �rea de estudo
#prcptot24_mask = crop(prcptot24, brasil) 

#recorte temporal no dado
prcptot24_slice = subset(prcptot24, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot24_ajusted = resample(prcptot24_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot25 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MPI-ESM-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot25 = rotate(prcptot25) 

#recorte espacial da �rea de estudo
#prcptot25_mask = crop(prcptot25, brasil) 

#recorte temporal no dado
#prcptot25_slice = subset(prcptot25, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot25_ajusted = resample(prcptot25, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot26 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_MRI-CGCM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot26 = rotate(prcptot25) 

#recorte espacial da �rea de estudo
#prcptot25_mask = crop(prcptot25, brasil) 

#recorte temporal no dado
#prcptot26_slice = subset(prcptot25, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot26_ajusted = resample(prcptot26, rp, method="bilinear")


# transforma o NetCDF em Raster
prcptot27 = brick("C:/Users/inpe-eba/SISMOI/prcptot/rcp85/prcptotETCCDI_yr_NorESM1-M_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
prcptot27 = rotate(prcptot27) 

#recorte espacial da �rea de estudo
#prcptot25_mask = crop(prcptot25, brasil) 

#recorte temporal no dado
#prcptot25_slice = subset(prcptot25, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
prcptot27_ajusted = resample(prcptot27, rp, method="bilinear")



#cria lista de rasters
prcptot_rcp85 = stack(prcptot1_ajusted, prcptot2_ajusted, prcptot3_ajusted, prcptot5_ajusted,
                 prcptot6_ajusted, prcptot7_ajusted, prcptot8_ajusted, prcptot9_ajusted, prcptot10_ajusted,
                 prcptot11_ajusted, prcptot12_ajusted, prcptot13_ajusted, prcptot14_ajusted, prcptot15_ajusted, 
                 prcptot16_ajusted, prcptot17_ajusted, prcptot18_ajusted, prcptot19_ajusted, prcptot20_ajusted, 
                 prcptot21_ajusted, prcptot22_ajusted, prcptot23_ajusted, prcptot24_ajusted, prcptot25_ajusted,
                 prcptot26_ajusted, prcptot27_ajusted)


#calcula a media prcptot

rMean <- calc( prcptot_rcp85 , fun = function(x){ by(x , c( rep(seq(1:95), times = 26)) , mean, na.rm=TRUE ) }  )

#trasnforma��o do dado em dataframe

prcptot_rcp85_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(prcptot_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(prcptot_rcp85_df, file = "prcptot_rcp85_mean.csv")

