require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/r95p/Historical")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
r95p_1 <- nc_open("r95pETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")
print(r95p_1)

# tempo
r95p_time <- nc.get.time.series(r95p_1, v="r95pETCCDI",
                              time.dim.name = "time")
head(r95p_time)
tail(r95p_time)

# get time
time <- ncvar_get(r95p_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(r95p_1,"time","units")
nt <- dim(time)

# r95p analise
r95p <- ncvar_get(r95p_1, "r95pETCCDI")
head(r95p)
tail(r95p)

#Modelo ACCESS1

# transforma o NetCDF em Raster
r95p1 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p1 = rotate(r95p1) 

#recorte espacial da área de estudo
#r95p1_mask = crop(r95p1, brasil) 

#recorte temporal no dado
r95p1_slice = subset(r95p1, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p1_ajusted = resample(r95p1_slice, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
r95p2 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_BNU-ESM_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p2 = rotate(r95p2) 

#recorte espacial da área de estudo
#r95p2_mask = crop(r95p2, brasil) 

#recorte temporal no dado
r95p2_slice = subset(r95p2, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p2_ajusted = resample(r95p2_slice, rp, method='bilinear')


# transforma o NetCDF em Raster
r95p3 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CanCM4_historical_r1i1p1_1961-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p3 = rotate(r95p3) 

#recorte espacial da área de estudo
#r95p3_mask = crop(r95p3, brasil) 

#recorte temporal no dado
#r95p3_slice = subset(r95p3, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p3_ajusted = resample(r95p3, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p4 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CanESM2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p4 = rotate(r95p4) 

#recorte espacial da área de estudo
#r95p4_mask = crop(r95p4, brasil) 

#recorte temporal no dado
r95p4_slice = subset(r95p4, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p4_ajusted = resample(r95p4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p5 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CCSM4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p5 = rotate(r95p5) 

#recorte espacial da área de estudo
#r95p5_mask = crop(r95p5, brasil) 

#recorte temporal no dado
r95p5_slice = subset(r95p5, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p5_ajusted = resample(r95p5_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
r95p6 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CESM1-FASTCHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p6 = rotate(r95p6) 

#recorte espacial da área de estudo
#r95p6_mask = crop(r95p6, brasil) 

#recorte temporal no dado
r95p6_slice = subset(r95p6, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p6_ajusted = resample(r95p6_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p7 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CMCC-CESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p7 = rotate(r95p7) 

#recorte espacial da área de estudo
#r95p7_mask = crop(r95p7, brasil) 

#recorte temporal no dado
r95p7_slice = subset(r95p7, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p7_ajusted = resample(r95p7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p8 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CMCC-CM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p8 = rotate(r95p8) 

#recorte espacial da área de estudo
#r95p8_mask = crop(r95p8, brasil) 

#recorte temporal no dado
r95p8_slice = subset(r95p8, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p8_ajusted = resample(r95p8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p9 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CMCC-CMS_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p9 = rotate(r95p9) 

#recorte espacial da área de estudo
#r95p9_mask = crop(r95p9, brasil) 

#recorte temporal no dado
r95p9_slice = subset(r95p9, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p9_ajusted = resample(r95p9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p10 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CNRM-CM5_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p10 = rotate(r95p10) 

#recorte espacial da área de estudo
#r95p10_mask = crop(r95p10, brasil) 

#recorte temporal no dado
r95p10_slice = subset(r95p10, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p10_ajusted = resample(r95p10_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p11 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_CSIRO-Mk3-6-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p11 = rotate(r95p11) 

#recorte espacial da área de estudo
#r95p11_mask = crop(r95p11, brasil) 

#recorte temporal no dado
r95p11_slice = subset(r95p11, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p11_ajusted = resample(r95p11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p12 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_FGOALS-s2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p12 = rotate(r95p12) 

#recorte espacial da área de estudo
#r95p12_mask = crop(r95p12, brasil) 

#recorte temporal no dado
r95p12_slice = subset(r95p12, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p12_ajusted = resample(r95p12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p13 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_GFDL-CM3_historical_r1i1p1_1860-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p13 = rotate(r95p13) 

#recorte espacial da área de estudo
#r95p13_mask = crop(r95p13, brasil) 

#recorte temporal no dado
r95p13_slice = subset(r95p13, 102:146) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p13_ajusted = resample(r95p13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p15 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_HadCM3_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p15 = rotate(r95p15) 

#recorte espacial da área de estudo
#r95p15_mask = crop(r95p15, brasil) 

#recorte temporal no dado
r95p15_slice = subset(r95p15, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p15_ajusted = resample(r95p15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p16 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_HadGEM2-CC_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p16 = rotate(r95p16) 

#recorte espacial da área de estudo
#r95p16_mask = crop(r95p16, brasil) 

#recorte temporal no dado
r95p16_slice = subset(r95p16, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p16_ajusted = resample(r95p16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p17 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_HadGEM2-ES_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p17 = rotate(r95p17) 

#recorte espacial da área de estudo
#r95p17_mask = crop(r95p17, brasil) 

#recorte temporal no dado
r95p17_slice = subset(r95p17, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p17_ajusted = resample(r95p17_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p18 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_IPSL-CM5A-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p18 = rotate(r95p18) 

#recorte espacial da área de estudo
#r95p18_mask = crop(r95p18, brasil) 

#recorte temporal no dado
r95p18_slice = subset(r95p18, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p18_ajusted = resample(r95p18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p19 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_IPSL-CM5A-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p19 = rotate(r95p19) 

#recorte espacial da área de estudo
#r95p19_mask = crop(r95p19, brasil) 

#recorte temporal no dado
r95p19_slice = subset(r95p19, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p19_ajusted = resample(r95p19_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p20 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_IPSL-CM5B-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p20 = rotate(r95p20) 

#recorte espacial da área de estudo
#r95p20_mask = crop(r95p20, brasil) 

#recorte temporal no dado
r95p20_slice = subset(r95p20, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p20_ajusted = resample(r95p20_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p21 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_MIROC4h_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p21 = rotate(r95p21) 

#recorte espacial da área de estudo
#r95p21_mask = crop(r95p21, brasil) 

#recorte temporal no dado
r95p21_slice = subset(r95p21, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p21_ajusted = resample(r95p21_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p22 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_MIROC5_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
r95p22 = rotate(r95p22) 

#recorte espacial da área de estudo
#r95p22_mask = crop(r95p22, brasil) 

#recorte temporal no dado
r95p22_slice = subset(r95p22, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p22_ajusted = resample(r95p22_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p23 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_MIROC-ESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p23 = rotate(r95p23) 

#recorte espacial da área de estudo
#r95p23_mask = crop(r95p23, brasil) 

#recorte temporal no dado
r95p23_slice = subset(r95p23, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p23_ajusted = resample(r95p23_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
r95p24 = brick("C:/Users/inpe-eba/SISMOI/r95p/Historical/r95pETCCDI_yr_MIROC-ESM-CHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
r95p24 = rotate(r95p24) 

#recorte espacial da área de estudo
#r95p24_mask = crop(r95p24, brasil) 

#recorte temporal no dado
r95p24_slice = subset(r95p24, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
r95p24_ajusted = resample(r95p24_slice, rp, method="bilinear")




#cria lista de rasters
r95p_Hist = stack(r95p1_ajusted, r95p2_ajusted, r95p3_ajusted, r95p4_ajusted, r95p5_ajusted,
                 r95p6_ajusted, r95p7_ajusted, r95p8_ajusted, r95p9_ajusted, r95p10_ajusted,
                 r95p11_ajusted, r95p12_ajusted, r95p13_ajusted, 
                 r95p15_ajusted, r95p16_ajusted, r95p17_ajusted, r95p18_ajusted, r95p19_ajusted,
                 r95p20_ajusted, r95p21_ajusted, r95p22_ajusted, r95p23_ajusted, r95p24_ajusted)



#calcula a media r95p

rMean <- calc( r95p_Hist , fun = function(x){ by(x , c( rep(seq(1:45), times = 23)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

r95p_Hist_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 45)
head(dates)
tail(dates)

names(r95p_Hist_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(r95p_Hist_df, file = "r95p_Historical_mean.csv")

