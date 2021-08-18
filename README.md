# FLSRTMBbeta
Beta version of stock-recruitment fitting in TMB for FLR  

Features
+ Fits in less in less then a second
+ Use FLR classes as input and output 
+ Fitting spawner-recruitment model with time-varying spr0(y)  
+ Enables use of steepness priors from fishlife
+ Provides options for conditioned hockey-stick with a break point b > plim (e.g. plim = 0.1B0) 

# Installation
Installing ss3diags requires the librabry(devtools), which can be install by 'install.packages('devtools')' and a R version >= 3.5. Then simply install ss3diags from github with the command:

`devtools::install_github("henning-winker/FLSRTMBbeta")`

`library(FLSRTMBbeta)`

Compiling C++ in windows can be troublesome. As an alternative to installing from github, a windows package binary zip file can be downloaded [here](https://github.com/Henning-Winker/FLSRTMBbeta/tree/main/BinaryPackage/win).

