**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2008 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2008"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/NCV_Concentrado_2008_concil_2010.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"08"

ren factor weight
lab var weight "Factor de expansión"

rename tot_resi tot_integ
rename n_ocu ocupados 
rename perocu perc_ocupa
rename sexo sexo_jefe
rename ingcor ing_cor
rename gasmon gasto_mon
rename ed_formal educa_jefe

gen rural=0 
replace rural=1 if estrato==4 

keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural 

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/NCV_Poblacion_2008_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"08"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edocony, replace
ren edocony edo_civil

replace edo_civil=7 if edo_civil==5

replace edo_civil=5 if edo_civil==4

replace edo_civil=4 if edo_civil==3

replace edo_civil=3 if edo_civil==2

replace edo_civil=2 if edo_civil==7

tab edo_civil

lab var edo_civil "Estado civil"

lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"

lab value edo_civil edc

rename n_instr161 nivelaprob


gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare



replace trabajo=0 if trabajo==2




keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/NCV_Trabajos_2008_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"08"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

rename cmo sinco

keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2008


save "$Data_new/enigh2008_c.dta", replace


**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2010 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2010"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/NCV_Concentrado_2010_concil_2010.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"10"

ren factor weight
lab var weight "Factor de expansión"

rename tot_resi tot_integ
rename n_ocu ocupados 
rename perocu perc_ocupa
rename sexo sexo_jefe
rename ingcor ing_cor
rename gasmon gasto_mon
rename ed_formal educa_jefe

gen rural=0 
replace rural=1 if tam_loc==4 

keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/NCV_Poblacion_2010_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"10"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edocony, replace
ren edocony edo_civil

tab edo_civil

lab var edo_civil "Estado civil"

lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"

lab value edo_civil edc

destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"

lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare


destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob


destring trabajo, replace
tab trabajo
replace trabajo=0 if trabajo==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo tra
tab trabajo


keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/NCV_Trabajos_2010_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"10"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

rename cuo sinco


destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact


keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2010


save "$Data_new/enigh2010_c.dta", replace




**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2012 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2012"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/NCV_Concentrado_2012_concil_2010.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"12"

ren factor weight
lab var weight "Factor de expansión"

gen tam_hog = hombres + mujeres


destring sexo_jefe, replace
lab define sex 1 "Hombre" 2 "Mujer"
lab value sexo_jefe sex

tab sexo_jefe

destring educa_jefe, replace
lab define eduj 1 "Sin instrucción" 2 "Preescolar" 3 "Primaria incompleta" 4 "Primaria completa" 5 "Secundaria incompleta" 6 "Secundaria completa" 7 "Preparatoria incompleta" 8 "Preparatoria completa" 9 "Profesional incompleta" 10 "Profesional completa" 11 "Posgrado"
lab value educa_jefe eduj

tab educa_jefe




gen rural=0 
replace rural=1 if tam_loc=="4"
tab rural


keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural 

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/NCV_Poblacion_2012_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"12"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edo_conyug, replace
ren edo_conyug edo_civil
lab var edo_civil "Estado civil"
lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"
lab value edo_civil edc


destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare


destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob




destring trabajo_mp, replace
tab trabajo_mp
replace trabajo_mp=0 if trabajo_mp==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo_mp tra

rename trabajo_mp trabajo

keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/NCV_Trabajos_2012_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"12"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"


destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact



keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2012


save "$Data_new/enigh2012_c.dta", replace


**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2014 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2014"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/NCV_Concentrado_2014_concil_2010.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"14"

ren factor weight
lab var weight "Factor de expansión"

gen tam_hog = hombres + mujeres


destring sexo_jefe, replace
lab define sex 1 "Hombre" 2 "Mujer"
lab value sexo_jefe sex

tab sexo_jefe

destring educa_jefe, replace
lab define eduj 1 "Sin instrucción" 2 "Preescolar" 3 "Primaria incompleta" 4 "Primaria completa" 5 "Secundaria incompleta" 6 "Secundaria completa" 7 "Preparatoria incompleta" 8 "Preparatoria completa" 9 "Profesional incompleta" 10 "Profesional completa" 11 "Posgrado"
lab value educa_jefe eduj

tab educa_jefe

tab tam_loc
gen rural=0 
replace rural=1 if tam_loc=="4"
tab rural


keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/NCV_Poblacion_2014_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"14"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edo_conyug, replace
ren edo_conyug edo_civil
lab var edo_civil "Estado civil"
lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"
lab value edo_civil edc


destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare

destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob


destring trabajo_mp, replace
tab trabajo_mp
replace trabajo_mp=0 if trabajo_mp==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo_mp tra
tab trabajo

rename trabajo_mp trabajo

keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/NCV_Trabajos_2014_concil_2010.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"14"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact


keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2014


save "$Data_new/enigh2014_c.dta", replace


**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2016 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2016"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/concentradohogar.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"16"

ren factor weight
lab var weight "Factor de expansión"

gen tam_hog = hombres + mujeres


destring sexo_jefe, replace
lab define sex 1 "Hombre" 2 "Mujer"
lab value sexo_jefe sex

tab sexo_jefe

destring educa_jefe, replace
lab define eduj 1 "Sin instrucción" 2 "Preescolar" 3 "Primaria incompleta" 4 "Primaria completa" 5 "Secundaria incompleta" 6 "Secundaria completa" 7 "Preparatoria incompleta" 8 "Preparatoria completa" 9 "Profesional incompleta" 10 "Profesional completa" 11 "Posgrado"
lab value educa_jefe eduj

tab educa_jefe



tab tam_loc
gen rural=0 
replace rural=1 if tam_loc=="4"
tab rural



keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/poblacion.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"16"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edo_conyug, replace
ren edo_conyug edo_civil
lab var edo_civil "Estado civil"
lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"
lab value edo_civil edc


destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare

destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob




destring trabajo_mp, replace
tab trabajo_mp
replace trabajo_mp=0 if trabajo_mp==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo_mp tra
tab trabajo

rename trabajo_mp trabajo

keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/trabajos.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"16"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact


keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2016


save "$Data_new/enigh2016_c.dta", replace


**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2018 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2018"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/concentradohogar.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"18"

ren factor weight
lab var weight "Factor de expansión"

gen tam_hog = hombres + mujeres

destring sexo_jefe, replace
lab define sex 1 "Hombre" 2 "Mujer"
lab value sexo_jefe sex

tab sexo_jefe

destring educa_jefe, replace
lab define eduj 1 "Sin instrucción" 2 "Preescolar" 3 "Primaria incompleta" 4 "Primaria completa" 5 "Secundaria incompleta" 6 "Secundaria completa" 7 "Preparatoria incompleta" 8 "Preparatoria completa" 9 "Profesional incompleta" 10 "Profesional completa" 11 "Posgrado"
lab value educa_jefe eduj

tab educa_jefe



tab tam_loc
gen rural=0 
replace rural=1 if tam_loc=="4"
tab rural



keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/poblacion.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"18"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edo_conyug, replace
ren edo_conyug edo_civil
lab var edo_civil "Estado civil"
lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"
lab value edo_civil edc


destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare

destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob




destring trabajo_mp, replace
tab trabajo_mp
replace trabajo_mp=0 if trabajo_mp==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo_mp tra
tab trabajo

rename trabajo_mp trabajo

keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/trabajos.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"18"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact


keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2018


save "$Data_new/enigh2018_c.dta", replace


**************************************************************
* 			Econometria Aplicada 			 *
* Encuesta Nacional de Ingresos y Gastos de los Hogares 2020 *
**************************************************************

clear
set more off

global Data     = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\2020"

global Data_new = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out"

*Concentrado
use "$Data/concentradohogar.dta", clear
gen folio=folioviv+foliohog
replace folio=folio+"20"

ren factor weight
lab var weight "Factor de expansión"

gen tam_hog = hombres + mujeres


destring sexo_jefe, replace
lab define sex 1 "Hombre" 2 "Mujer"
lab value sexo_jefe sex

tab sexo_jefe

destring educa_jefe, replace
lab define eduj 1 "Sin instrucción" 2 "Preescolar" 3 "Primaria incompleta" 4 "Primaria completa" 5 "Secundaria incompleta" 6 "Secundaria completa" 7 "Preparatoria incompleta" 8 "Preparatoria completa" 9 "Profesional incompleta" 10 "Profesional completa" 11 "Posgrado"
lab value educa_jefe eduj

tab educa_jefe


tab tam_loc
gen rural=0 
replace rural=1 if tam_loc=="4"
tab rural


