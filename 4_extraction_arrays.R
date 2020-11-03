#####################################
# extraction of country-level deaths
#####################################

# pathogen/aetiology
rei <- c("Shigella","Cholera","Non-typhoidal Salmonella","Enteropathogenic E coli","Enterotoxigenic E coli",
         "Campylobacter","Cryptosporidium","Rotavirus","Norovirus","Typhoid fever")
rei2 <- c("shig","chol","salm","epec","etec","campy","cryp","rota","noro","typ")

# year and scenarios
yr <- 130.5:240.5 #refers to 1990-2100
yr2 <- 146.5:239.5 #refers to 2006-2099
ssp <- c("ssp1","ssp2","ssp3")
scalar <- c("good","mid","bad","base")
rcp <- c("rcp26","rcp45","rcp60","rcp85")
gcm <- c("gfdl","hadgem","ipsl","miroc")

# countries
iso <- c("JPN","AFG","AGO","ALB","ARE","ARG","ARM","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR",
         "BHS","BIH","BLR","BLZ","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV",
         "CMR","COD","COG","COL","COM","CPV","CRI","CUB","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU",
         "EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ",
         "GRC","GTM","GUY","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM",
         "JOR","KAZ","KEN","KGZ","KHM","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LKA","LSO","LTU",
         "LUX","LVA","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS",
         "MWI","MYS","NAM","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG",
         "POL","PRI","PRT","PRY","PSE","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV",
         "SOM","SRB","STP","SUR","SVK","SVN","SWE","SWZ","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON",
         "TTO","TUN","TUR","TWN","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VNM","VUT","WSM","YEM",
         "ZAF","ZMB","ZWE")

# excess deaths and population

# blank table
blank2 <- data.frame("iso"=character(0),"year"=numeric(0),"rei"=character(0),
                     "ssp"=character(0),"scalar"=character(0),
                     "gcm"=character(0),"rcp"=character(0),
                     "counts"=numeric(0),"pop"=numeric(0))

# loop
mort <- list.files() #files created from 3_baseline_excess.R
pop <- list.files() #gridded population from ISIMIP
z2 <- blank2
for (i in 1:nrow(mort)) {
  dat1 <- readRDS(mort[i]) # filename contains all information
  a <- stringr::str_extract(mort[i],rei2); a <- a[!is.na(a)] #pathogen/rei tag
  b <- stringr::str_extract(mort[i],ssp); b <- b[!is.na(b)] #SSP tag
  c <- stringr::str_extract(mort[i],scalar); c <- c[!is.na(c)] #scalar tag
  d <- stringr::str_extract(mort[i],rcp); d <- d[!is.na(d)] #RCP tag
  e <- stringr::str_extract(mort[i],gcm); e <- e[!is.na(e)] #GCM tag
  dat2 <- readRDS() #population data
  dat2 <- dat2[,,as.character(yr2)]
  for (j in loc) {
    mask <- readRDS(paste0() #country masks from ISIMIP
    years <- dim(dat1)[3]
    ins <- data.frame("iso"=rep(j,times=years),"year"=(1:years)+2005,"rei"=rep(a,times=years),
                      "ssp"=rep(b,times=years),"scalar"=rep(c,times=years),
                      "gcm"=rep(e,times=years),"rcp"=rep(d,times=years),
                      "counts"=unname(apply(dat1,3,function(x)sum(x*mask,na.rm=T))),
                      "pop"=dat2$pop[dat2$iso==j][1:years])
    z2 <- rbind(z2,ins)
  }
  rm(dat1,dat2,a,b,c,d,e,j,mask,years,ins)
}

saveRDS(z2,) #save file

rm(i,mort,pop,z2)
