#####################################################
# estimation of baseline and excess number of deaths
#####################################################

# names of variables
rei2 <- c("shig","chol","salm","epec","etec","campy","cryp","rota","noro","typ")
ssp <- c("ssp1","ssp2","ssp3")

# table of Relative Risks per aetiology (Chua et al 2020)
rr <- data.frame("shig"=0.070,"chol"=0.054,"salm"=0.051,
                 "epec"=0.043,"etec"=0.043,"campy"=0.023,
                 "cryp"=0.170,"rota"=-0.044,"noro"=-0.105,"typ"=0.151)
rr <- reshape2::melt(rr,measure.vars=rei2,variable.name="pathogen",value.name="rr")

rr_lci <- data.frame("shig"=0.044,"chol"=0.042,"salm"=0.036,
                 "epec"=0.012,"etec"=0.012,"campy"=0.007,
                 "cryp"=0.080,"rota"=-0.105,"noro"=-0.193,"typ"=0.071)
rr_lci <- reshape2::melt(rr_lci,measure.vars=rei2,variable.name="pathogen",value.name="rr")

rr_uci <- data.frame("shig"=0.096,"chol"=0.066,"salm"=0.067,
                     "epec"=0.074,"etec"=0.074,"campy"=0.040,
                     "cryp"=0.260,"rota"=0.021,"noro"=-0.009,"typ"=0.236)
rr_uci <- reshape2::melt(rr_uci,measure.vars=rei2,variable.name="pathogen",value.name="rr")

# annual temperature difference from ISIMIP

# projected years 2006-2099
yr <- 146.5:239.5 #refers to 2006-2099

# base number of deaths in arrays
files <- list.files() #created from 2_create_arrays.R
for (i in 1:length(files)) {
  m <- readRDS(files[i]) # get file of mortality rate
  a <- stringr::str_match(files[i],ssp); a <- a[!is.na(a)] #SSP name
  p <- readRDS() # get population data from ISIMIP per SSP
  x <- m*p
  saveRDS(x,) # save on a specific location
}
rm(i,m,a,p,x,files)

# excess number of deaths in arrays
files <- list.files() # base number of deaths created from codes above
for (i in 1:length(files)) {
  dat1 <- readRDS(files[i]) #base deaths array
  base <- dat1[,,as.character(yr)] # only 2006-2099
  for (j in 1:length(temp)) {
    dat2 <- readRDS() #temperature difference from ISIMIP
    tas <- dat2[,,as.character(yr)] #up to 2099 only
    a <- stringr::str_extract(files[i],rei2); a <- a[!is.na(a)] #pathogen/aetiology tag
    rr_val <- rr$rr[rr$pathogen==a] # mean RRs, can be changed for upper and lower CIs
    delta <- (exp(rr_val*tas)-1)/exp(rr_val*tas)
    excess <- base*delta
    saveRDS(excess,) #save on specific location
  }}
rm(i,j,dat1,base,dat2,tas,a,rr_val,delta,excess)
