require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/rx5day/rcp85")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
rx5day_1 <- nc_open("rx5dayETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")
print(rx5day_1)

# tempo
rx5day_time <- nc.get.time.series(rx5day_1, v="rx5dayETCCDI",
                              time.dim.name = "time")
head(rx5day_time)
tail(rx5day_time)

# get time
time <- ncvar_get(rx5day_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(rx5day_1,"time","units")
nt <- dim(time)

# rx5day analise
rx5day <- ncvar_get(rx5day_1, "rx5dayETCCDI")
head(rx5day)
tail(rx5day)

#Modelo ACCESS1

# transforma o NetCDF em Raster
rx5day1 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day1 = rotate(rx5day1) 

#recorte espacial da área de estudo
#rx5day1_mask = crop(rx5day1, brasil) 

#recorte temporal no dado
#rx5day1_slice = subset(rx5day1, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day1_ajusted = resample(rx5day1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
rx5day2 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_ACCESS1-3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day2 = rotate(rx5day2) 

#recorte espacial da área de estudo
#rx5day2_mask = crop(rx5day2, brasil) 

#recorte temporal no dado
#rx5day2_slice = subset(rx5day2, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day2_ajusted = resample(rx5day2, rp, method='bilinear')


# transforma o NetCDF em Raster
rx5day3 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_bcc-csm1-1_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day3 = rotate(rx5day3) 

#recorte espacial da área de estudo
#rx5day3_mask = crop(rx5day3, brasil) 

#recorte temporal no dado
rx5day3_slice = subset(rx5day3, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day3_ajusted = resample(rx5day3_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day4 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_bcc-csm1-1-m_rcp85_r1i1p1_2006-2099.nc")

#transforma a longitude de 0-360 para -180-180
rx5day4 = rotate(rx5day4) 

#recorte espacial da área de estudo
#rx5day4_mask = crop(rx5day4, brasil) 

#recorte temporal no dado
#rx5day4_slice = subset(rx5day4, 12:56) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day4_ajusted = resample(rx5day4, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day5 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_BNU-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day5 = rotate(rx5day5) 

#recorte espacial da área de estudo
#rx5day5_mask = crop(rx5day5, brasil) 

#recorte temporal no dado
#rx5day5_slice = subset(rx5day5, 1:85) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day5_ajusted = resample(rx5day5, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day6 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CanESM2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day6 = rotate(rx5day6) 

#recorte espacial da área de estudo
#rx5day6_mask = crop(rx5day6, brasil) 

#recorte temporal no dado
#rx5day6_slice = subset(rx5day6, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day6_ajusted = resample(rx5day6, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day7 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CCSM4_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day7 = rotate(rx5day7) 

#recorte espacial da área de estudo
#rx5day7_mask = crop(rx5day7, brasil) 

#recorte temporal no dado
rx5day7_slice = subset(rx5day7, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day7_ajusted = resample(rx5day7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day8 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CMCC-CESM_rcp85_r1i1p1_2000-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day8 = rotate(rx5day8) 

#recorte espacial da área de estudo
#rx5day8_mask = crop(rx5day8, brasil) 

#recorte temporal no dado
rx5day8_slice = subset(rx5day8, 7:101) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day8_ajusted = resample(rx5day8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day9 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CMCC-CM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day9 = rotate(rx5day9) 

#recorte espacial da área de estudo
#rx5day9_mask = crop(rx5day9, brasil) 

#recorte temporal no dado
#rx5day9_slice = subset(rx5day9, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day9_ajusted = resample(rx5day9, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day10 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CMCC-CMS_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day10 = rotate(rx5day10) 

#recorte espacial da área de estudo
#rx5day10_mask = crop(rx5day10, brasil) 

#recorte temporal no dado
#rx5day10_slice = subset(rx5day10, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day10_ajusted = resample(rx5day10, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day11 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CNRM-CM5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day11 = rotate(rx5day11) 

#recorte espacial da área de estudo
#rx5day11_mask = crop(rx5day11, brasil) 

#recorte temporal no dado
rx5day11_slice = subset(rx5day11, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day11_ajusted = resample(rx5day11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day12 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_CSIRO-Mk3-6-0_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day12 = rotate(rx5day12) 

#recorte espacial da área de estudo
#rx5day11_mask = crop(rx5day11, brasil) 

#recorte temporal no dado
rx5day12_slice = subset(rx5day12, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day12_ajusted = resample(rx5day12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day13 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_FGOALS-s2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day13 = rotate(rx5day13) 

#recorte espacial da área de estudo
#rx5day13_mask = crop(rx5day13, brasil) 

#recorte temporal no dado
rx5day13_slice = subset(rx5day13, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day13_ajusted = resample(rx5day13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day14 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_GFDL-CM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day14 = rotate(rx5day14) 

#recorte espacial da área de estudo
#rx5day15_mask = crop(rx5day15, brasil) 

#recorte temporal no dado
#rx5day14_slice = subset(rx5day14, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day14_ajusted = resample(rx5day14, rp, method="bilinear")



# transforma o NetCDF em Raster
rx5day15 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_HadGEM2-CC_rcp85_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day15 = rotate(rx5day15) 

#recorte espacial da área de estudo
#rx5day15_mask = crop(rx5day15, brasil) 

#recorte temporal no dado
rx5day15_slice = subset(rx5day15, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day15_ajusted = resample(rx5day15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day16 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_HadGEM2-ES_rcp85_r1i1p1_2005-2299.nc")

#transforma a longitude de 0-360 para -180-180
rx5day16 = rotate(rx5day16) 

#recorte espacial da área de estudo
#rx5day16_mask = crop(rx5day16, brasil) 

#recorte temporal no dado
rx5day16_slice = subset(rx5day16, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day16_ajusted = resample(rx5day16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day17 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_inmcm4_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day17 = rotate(rx5day17) 

#recorte espacial da área de estudo
#rx5day17_mask = crop(rx5day17, brasil) 

#recorte temporal no dado
#rx5day17_slice = subset(rx5day17, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day17_ajusted = resample(rx5day17, rp, method="bilinear")



# transforma o NetCDF em Raster
rx5day18 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_IPSL-CM5A-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day18 = rotate(rx5day18) 

#recorte espacial da área de estudo
#rx5day18_mask = crop(rx5day18, brasil) 

#recorte temporal no dado
rx5day18_slice = subset(rx5day18, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day18_ajusted = resample(rx5day18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day19 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_IPSL-CM5A-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day19 = rotate(rx5day19) 

#recorte espacial da área de estudo
#rx5day19_mask = crop(rx5day19, brasil) 

#recorte temporal no dado
#rx5day19_slice = subset(rx5day19, 103:147) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day19_ajusted = resample(rx5day19, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day20 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_IPSL-CM5B-LR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day20 = rotate(rx5day20) 

#recorte espacial da área de estudo
#rx5day20_mask = crop(rx5day20, brasil) 

#recorte temporal no dado
#rx5day20_slice = subset(rx5day20, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day20_ajusted = resample(rx5day20, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day21 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MIROC5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day21 = rotate(rx5day21) 

#recorte espacial da área de estudo
#rx5day21_mask = crop(rx5day21, brasil) 

#recorte temporal no dado
#rx5day21_slice = subset(rx5day21, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day21_ajusted = resample(rx5day21, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day22 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MIROC-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day22 = rotate(rx5day22) 

#recorte espacial da área de estudo
#rx5day22_mask = crop(rx5day22, brasil) 

#recorte temporal no dado
#rx5day22_slice = subset(rx5day22, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day22_ajusted = resample(rx5day22, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day23 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MIROC-ESM-CHEM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day23 = rotate(rx5day23) 

#recorte espacial da área de estudo
#rx5day23_mask = crop(rx5day23, brasil) 

#recorte temporal no dado
#rx5day23_slice = subset(rx5day23, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day23_ajusted = resample(rx5day23, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day24 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MPI-ESM-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day24 = rotate(rx5day24) 

#recorte espacial da área de estudo
#rx5day24_mask = crop(rx5day24, brasil) 

#recorte temporal no dado
rx5day24_slice = subset(rx5day24, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day24_ajusted = resample(rx5day24_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day25 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MPI-ESM-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day25 = rotate(rx5day25) 

#recorte espacial da área de estudo
#rx5day25_mask = crop(rx5day25, brasil) 

#recorte temporal no dado
#rx5day25_slice = subset(rx5day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day25_ajusted = resample(rx5day25, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day26 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_MRI-CGCM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day26 = rotate(rx5day25) 

#recorte espacial da área de estudo
#rx5day25_mask = crop(rx5day25, brasil) 

#recorte temporal no dado
#rx5day26_slice = subset(rx5day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day26_ajusted = resample(rx5day26, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day27 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp85/rx5dayETCCDI_yr_NorESM1-M_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day27 = rotate(rx5day27) 

#recorte espacial da área de estudo
#rx5day25_mask = crop(rx5day25, brasil) 

#recorte temporal no dado
#rx5day25_slice = subset(rx5day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day27_ajusted = resample(rx5day27, rp, method="bilinear")



#cria lista de rasters
rx5day_rcp85 = stack(rx5day1_ajusted, rx5day2_ajusted, rx5day3_ajusted, rx5day5_ajusted,
                 rx5day6_ajusted, rx5day7_ajusted, rx5day8_ajusted, rx5day9_ajusted, rx5day10_ajusted,
                 rx5day11_ajusted, rx5day12_ajusted, rx5day13_ajusted, rx5day14_ajusted, rx5day15_ajusted, 
                 rx5day16_ajusted, rx5day17_ajusted, rx5day18_ajusted, rx5day19_ajusted, rx5day20_ajusted, 
                 rx5day21_ajusted, rx5day22_ajusted, rx5day23_ajusted, rx5day24_ajusted, rx5day25_ajusted,
                 rx5day26_ajusted, rx5day27_ajusted)


#calcula a media rx5day

rMean <- calc( rx5day_rcp85 , fun = function(x){ by(x , c( rep(seq(1:95), times = 26)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

rx5day_rcp85_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(rx5day_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(rx5day_rcp85_df, file = "rx5day_rcp85_mean.csv")

