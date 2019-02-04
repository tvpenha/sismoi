require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/rx1day/rcp85")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
rx1day_1 <- nc_open("rx1dayETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")
print(rx1day_1)

# tempo
rx1day_time <- nc.get.time.series(rx1day_1, v="rx1dayETCCDI",
                              time.dim.name = "time")
head(rx1day_time)
tail(rx1day_time)

# get time
time <- ncvar_get(rx1day_1, "time")
time <- as.vector(time)

tunits <- ncatt_get(rx1day_1,"time","units")
nt <- dim(time)

# rx1day analise
rx1day <- ncvar_get(rx1day_1, "rx1dayETCCDI")
head(rx1day)
tail(rx1day)

#Modelo ACCESS1

# transforma o NetCDF em Raster
rx1day1 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_ACCESS1-0_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day1 = rotate(rx1day1) 

#recorte espacial da área de estudo
#rx1day1_mask = crop(rx1day1, brasil) 

#recorte temporal no dado
#rx1day1_slice = subset(rx1day1, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day1_ajusted = resample(rx1day1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
rx1day2 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_ACCESS1-3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day2 = rotate(rx1day2) 

#recorte espacial da área de estudo
#rx1day2_mask = crop(rx1day2, brasil) 

#recorte temporal no dado
#rx1day2_slice = subset(rx1day2, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day2_ajusted = resample(rx1day2, rp, method='bilinear')


# transforma o NetCDF em Raster
rx1day3 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_bcc-csm1-1_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx1day3 = rotate(rx1day3) 

#recorte espacial da área de estudo
#rx1day3_mask = crop(rx1day3, brasil) 

