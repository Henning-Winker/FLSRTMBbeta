# test-FLSR.R - DESC
# /test-FLSR.R

# Copyright Henning Winker (JRC) & Iago MOSQUEIRA (WMR), 2021
# Authors:  Henning Winker (JRC) <henning.winker@ec.europa.eu>
#           Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2

# XX {{{
# }}}

# TEST

data(ple4)

srr <- as.FLSR(ple4,model=bevholtSV)
spr0 <- spr0(ple4,nyears=3) # decrease for illustration

# Estimate steepness
s.bh = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0)
plot(s.bh)

# ricker only fits if spr0/2
s.ri = srrTMB(as.FLSR(ple4,model=rickerSV),s.est=T, spr0=spr0/2) 
plot(s.ri)

s = c(as.numeric(s.bh@SV["s"]) ,0.75,0.8,0.85,0.9,0.95)
srs <- FLSRs(sapply(s, function(x) { 
  return( srrTMB(srr,s=x,s.est=F, spr0=spr0))
}))
srs@names = c(paste("s =",round(s,3)))
plot(srs)



