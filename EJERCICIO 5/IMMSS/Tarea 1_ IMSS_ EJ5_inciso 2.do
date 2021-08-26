cls
set more off 
clear all

global  directorio = "C:\Users\Omen\Music\Econometria Aplicada\Econometria aplicada\data\IMSS"
 
*IMMSS EJ2
 
********
*      * renombrar variable que hayan usado para el tiempo como fecha
********


forvalues yr = 2000/2021{

use "$directorio\bases por año\imss_`yr'.dta",clear

* filtrar por edad (20-65)

quietly drop if rango_edad == "E1" | rango_edad == "E2"  | rango_edad == "E12" | rango_edad == "E13" | rango_edad == "E14" | rango_edad == "NA"

*2)



quietly collapse (sum) ta asegurados , by(fecha sexo)

quietly collapse (mean) ta asegurados, by(sexo)

quietly gen year = `yr'

quietly format %12.0g ta asegurados

quietly save "$directorio\bases intermedias\imss_preg5_ej2_`yr'", replace
}

*** unir años


forvalues yr = 2000/2021{
	if `yr' == 2000{
	quietly use "$directorio\bases intermedias\imss_preg5_ej2_`yr'",clear
	}
	else{
	quietly append using "$directorio\bases intermedias\imss_preg5_ej2_`yr'"
	quietly save "$directorio\base final\imss_preg5_ej2_final", replace
	}
}
