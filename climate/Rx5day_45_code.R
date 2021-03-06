require(ncdf4)
require(ncdf4.helpers)
require(ncdf4.tools)
require(ggplot2)
require(raster)
require(rgdal)
require(spatial.tools)

################################################################################

setwd("C:/Users/inpe-eba/SISMOI/rx5day/rcp45")

# Abrir shapefile
brasil = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Brasil.shp")
grid = readOGR("C:/Users/inpe-eba/SISMOI/Shapefiles/Grid.shp")

# abrir um arquivo netCDF file
rx5day_1 <- nc_open("rx5dayETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")
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
rx5day1 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_ACCESS1-0_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day1 = rotate(rx5day1) 

#recorte espacial da �rea de estudo
#rx5day1_mask = crop(rx5day1, brasil) 

#recorte temporal no dado
#rx5day1_slice = subset(rx5day1, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day1_ajusted = resample(rx5day1, rp, method="bilinear")


# Modelo bcc-csm1

# transforma o NetCDF em Raster
rx5day2 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_ACCESS1-3_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day2 = rotate(rx5day2) 

#recorte espacial da �rea de estudo
#rx5day2_mask = crop(rx5day2, brasil) 

#recorte temporal no dado
#rx5day2_slice = subset(rx5day2, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day2_ajusted = resample(rx5day2, rp, method='bilinear')


# transforma o NetCDF em Raster
rx5day3 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_BNU-ESM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day3 = rotate(rx5day3) 

#recorte espacial da �rea de estudo
#rx5day3_mask = crop(rx5day3, brasil) 

#recorte temporal no dado
#rx5day3_slice = subset(rx5day3, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day3_ajusted = resample(rx5day3, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day4 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CanESM2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day4 = rotate(rx5day4) 

#recorte espacial da �rea de estudo
#rx5day4_mask = crop(rx5day4, brasil) 

