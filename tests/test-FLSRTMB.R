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
library(ggplotFL)
library(FLCore)
library(FLSRTMBbeta)
data(ple4)
srr <- as.FLSR(ple4,model=bevholtSV)
spr0 <- yearMeans(spr0y(ple4)) 

# Estimate steepness
bh = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0)
plot(bh)

# Time-varying spr0y
plot(spr0y(ple4))+ylab("spr0")

# Fit to spr0(y) with a,b estimated for average spr0 of last years 
bh.y = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0y(ple4),nyears=3)
# Fit to spr0(y) with a,b estimated for average spr0 across all years 
bh.all = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0y(ple4),nyears=length(ple4@catch))

plot(FLSRs(spr0=bh,spr0y=bh.y,spr0all = bh.all))+theme(legend.position="right")

# Compare estimates
params(bh)
params(bh.y)
params(bh.all)

# To get steepness and R0 as output use option report.sR0=TRUE
bh.y1 = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0y(ple4),nyears=3,report.sR0 = T)
bh.all1 = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T, spr0=spr0y(ple4),nyears=length(ple4@catch),report.sR0 = T)
params(bh.y1)
params(bh.all1)

# Estimate steepness with prior (e.g. from fishlife)
# s = prior mean, s.logitsd is the sd on logit scale
bh.prior = srrTMB(as.FLSR(ple4,model=bevholtSV),s.est=T,s=0.7,s.logitsd=0.4, spr0=spr0y(ple4))

plot(FLSRs(spr0=bh,spr0y=bh.y,s.prior = bh.prior))+theme(legend.position="right")

# It is also possible to fix steepness
s = c(as.numeric(bh@SV["s"]) ,0.75,0.8,0.85,0.9,0.95)
bhs <- FLSRs(sapply(s, function(x) { 
  return( srrTMB(srr,s=x,s.est=F, spr0=spr0y(ple4)))
}))
bhs@names = c(paste("s =",round(s,3)))
plot(bhs)+theme(legend.position="right")


#>>> While and be differ, R0 and s are the same, with a,b depending on spr0 assumption

#--------------
# Hockey Stick
#--------------

# first fit a hockey-stick without constraints 
sr = srrTMB(as.FLSR(ple4,model=segreg),s.est=T, spr0=spr0(ple4),report.sR0 = F)
plot(sr)
# Now add the constraint that plim = Blim/B0 > 0.1
sr.b01 = srrTMB(as.FLSR(ple4,model=segreg),s.est=T, spr0=spr0(ple4),plim=0.1,report.sR0 = F)
plot(FLSRs(sr=sr,sr.b01=sr.b01))






