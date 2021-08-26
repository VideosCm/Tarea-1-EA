cls
set more off 
clear all

global  directorio = "C:\Users\Omen\Music\Econometria Aplicada\Econometria aplicada\data\IMSS"
 
*IMSS EJERCICIO 1
 
********
*      * renombrar variable que hayan usado para el tiempo como fecha
********


forvalues yr = 2000/2021{

use "$directorio\bases por año\imss_`yr'.dta",clear

* edad (20-65)

quietly drop if rango_edad == "E1" | rango_edad == "E2"  | rango_edad == "E12" | rango_edad == "E13" | rango_edad == "E14" | rango_edad == "NA"


* % sector urbano

quietly gen turb = tpu + teu

* % sector rural

quietly gen trur = tpc + tec

quietly collapse (sum) ta turb trur, by(fecha)

quietly collapse (mean) ta turb trur

quietly gen year = `yr'

quietly save "$directorio\bases intermedias\imss_inter_1_`yr'", replace
}

*** unir años


forvalues yr = 2000/2021{
	if `yr' == 2000{
	quietly use "$directorio\bases intermedias\imss_inter_1_`yr'",clear
	}
	else{
	quietly append using "$directorio\bases intermedias\imss_inter_1_`yr'"
	quietly save "$directorio\base final\imss_final_1", replace
	}
}





