clear all
cls

use "C:\Users\Omen\Music\Econometria Aplicada\Tareas\Tarea 1\Card_1993 (1).DTA" 

*a

reg lwage educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66

** los resultados coinciden con la Columna 2 de la Tabla 2 en Card (1995) **


*b

reg educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc4

** los resultados coinciden

**** nearc4 tiene un efecto parcial significativo sobre la variable edu, con un p value < 0.05

*c

ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc4)


** El retorno estimado a la educación ha aumentado a alrededor del 13,2%,  el intervalo de confianza del 95%: va de 2,4% a 23,9%. Por el contrario, el intervalo de confianza OLS es de aproximadamente 6.8% a 8.2%,  mucho más ajustado.

*d

** forma reducida

reg educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc2 nearc4

**** Cuando nearc2 se agrega a la forma reducida de educ tiene un coeficiente (error estándar) de .123 (.077), en comparación con .321 (.089) para nearc4. Por lo tanto, nearc4 tiene una relación ceteris paribus mucho más fuerte con educ, ademas

reg educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 nearc2 

**** nearc2 es sólo marginalmente estadísticamente significativo una vez nearc4 se ha incluido.

** IV

ivreg2 lwage exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66 (educ = nearc2 nearc4)

**** La estimación de 2SLS del retorno a la educación se convierte en alrededor del 15,7%, con IC del 95% dado por 5,4% a 26%. El IC sigue siendo muy amplio.

*e 

reg iq nearc4

**** iq y nearc4 tienen una correlacion positiva que es significativa.

*f 

reg iq nearc4 smsa66 reg661 reg662 reg669

** al controlar por las variables smsa66 reg661 reg662 reg669, se pierde el efecto parcial significativo de nearc4 sobre iq.



*d

* explicacion de prueba de overidentification test fue obtenido con help overid


* overid computes tests of overidentifying restrictions for a regression estimated via instrumental variables in which
* the number of instruments exceeds the number of regressors:  that is, for an overidentified equation.  These are tests
* of the joint null hypothesis that the excluded instruments are valid instruments, i.e., uncorrelated with the error
* term and correctly excluded from the estimated equation.  A rejection casts doubt on the validity of the instruments.

**
* usamos ivreg2 para la regresion, la cual ya inclue el estadistico de Sargan
**

** queremos no rechazar la H0 a un nivel de confianza de .05 para que los instrumentos sean validos
**** por lo que vimos en las notas de clase, las pruebas de sobreidentificacion solo son validas cuando tenemos mas instrumentos que var endogenas, solo se toma para el IV que tiene ambas (nerc4 nerc2 ) variables instrumentales 

** por su  Chi-sq(1) P-val =    0.2639, no se puede rehazar la H0, los instrumentos son validos.


** para explicar las consecuencias de instrumentos debiles use la literatura del Angry el libro Mostly Harmless, anexe el pdf con las paginas especificas y subrrayado 

** se uso la prueba  (Cragg-Donald Wald F statistic), si el Fvalue es mayor a 10, es un instrumento fuerte, de lo contrario es un instrumento debil.

*Para el IV  con unicamente nearc4, F-value=13.256 es instrumento fuerte

*Para el IV  con  nearc4 y nearc2, F-value=7.893 es instrumento debil





