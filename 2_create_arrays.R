# country masks from ISIMIP

# aetiologies
rei1 <- c("Shigella","Cholera","Non-typhoidal Salmonella","Enteropathogenic E coli","Enterotoxigenic E coli",
          "Campylobacter","Cryptosporidium","Rotavirus","Norovirus","Typhoid fever")
rei2 <- c("shig","chol","salm","epec","etec","campy","cryp","rota","noro","typ")

# dimensions
lon_units <- seq(from=-179.75,to=179.75,by=0.5) #longitude degrees east by 0.5 degrees
lat_units <- seq(from=89.75,to=-89.75,by=-0.5) #latitude degrees north by 0.5 degrees
yr <- 130.5:240.5 #refers to 1990-2100

# blank array
mort <- array(0,dim=c(length(lon_units),length(lat_units),length(yr)),
              dimnames=list(lon_units,lat_units,yr))

# country-level percentage applied to arrays
files <- list.files() #list of outputs from 1_model_fit.R
for (i in 1:length(files)) {
  x <- readRDS(files[i])
  for (j in 1:length(rei)) {
    y <- x[x$rei==rei[j],]
    z <- mort
    for (k in loc) {
      mask <- readRDS() #country masks
      for (l in yr) {
        val <- mask * y$pct[y$iso==k & y$year==1859.5+l]
        z[,,as.character(l)] <- z[,,as.character(l)] + val
      }
    }
    saveRDS() #save on specific location
  }}
  
  
