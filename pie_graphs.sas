/*	Author - Anupama Rajaram
	Function - Calculate frequency distribution for research questions
	Importing data from a file called "anu_ool_pds-w3.csv
	this file has 290 rows. Values stored in object call "temp_chk"
*/

data temp_chk; 
   infile " /home/sunyblogger0/sasuser.v94/anu_ool_pds-w5.csv" 
   DELIMITER=',' ;
   Input CASEID W1_CASEID W2_CASEID2 PPAGECAT W1_F3 W1_F4_B W1_F4_D W1_F5_A W1_F6; 

/* Giving labels to variable names for better understanding */
LABEL 	CASEID = "Case Number"
		W1_F3 = "Belief in achieving American Dream"
		W1_F4_B = "Achieving financially secure retirement"
		W1_F4_D = "Achieving wealth"
		W1_F5_A = "Owning a home"
		W1_F6 = "How close to achieve the American Dream";

/* Coding for missing values as part of Data Management */
	IF W1_F3 = -1 THEN W1_F3 = .;
	IF W1_F4_B  = -1 THEN W1_F4_B = .;
	if W1_F4_D = -1 then W1_F4_D =.;
	IF W1_F5_A = -1 THEN W1_F5_A =.;
	IF W1_F6 = -1 THEN W1_F6 =.;
	
/* 	Only considering participants in age range 25-34 */
IF PPAGECAT=2;

/* CREATING A COMPOUND VARIABLE - wealth_conf */
	WEALTH_CONF = SUM (OF W1_F4_B W1_F4_D W1_F5_A);
	
	IF W1_F4_B =. OR W1_F4_D = . OR W1_F5_A =. THEN WEALTH_CONF = .;	
/* 	The command above ensures that if values for either 
	of the THREE variables are missing, then the wealth_conf
	is also coded as "." or missing. */

LABEL WEALTH_CONF = "Confidence to achieve wealth and secure retirement";

/* 	PRINTING THE INDIVIDUAL VARIABLES TO VIEW WEALTH CONFIDENCE 
	this part of the code is currently commented out */
/* PROC PRINT; VARIABLES W1_F4_B W1_F4_D WEALTH_CONF ; */

/* 	Computing frequency distribution for 5 variables 
PROC FREQ DATA = temp_chk;
	TABLES WEALTH_CONF W1_F4_B W1_F4_D W1_F3 W1_F4_B W1_F6;*/

/* creating bar graph chart for varibale wealth_conf */
TITLE 'Financial secure retirement (count)';
PROC GCHART; VBAR W1_F4_B/discrete ;

TITLE 'Wealth Confidence in %';
PROC GCHART; VBAR WEALTH_CONF/DISCRETE  TYPE= percent;

	run;

PROC FREQ DATA = temp_chk;
	TABLES W1_F4_B W1_F4_D W1_F6 WEALTH_CONF;
	
	
TITLE 'Pie Chart with Discrete';
PROC GCHART DATA=temp_chk;
      PIE W1_F6/ DISCRETE VALUE=INSIDE
                 PERCENT=INSIDE SLICE=OUTSIDE;
RUN; 
