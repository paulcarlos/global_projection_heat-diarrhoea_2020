##################################################################################
# fitting Foreman et al and Mathers-Loncar models to enteric infection mortality 
##################################################################################

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
         
# age groups
age <- c("Under 5","5-14 years","15-49 years","50-69 years","70+ years")

# aetiologies (rei)
rei <- c("Shigella","Cholera","Non-typhoidal Salmonella","Enteropathogenic E coli","Enterotoxigenic E coli",
         "Campylobacter","Cryptosporidium","Rotavirus","Norovirus","Typhoid fever")

# IHME model (Foreman et al 2018)
library(lme4)
mod1 <- lmer(formula = lograte ~ sdi_low + sdi_hi + year2:age + (1|rei/age/iso) + offset(logscalar), 
             data = data, REML = TRUE)
            
# Mathers-Loncar model (Mathers and Loncar, 2006)
mod2 <- lmer(formula = lograte ~ loggdp + logmys + loggdp2 + year2 + (1|rei/age/iso), 
             data = data, REML = TRUE)