keep folio folioviv foliohog ubica_geo tam_hog tot_integ hombres mujeres ocupados perc_ocupa sexo_jefe educa_jefe ing_cor gasto_mon educacion weight rural

save "$Data_new/concen.dta", replace



*Poblacion

use "$Data/poblacion.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"20"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring edad, replace
lab var edad "Edad"

destring sexo, replace
recode sexo(2=0)
ren sexo male
lab var male "Indicadora de sexo masculino" 

destring edo_conyug, replace
ren edo_conyug edo_civil
lab var edo_civil "Estado civil"
lab define edc 1 "Union libre" 2 "Casado(a)"  3 "Separado(a)"  4 "Divorciado(a)" 5 "Viudo(a)" 6 "Soltero(a)"
lab value edo_civil edc



destring parentesco, replace

gen par=1 if parentesco==101
replace par=2 if (parentesco>=200 & parentesco<=204)
replace par=3 if (parentesco>=301 & parentesco<=305) 
replace par=4 if ((parentesco>=401 & parentesco<=413) | parentesco==421 ////
	| parentesco==431 | parentesco==441 | parentesco==451 | parentesco==461)
replace par=5 if (parentesco>=601 & parentesco<=623)
replace par=6 if ((parentesco>=501 & parentesco<=503) ////
	| parentesco==701 | (parentesco>=711 & parentesco<=715) | parentesco==999) 
drop parentesco
ren par parentesco
lab var parentesco "Parentesco con el jefe del hogar"
lab define pare 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Trabajador doméstico"  ////
	5 "Otro parentesco" 6 "Sin parentesco"
lab value parentesco pare


destring nivelaprob, replace

lab define nivela 0 "Ninguno" 1 "Preescolar" 2 "Primaria" 3 "Secundaria" 4 "Preparatoria o bachillerato" 5 "Normal" 6 "Carrera técnica o comercial" 7 "Profesional" 8 "Maestría" 9 "Doctorado"
lab value nivelaprob nivela

tab nivelaprob



destring trabajo_mp, replace
tab trabajo_mp
replace trabajo_mp=0 if trabajo_mp==2
lab define tra 0 "No" 1 "Si" 
lab value trabajo_mp tra
tab trabajo

rename trabajo_mp trabajo

keep folio folioviv foliohog folio_ind edad male edo_civil numren parentesco nivelaprob trabajo hijos_sob

save "$Data_new/poblacion.dta", replace



*Trabajos

use "$Data/trabajos.dta", clear

gen folio=folioviv+foliohog
replace folio=folio+"20"

gen folio_ind=folio+numren
lab var folio_ind "Identificador individual"

destring tipoact, replace

lab define act 1 "Industrial" 2 "Comercial" 3 "De servicios" 4 "Actividades agrícolas" 5 "Actividades de cría y explotación de animales" 6 "Actividades de recolección" 7 "Reforestación y tala de arboles" 8 "Actividades de caza y captura de animales" 9 "Actividades de pesca"
lab value tipoact act

tab tipoact


keep folio folioviv foliohog folio_ind sinco tipoact

save "$Data_new/trabajo.dta", replace



**Unimos las bases

use "$Data_new/poblacion.dta", clear

describe, short

merge n:n folio_ind using "$Data_new/trabajo.dta"
drop _merge

describe, short

joinby folio using "$Data_new/concen.dta", unmatched(both) 
drop _merge

describe, short

lab var folio "Identificador único del hogar"

gen year=2020


save "$Data_new/enigh2020_c.dta", replace






*********************************************************
* 	 Econometria Aplicada     	*
* Encuesta Nacional de Ingresos y Gastos de los Hogares * UNIR TODO
*********************************************************

clear 

cd "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH"

global data = "D:\Usuario\Desktop\Tercer Semestre\Econometria Aplicada\Tarea 1\Data\ENIGH\out" 


foreach i in 2008 2010 2012 2014 2016 2018 2020 {
	do "Enigh`i'"
}



foreach i in 2008 2010 2012 2014 2016 2018 2020 {
	quietly use "$data/enigh`i'_c.dta", clear
		if `i' == 2008{
			quietly save "$data/ENIGH_ALL_m.dta", replace
			}
		else{
			quietly append using "$data/ENIGH_ALL_m.dta"
			quietly save "$data/ENIGH_ALL_m.dta", replace
		}
}