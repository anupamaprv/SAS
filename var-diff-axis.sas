/* 	Author - Anupama Rajaram
	Program Description - 
			This program creates a simple plot of 2 variables.
			x-axis = height.
			y-axis = weight.
*/

goptions reset=all border;


title "Study of Height vs Weight";
footnote1 j=l "Source: T. Lewis & L. R. Taylor";

footnote1; /* this clears footnote1 */


symbol1 interpol=rcclm95
       value=circle
       cv=darkred
       ci=black
       co=blue
       width=2;


   plot height*weight / haxis=45 to 155 by 10
                        vaxis=48 to 78 by 6
                        hminor=1
                        regeqn;
                        
run;
quit;
