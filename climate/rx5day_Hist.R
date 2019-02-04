require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/rx5day/Historical")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
rx5day_1 <- nc_open("rx5dayETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")
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
rx5day1 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_ACCESS1-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day1 = rotate(rx5day1) 

#recorte espacial da área de estudo
#rx5day1_mask = crop(rx5day1, brasil) 

#recorte temporal no dado
rx5day1_slice = subset(rx5day1, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day1_ajusted = resample(rx5day1_slice, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
rx5day2 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_BNU-ESM_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day2 = rotate(rx5day2) 

#recorte espacial da área de estudo
#rx5day2_mask = crop(rx5day2, brasil) 

#recorte temporal no dado
rx5day2_slice = subset(rx5day2, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day2_ajusted = resample(rx5day2_slice, rp, method='bilinear')


# transforma o NetCDF em Raster
rx5day3 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CanCM4_historical_r1i1p1_1961-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day3 = rotate(rx5day3) 

#recorte espacial da área de estudo
#rx5day3_mask = crop(rx5day3, brasil) 

#recorte temporal no dado
#rx5day3_slice = subset(rx5day3, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day3_ajusted = resample(rx5day3, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day4 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CanESM2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day4 = rotate(rx5day4) 

#recorte espacial da área de estudo
#rx5day4_mask = crop(rx5day4, brasil) 

#recorte temporal no dado
rx5day4_slice = subset(rx5day4, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day4_ajusted = resample(rx5day4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day5 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CCSM4_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day5 = rotate(rx5day5) 

#recorte espacial da área de estudo
#rx5day5_mask = crop(rx5day5, brasil) 

#recorte temporal no dado
rx5day5_slice = subset(rx5day5, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day5_ajusted = resample(rx5day5_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
rx5day6 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CESM1-FASTCHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day6 = rotate(rx5day6) 

#recorte espacial da área de estudo
#rx5day6_mask = crop(rx5day6, brasil) 

#recorte temporal no dado
rx5day6_slice = subset(rx5day6, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day6_ajusted = resample(rx5day6_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day7 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CMCC-CESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day7 = rotate(rx5day7) 

#recorte espacial da área de estudo
#rx5day7_mask = crop(rx5day7, brasil) 

#recorte temporal no dado
rx5day7_slice = subset(rx5day7, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day7_ajusted = resample(rx5day7_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day8 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CMCC-CM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day8 = rotate(rx5day8) 

#recorte espacial da área de estudo
#rx5day8_mask = crop(rx5day8, brasil) 

#recorte temporal no dado
rx5day8_slice = subset(rx5day8, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day8_ajusted = resample(rx5day8_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day9 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CMCC-CMS_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day9 = rotate(rx5day9) 

#recorte espacial da área de estudo
#rx5day9_mask = crop(rx5day9, brasil) 

#recorte temporal no dado
rx5day9_slice = subset(rx5day9, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day9_ajusted = resample(rx5day9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day10 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CNRM-CM5_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day10 = rotate(rx5day10) 

#recorte espacial da área de estudo
#rx5day10_mask = crop(rx5day10, brasil) 

#recorte temporal no dado
rx5day10_slice = subset(rx5day10, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day10_ajusted = resample(rx5day10_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day11 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_CSIRO-Mk3-6-0_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day11 = rotate(rx5day11) 

#recorte espacial da área de estudo
#rx5day11_mask = crop(rx5day11, brasil) 

#recorte temporal no dado
rx5day11_slice = subset(rx5day11, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day11_ajusted = resample(rx5day11_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day12 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_FGOALS-s2_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day12 = rotate(rx5day12) 

#recorte espacial da área de estudo
#rx5day12_mask = crop(rx5day12, brasil) 

#recorte temporal no dado
rx5day12_slice = subset(rx5day12, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day12_ajusted = resample(rx5day12_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day13 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_GFDL-CM3_historical_r1i1p1_1860-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day13 = rotate(rx5day13) 

#recorte espacial da área de estudo
#rx5day13_mask = crop(rx5day13, brasil) 

#recorte temporal no dado
rx5day13_slice = subset(rx5day13, 102:146) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day13_ajusted = resample(rx5day13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day15 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_HadCM3_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day15 = rotate(rx5day15) 

#recorte espacial da área de estudo
#rx5day15_mask = crop(rx5day15, brasil) 

#recorte temporal no dado
rx5day15_slice = subset(rx5day15, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day15_ajusted = resample(rx5day15_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day16 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_HadGEM2-CC_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day16 = rotate(rx5day16) 

#recorte espacial da área de estudo
#rx5day16_mask = crop(rx5day16, brasil) 

#recorte temporal no dado
rx5day16_slice = subset(rx5day16, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day16_ajusted = resample(rx5day16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day17 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_HadGEM2-ES_historical_r1i1p1_1859-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day17 = rotate(rx5day17) 

#recorte espacial da área de estudo
#rx5day17_mask = crop(rx5day17, brasil) 

#recorte temporal no dado
rx5day17_slice = subset(rx5day17, 103:147) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day17_ajusted = resample(rx5day17_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day18 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_IPSL-CM5A-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day18 = rotate(rx5day18) 

#recorte espacial da área de estudo
#rx5day18_mask = crop(rx5day18, brasil) 

#recorte temporal no dado
rx5day18_slice = subset(rx5day18, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day18_ajusted = resample(rx5day18_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day19 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_IPSL-CM5A-MR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day19 = rotate(rx5day19) 

#recorte espacial da área de estudo
#rx5day19_mask = crop(rx5day19, brasil) 

#recorte temporal no dado
rx5day19_slice = subset(rx5day19, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day19_ajusted = resample(rx5day19_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day20 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_IPSL-CM5B-LR_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day20 = rotate(rx5day20) 

#recorte espacial da área de estudo
#rx5day20_mask = crop(rx5day20, brasil) 

#recorte temporal no dado
rx5day20_slice = subset(rx5day20, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day20_ajusted = resample(rx5day20_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day21 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_MIROC4h_historical_r1i1p1_1950-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day21 = rotate(rx5day21) 

#recorte espacial da área de estudo
#rx5day21_mask = crop(rx5day21, brasil) 

#recorte temporal no dado
rx5day21_slice = subset(rx5day21, 12:56) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day21_ajusted = resample(rx5day21_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day22 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_MIROC5_historical_r1i1p1_1850-2012.nc")

#transforma a longitude de 0-360 para -180-180
rx5day22 = rotate(rx5day22) 

#recorte espacial da área de estudo
#rx5day22_mask = crop(rx5day22, brasil) 

#recorte temporal no dado
rx5day22_slice = subset(rx5day22, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day22_ajusted = resample(rx5day22_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day23 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_MIROC-ESM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day23 = rotate(rx5day23) 

#recorte espacial da área de estudo
#rx5day23_mask = crop(rx5day23, brasil) 

#recorte temporal no dado
rx5day23_slice = subset(rx5day23, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day23_ajusted = resample(rx5day23_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day24 = brick("C:/Users/inpe-eba/SISMOI/rx5day/Historical/rx5dayETCCDI_yr_MIROC-ESM-CHEM_historical_r1i1p1_1850-2005.nc")

#transforma a longitude de 0-360 para -180-180
rx5day24 = rotate(rx5day24) 

#recorte espacial da área de estudo
#rx5day24_mask = crop(rx5day24, brasil) 

#recorte temporal no dado
rx5day24_slice = subset(rx5day24, 112:156) # 1961-2005

#Transformação do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day24_ajusted = resample(rx5day24_slice, rp, method="bilinear")




#cria lista de rasters
rx5day_Hist = stack(rx5day1_ajusted, rx5day2_ajusted, rx5day3_ajusted,rx5day5_ajusted,
                 rx5day6_ajusted, rx5day7_ajusted, rx5day8_ajusted, rx5day9_ajusted, rx5day10_ajusted,
                 rx5day11_ajusted, rx5day12_ajusted, rx5day13_ajusted, 
                 rx5day15_ajusted, rx5day16_ajusted, rx5day17_ajusted, rx5day18_ajusted, rx5day19_ajusted,
                 rx5day20_ajusted, rx5day21_ajusted, rx5day22_ajusted, rx5day23_ajusted, rx5day24_ajusted)



#calcula a media rx5day

rMean <- calc( rx5day_Hist , fun = function(x){ by(x , c( rep(seq(1:45), times = 22)) , mean, na.rm=TRUE ) }  )

#trasnformação do dado em dataframe

rx5day_Hist_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("1961/1/1"), by = "year", length.out = 45)
head(dates)
tail(dates)

names(rx5day_Hist_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(rx5day_Hist_df, file = "rx5day_Historical_mean.csv")

