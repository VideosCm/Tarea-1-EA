*** directorio

global directorio = "C:\Users\Omen\Music\Econometria Aplicada\Econometria aplicada\data\IMSS\base final"

*** 

cls
clear all 
use "$directorio\imss_5_1final.dta", clear
format year %ty
tsset year

**********************
**** crear porcentajes
**********************

gen porcentaje_trab = round((ta/asegurados)*100,.01)
gen porcentaje_rur = round((trur/asegurados)*100,.01)

grstyle init
set scheme economist
grstyle set color economist

* ytitle(Peso) ytitle(, size(large)) xtitle(Largo) xtitle(, size(large)) title(Peso v/s largo) subtitle(Base:Auto)



twoway (tsline porcentaje_trab, recast(connected)  lwidth(medthin) msize(medsmall)) (tsline porcentaje_rur, recast(connected)  lwidth(medthin) msize(medsmall)), ytitle("Porcentaje de Asegurados") legen(order(1 "Trabajadores" 2 "Trabajadores rurales" ) position(6)) yscale(alt) title(Trabajadores asegurados, position(12) alignment(middle)) subtitle(IMSS, position(12)) caption(Fuente: Elaboracion propia con datos de IMSS)

 grstyle clear

*******
* grafica segunda parte
*******

cls
clear all 
use "$directorio\imss_5_2final.dta" ,clear
format year %ty



* ytitle(Peso) ytitle(, size(large)) xtitle(Largo) xtitle(, size(large)) title(Peso v/s largo) subtitle(Base:Auto)



gen ta_muj = ta if sexo == 2
collapse (sum) ta ta_muj asegurados, by(year)
tsset year

gen porcentaje_trab = round((ta/asegurados)*100,.01)
gen porcentaje_muj = round((ta_muj/asegurados)*100,.01)

grstyle init
grstyle set plain, nogrid noextend

twoway (tsline porcentaje_trab, recast(connected)  lwidth(medthin) msize(medsmall)) (tsline porcentaje_muj, recast(connected)  lwidth(medthin) msize(medsmall)) , ytitle("Porcentaje de Asegurados") legen(order(1 "ta" 2 "muj") position(6)) yscale(alt) title(trabajadoras, position(12) alignment(middle)) subtitle(IMSS, position(12)) caption(Fuente: Elaboracion propia con datos de )

grstyle clear
