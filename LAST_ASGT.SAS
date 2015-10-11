/*	Author - Anupama Rajaram
	Function - Calculate frequency distribution for research questions
	Importing data from a file called "anu_ool_pds-w3.csv
	this file has 290 rows. Values stored in object call "temp_chk"
*/

data temp_chk; 
   infile " /home/sunyblogger0/sasuser.v94/anu_ool_pds-wA.csv" 
   DELIMITER=',' ;
   Input CASEID W1_CASEID W2_CASEID2 W1_F3 W1_F4_B W1_F4_D W1_F5_A W1_F6 PPAGECAT 
   		PPGENDER PPMARIT; 

/* Giving labels to variable names for better understanding */
LABEL 	CASEID = "Case Number"
		W1_F3 = "Belief in achieving American Dream"
		W1_F4_B = "Achieving financially secure retirement"
		W1_F4_D = "Achieving wealth"
		W1_F5_A = "Owning a home"
		W1_F6 = "How close to achieve the American Dream"
		PPAGECAT = "Age"
		PPGENDER = "Gender"
		PPMARIT = "Mstat"
		MARG = "Marital status";

/* Coding for missing values as part of Data Management */
	IF W1_F3 = -1 THEN W1_F3 = .;
	IF W1_F4_B  = -1 THEN W1_F4_B = .;
	if W1_F4_D = -1 then W1_F4_D =.;
	IF W1_F5_A = -1 THEN W1_F5_A =.;
	IF W1_F6 = -1 THEN W1_F6 =.;
	
/* changing marital status categories */
	IF (PPMARIT = 1 OR PPMARIT = 6) THEN MARG =1 ;
	ELSE IF (PPMARIT = 2 OR PPMARIT = 3 OR PPMARIT =4) THEN MARG = 2;
	ELSE IF PPMARIT = 5 THEN MARG = 5;
	
/* 	Only considering participants in age range 25-34 */
IF PPAGECAT=2;

/* CREATING A COMPOUND VARIABLE - wealth_conf */
	WEALTH_CONF = SUM (OF W1_F4_B W1_F4_D W1_F5_A);
	
	IF W1_F4_B =. OR W1_F4_D = . OR W1_F5_A =. THEN WEALTH_CONF = .;	
/* 	The command above ensures that if values for either 
	of the THREE variables are missing, then the wealth_conf
	is also coded as "." or missing. */
	
/*LABEL WEALTH_CONF = "Confidence to achieve wealth and secure retirement";
*/

/* 	PRINTING THE INDIVIDUAL VARIABLES TO VIEW WEALTH CONFIDENCE 
	this part of the code is currently commented out */
/* PROC PRINT; VARIABLES W1_F4_B W1_F4_D WEALTH_CONF ; */

/* 	Computing frequency distribution for 5 variables */
PROC FREQ DATA = temp_chk;
	TABLES WEALTH_CONF MARG;

/* creating bar graph chart for varibale wealth_conf 
TITLE 'Financial secure retirement (count)';
PROC GCHART; VBAR W1_F4_B/discrete ; */

TITLE 'Wealth Confidence in %';
PROC GCHART; VBAR WEALTH_CONF/DISCRETE  TYPE= percent;

	run;

/* graph showing wealth confidence by marital status */	
title1 ls=1.5 "wealth confidence by marital status";
pattern1 v=solid color= big;
pattern2 v=solid color = antiquewhite;
pattern3 v=solid color = darkorange;
proc gchart data=temp_chk;
vbar MARG/discrete type= sum sumvar=WEALTH_CONF
group=WEALTH_CONF subgroup=MARG freq;
run;	



proc gplot data=temp_chk; 
/* graph showing wealth confidence by marital status */	
 title "Study of Wealth_conf vs Marital Status";
symbol 	interpol= rqcli95
		value=circle
		cv= crimson
		ci = black
		co = bib
		width= 2
	;
  
   plot WEALTH_CONF*W1_F4_B= PPMARIT/ 	HAXIS= 1 TO 6 BY 2
   								VAXIS= 0 TO 12 BY 2   							 	
   								REGEQN;
                        
run;


/* OUTPUT FILE IS 
