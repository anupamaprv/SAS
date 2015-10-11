/* 	Author - Anupama Rajaram
	Program Description - 
			This program creates a simple gplot of 2 variables,
			draws the plot line and calculates regression equation.
			y-axis = mpg.
			x-axis = weight1.
*/


DATA auto ;
  INPUT make $  mpg rep78 weight1 foreign1 ;
CARDS;
AMC     22 3 2930 0
AMC     17 3 3350 0
AMC     22 . 2640 0
Audi    17 5 2830 1
Audi    23 3 2070 1
BMW     25 4 2650 1
Buick   20 3 3250 0
Buick   15 4 4080 0
Buick   18 3 3670 0
Buick   26 . 2230 0
Buick   20 3 3280 0
Buick   16 3 3880 0
Buick   19 3 3400 0
Cad.    14 3 4330 0
Cad.    14 2 3900 0
Cad.    21 3 4290 0
Chev.   29 3 2110 0
Chev.   16 4 3690 0
Chev.   22 3 3180 0
Chev.   22 2 3220 0
Chev.   24 2 2750 0
Chev.   19 3 3430 0
Datsun  23 4 2370 1
Datsun  35 5 2020 1
Datsun  24 4 2280 1
Datsun  21 4 2750 1
;
RUN;

PROC FREQ DATA = auto;
	TABLES mpg;

goptions reset=all border;



proc plot data=auto;
      plot mpg * weight1 ;
   run; 



   proc gplot data=auto; 
   title "Study of MPG vs Weight";
 
symbol 	interpol= rqcli95
		value=circle
		cv= crimson
		ci = black
		co = bib
		width= 2
	;
  
   plot mpg*weight1 = foreign1  / haxis=2000 to 4500 by 500
                        vaxis=12 to 35 by 2
                        regeqn;
                        
run;