#recorte temporal no dado
rx5day4_slice = subset(rx5day4, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day4_ajusted = resample(rx5day4_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day5 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CCSM4_rcp45_r1i1p1_2006-2299.nc")

#transforma a longitude de 0-360 para -180-180
rx5day5 = rotate(rx5day5) 

#recorte espacial da �rea de estudo
#rx5day5_mask = crop(rx5day5, brasil) 

#recorte temporal no dado
rx5day5_slice = subset(rx5day5, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day5_ajusted = resample(rx5day5_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day6 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CMCC-CM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day6 = rotate(rx5day6) 

#recorte espacial da �rea de estudo
#rx5day6_mask = crop(rx5day6, brasil) 

#recorte temporal no dado
#rx5day6_slice = subset(rx5day6, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day6_ajusted = resample(rx5day6, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day7 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CMCC-CMS_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day7 = rotate(rx5day7) 

#recorte espacial da �rea de estudo
#rx5day7_mask = crop(rx5day7, brasil) 

#recorte temporal no dado
#rx5day7_slice = subset(rx5day7, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day7_ajusted = resample(rx5day7, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day8 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CNRM-CM5_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day8 = rotate(rx5day8) 

#recorte espacial da �rea de estudo
#rx5day8_mask = crop(rx5day8, brasil) 

#recorte temporal no dado
#rx5day8_slice = subset(rx5day8, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day8_ajusted = resample(rx5day8, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day9 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_CSIRO-Mk3-6-0_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day9 = rotate(rx5day9) 

#recorte espacial da �rea de estudo
#rx5day9_mask = crop(rx5day9, brasil) 

#recorte temporal no dado
rx5day9_slice = subset(rx5day9, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day9_ajusted = resample(rx5day9_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day10 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_EC-EARTH_rcp45_r6i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day10 = rotate(rx5day10) 

#recorte espacial da �rea de estudo
#rx5day10_mask = crop(rx5day10, brasil) 

#recorte temporal no dado
#rx5day10_slice = subset(rx5day10, 112:156) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day10_ajusted = resample(rx5day10, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day11 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_FGOALS-s2_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day11 = rotate(rx5day11) 

#recorte espacial da �rea de estudo
#rx5day11_mask = crop(rx5day11, brasil) 

#recorte temporal no dado
rx5day11_slice = subset(rx5day11, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day11_ajusted = resample(rx5day11_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
rx5day13 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_HadGEM2-CC_rcp45_r1i1p1_2005-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day13 = rotate(rx5day13) 

#recorte espacial da �rea de estudo
#rx5day13_mask = crop(rx5day13, brasil) 

#recorte temporal no dado
rx5day13_slice = subset(rx5day13, 2:96) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day13_ajusted = resample(rx5day13_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day14 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_IPSL-CM5A-LR_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day14 = rotate(rx5day14) 

#recorte espacial da �rea de estudo
#rx5day15_mask = crop(rx5day15, brasil) 

#recorte temporal no dado
rx5day14_slice = subset(rx5day14, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day14_ajusted = resample(rx5day14_slice, rp, method="bilinear")



# transforma o NetCDF em Raster
rx5day15 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_IPSL-CM5B-LR_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day15 = rotate(rx5day15) 

#recorte espacial da �rea de estudo
#rx5day15_mask = crop(rx5day15, brasil) 

#recorte temporal no dado
#rx5day15_slice = subset(rx5day15, 2:96) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day15_ajusted = resample(rx5day15, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day16 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_MIROC-ESM_rcp45_r1i1p1_2006-2300.nc")

#transforma a longitude de 0-360 para -180-180
rx5day16 = rotate(rx5day16) 

#recorte espacial da �rea de estudo
#rx5day16_mask = crop(rx5day16, brasil) 

#recorte temporal no dado
rx5day16_slice = subset(rx5day16, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day16_ajusted = resample(rx5day16_slice, rp, method="bilinear")


# transforma o NetCDF em Raster
rx5day17 = brick("C:/Users/inpe-eba/SISMOI/rx5day/rcp45/rx5dayETCCDI_yr_MIROC-ESM-CHEM_rcp45_r1i1p1_2006-2100.nc")

#transforma a longitude de 0-360 para -180-180
rx5day17 = rotate(rx5day17) 

#recorte espacial da �rea de estudo
#rx5day17_mask = crop(rx5day17, brasil) 

#recorte temporal no dado
#rx5day17_slice = subset(rx5day17, 1:95) # 2006-2100

#Transforma��o do GRID em raster
r <- raster(ncol=18, nrow=16)
extent(r) <- extent(grid)
rp <- rasterize(grid, r)

#Reamostragem para o GRID
rx5day17_ajusted = resample(rx5day17, rp, method="bilinear")


#cria lista de rasters
rx5day_rcp45 = stack(rx5day1_ajusted, rx5day2_ajusted, rx5day3_ajusted, rx5day4_ajusted, rx5day5_ajusted,
                 rx5day6_ajusted, rx5day7_ajusted, rx5day8_ajusted, rx5day9_ajusted, rx5day10_ajusted,
                 rx5day11_ajusted, rx5day13_ajusted, rx5day14_ajusted, rx5day15_ajusted, 
                 rx5day16_ajusted, rx5day17_ajusted)


#calcula a media rx5day

rMean <- calc( rx5day_rcp45 , fun = function(x){ by(x , c( rep(seq(1:95), times = 16)) , mean, na.rm=TRUE ) }  )

#trasnforma��o do dado em dataframe

rx5day_rcp45_df = as.data.frame(rMean, xy=TRUE) 

# nomeando as colunas do data frame
dates <- seq(as.Date("2006/1/1"), by = "year", length.out = 95)
head(dates)
tail(dates)

names(rx5day_rcp45_df) <- c("lon","lat", paste(dates,as.character(), sep="_"))


# Exportar o data frame como tabela CSV

write.csv(rx5day_rcp45_df, file = "rx5day_rcp45_mean.csv")