#recorte temporal no dado
rx1day3_slice = subset(rx1day3, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day3_ajusted = resample(rx1day3_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day4 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_bcc-csm1-1-m_rcp85_r1i1p1_2006-2099.nc")

#transforma a longitude de 0-360 para -180-180
rx1day4 = rotate(rx1day4) 

#recorte espacial da área de estudo
#rx1day4_mask = crop(rx1day4, brasil) 

#recorte temporal no dado
#rx1day4_slice = subset(rx1day4, 12:56) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day4_ajusted = resample(rx1day4, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day5 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_BNU-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day5 = rotate(rx1day5) 

#recorte espacial da área de estudo
#rx1day5_mask = crop(rx1day5, brasil) 

#recorte temporal no dado
#rx1day5_slice = subset(rx1day5, 1:85) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day5_ajusted = resample(rx1day5, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day6 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CanESM2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day6 = rotate(rx1day6) 

#recorte espacial da área de estudo
#rx1day6_mask = crop(rx1day6, brasil) 

#recorte temporal no dado
#rx1day6_slice = subset(rx1day6, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day6_ajusted = resample(rx1day6, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day7 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CCSM4_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx1day7 = rotate(rx1day7) 

#recorte espacial da área de estudo
#rx1day7_mask = crop(rx1day7, brasil) 

#recorte temporal no dado
rx1day7_slice = subset(rx1day7, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day7_ajusted = resample(rx1day7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day8 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CMCC-CESM_rcp85_r1i1p1_2000-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day8 = rotate(rx1day8) 

#recorte espacial da área de estudo
#rx1day8_mask = crop(rx1day8, brasil) 

#recorte temporal no dado
rx1day8_slice = subset(rx1day8, 7:101) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day8_ajusted = resample(rx1day8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day9 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CMCC-CM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day9 = rotate(rx1day9) 

#recorte espacial da área de estudo
#rx1day9_mask = crop(rx1day9, brasil) 

#recorte temporal no dado
#rx1day9_slice = subset(rx1day9, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day9_ajusted = resample(rx1day9, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day10 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CMCC-CMS_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day10 = rotate(rx1day10) 

#recorte espacial da área de estudo
#rx1day10_mask = crop(rx1day10, brasil) 

#recorte temporal no dado
#rx1day10_slice = subset(rx1day10, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day10_ajusted = resample(rx1day10, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day11 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CNRM-CM5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day11 = rotate(rx1day11) 

#recorte espacial da área de estudo
#rx1day11_mask = crop(rx1day11, brasil) 

#recorte temporal no dado
rx1day11_slice = subset(rx1day11, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day11_ajusted = resample(rx1day11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day12 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_CSIRO-Mk3-6-0_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx1day12 = rotate(rx1day12) 

#recorte espacial da área de estudo
#rx1day11_mask = crop(rx1day11, brasil) 

#recorte temporal no dado
rx1day12_slice = subset(rx1day12, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day12_ajusted = resample(rx1day12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day13 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_FGOALS-s2_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day13 = rotate(rx1day13) 

#recorte espacial da área de estudo
#rx1day13_mask = crop(rx1day13, brasil) 

#recorte temporal no dado
rx1day13_slice = subset(rx1day13, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day13_ajusted = resample(rx1day13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day14 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_GFDL-CM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day14 = rotate(rx1day14) 

#recorte espacial da área de estudo
#rx1day15_mask = crop(rx1day15, brasil) 

#recorte temporal no dado
#rx1day14_slice = subset(rx1day14, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day14_ajusted = resample(rx1day14, rp, method="bilinear")



# transforma o NetCDF em Raster
rx1day15 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_HadGEM2-CC_rcp85_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day15 = rotate(rx1day15) 

#recorte espacial da área de estudo
#rx1day15_mask = crop(rx1day15, brasil) 

#recorte temporal no dado
rx1day15_slice = subset(rx1day15, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day15_ajusted = resample(rx1day15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day16 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_HadGEM2-ES_rcp85_r1i1p1_2005-2299.nc")

#transforma a longitude de 0-360 para -180-180
rx1day16 = rotate(rx1day16) 

#recorte espacial da área de estudo
#rx1day16_mask = crop(rx1day16, brasil) 

#recorte temporal no dado
rx1day16_slice = subset(rx1day16, 2:96) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day16_ajusted = resample(rx1day16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day17 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_inmcm4_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day17 = rotate(rx1day17) 

#recorte espacial da área de estudo
#rx1day17_mask = crop(rx1day17, brasil) 

#recorte temporal no dado
#rx1day17_slice = subset(rx1day17, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day17_ajusted = resample(rx1day17, rp, method="bilinear")



# transforma o NetCDF em Raster
rx1day18 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_IPSL-CM5A-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx1day18 = rotate(rx1day18) 

#recorte espacial da área de estudo
#rx1day18_mask = crop(rx1day18, brasil) 

#recorte temporal no dado
rx1day18_slice = subset(rx1day18, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day18_ajusted = resample(rx1day18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day19 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_IPSL-CM5A-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day19 = rotate(rx1day19) 

#recorte espacial da área de estudo
#rx1day19_mask = crop(rx1day19, brasil) 

#recorte temporal no dado
#rx1day19_slice = subset(rx1day19, 103:147) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day19_ajusted = resample(rx1day19, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day20 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_IPSL-CM5B-LR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day20 = rotate(rx1day20) 

#recorte espacial da área de estudo
#rx1day20_mask = crop(rx1day20, brasil) 

#recorte temporal no dado
#rx1day20_slice = subset(rx1day20, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day20_ajusted = resample(rx1day20, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day21 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MIROC5_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day21 = rotate(rx1day21) 

#recorte espacial da área de estudo
#rx1day21_mask = crop(rx1day21, brasil) 

#recorte temporal no dado
#rx1day21_slice = subset(rx1day21, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day21_ajusted = resample(rx1day21, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day22 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MIROC-ESM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day22 = rotate(rx1day22) 

#recorte espacial da área de estudo
#rx1day22_mask = crop(rx1day22, brasil) 

#recorte temporal no dado
#rx1day22_slice = subset(rx1day22, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day22_ajusted = resample(rx1day22, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day23 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MIROC-ESM-CHEM_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day23 = rotate(rx1day23) 

#recorte espacial da área de estudo
#rx1day23_mask = crop(rx1day23, brasil) 

#recorte temporal no dado
#rx1day23_slice = subset(rx1day23, 112:156) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day23_ajusted = resample(rx1day23, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day24 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MPI-ESM-LR_rcp85_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx1day24 = rotate(rx1day24) 

#recorte espacial da área de estudo
#rx1day24_mask = crop(rx1day24, brasil) 

#recorte temporal no dado
rx1day24_slice = subset(rx1day24, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day24_ajusted = resample(rx1day24_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day25 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MPI-ESM-MR_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day25 = rotate(rx1day25) 

#recorte espacial da área de estudo
#rx1day25_mask = crop(rx1day25, brasil) 

#recorte temporal no dado
#rx1day25_slice = subset(rx1day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day25_ajusted = resample(rx1day25, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day26 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_MRI-CGCM3_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day26 = rotate(rx1day25) 

#recorte espacial da área de estudo
#rx1day25_mask = crop(rx1day25, brasil) 

#recorte temporal no dado
#rx1day26_slice = subset(rx1day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day26_ajusted = resample(rx1day26, rp, method="bilinear")


# transforma o NetCDF em Raster
rx1day27 = brick("C:/Users/inpe-eba/SISMOI/rx1day/rcp85/rx1dayETCCDI_yr_NorESM1-M_rcp85_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx1day27 = rotate(rx1day27) 

#recorte espacial da área de estudo
#rx1day25_mask = crop(rx1day25, brasil) 

#recorte temporal no dado
#rx1day25_slice = subset(rx1day25, 1:95) # 2006-2100

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx1day27_ajusted = resample(rx1day27, rp, method="bilinear")



#cria lista de rasters
rx1day_rcp85 = stack(rx1day1_ajusted, rx1day2_ajusted, rx1day3_ajusted, rx1day5_ajusted,
                 rx1day6_ajusted, rx1day7_ajusted, rx1day8_ajusted, rx1day9_ajusted, rx1day10_ajusted,
                 rx1day11_ajusted, rx1day12_ajusted, rx1day13_ajusted, rx1day14_ajusted, rx1day15_ajusted, 
                 rx1day16_ajusted, rx1day17_ajusted, rx1day18_ajusted, rx1day19_ajusted, rx1day20_ajusted, 
                 rx1day21_ajusted, rx1day22_ajusted, rx1day23_ajusted, rx1day24_ajusted, rx1day25_ajusted,
                 rx1day26_ajusted, rx1day27_ajusted)


#calcula a media rx1day

rMean <- calc( rx1day_rcp85 , fun = function(x){ by(x , c( rep(seq(1:95), times = 26)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

rx1day_rcp85_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(rx1day_rcp85_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(rx1day_rcp85_df, file = "rx1day_rcp85_mean.csv")

