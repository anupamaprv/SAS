/*	Author - Anupama Rajaram
	Description - 	correlation test that includes a moderator = ethnicity.
					Coursera week4 assignment for Data Analysis tools
					This program imports data from a file called "anu_ool_pds-wc.csv"
					this file has ~2900 rows. 
					Posthoc tests are also calculated. 
					
					I have suppressed the sorting by moderator variable, to take stock of the relationship
					between other variables . 
					
					The Bernouli adjustment factor = 10.	So p-value < 0.005 for values to accept the alternate hypothesis
	        again we take moderator variable = ethnicity = PPETHM
*/

   data temp_chk; 
   infile " /home/sunshinegirl48860/sasuser.v94/anu_ool_pds-wc.csv" 
   DELIMITER=',' firstobs=2 ;
   Input CASEID	W1_CASEID	W2_CASEID2	W1_F3	W1_F4_B	
   W1_F4_D	W1_F5_A	W1_F6	PPAGECAT	PPGENDER	
   PPMARIT	PPINCIMP	PPETHM; 

/* Giving labels to variable names for better understanding */
LABEL 	CASEID = "Case Number"
		W1_F3 = "Belief in achieving American Dream"
		W1_F4_B = "Achieving financially secure retirement"
		W1_F4_D = "Achieving wealth"
		W1_F5_A = "Owning a home"
		W1_F6 = "How close to achieve the American Dream"
		PPETHM = "Ethnicity";

/* Coding for missing values as part of Data Management */
	IF W1_F3 = -1 THEN W1_F3 = .;
	IF W1_F4_B  = -1 THEN W1_F4_B = .;
	if W1_F4_D = -1 then W1_F4_D =.;
	IF W1_F5_A = -1 THEN W1_F5_A =.;
	IF W1_F6 = -1 THEN W1_F6 =.;
	
		
	
/*	CREATING NEW "INCOME" category  by collapsing PPINCIMP INTO
	just 5 groups based on frequency */
	INCOME  = PPINCIMP;
	IF PPINCIMP <= 6 THEN INCOME = 20;
	IF PPINCIMP > 6 AND PPINCIMP <= 10 THEN INCOME = 40;
	IF PPINCIMP = 11 OR PPINCIMP = 12 THEN INCOME = 60;
	IF PPINCIMP >12 AND PPINCIMP <= 15 THEN INCOME =  80;
	IF PPINCIMP > 15 THEN INCOME = 100;
	
		
	
	/* CREATING A COMPOUND VARIABLE - wealth_conf */
	WEALTH_CONF = SUM (OF W1_F4_B W1_F4_D);
	
	IF W1_F4_B =. OR W1_F4_D = . THEN WEALTH_CONF = .;	
/* 	The command above ensures that if values for either 
	of the two variables are missing, then the wealth_conf
	is also coded as "." or missing. */

LABEL WEALTH_CONF = "Confidence to achieve wealth and secure retirement";

/* 	PRINTING THE INDIVIDUAL VARIABLES TO VIEW WEALTH CONFIDENCE 
	this part of the code is currently commented out */
/* PROC PRINT; VARIABLES W1_F4_B W1_F4_D WEALTH_CONF ; */

/* COLLAPSING W1_F4_B TO JUST 2 LEVELS */
IF W1_F4_B = 1 OR W1_F4_B = 2 THEN W1_F4_B = 1;
IF W1_F4_B = 3 OR W1_F4_B = 4 THEN W1_F4_B = 4;


/* 	Our moderator variable is gender,so we use sort by PPGENDER */
	proc sort ; by  PPETHM;
		

/* 	Computing frequency distribution for 4 variables */
PROC FREQ DATA = temp_chk;
	TABLES WEALTH_CONF W1_F4_B INCOME PPAGECAT;
	
	
/*	Compute chi-sq test 
	THE Bernouli adjustment factor = 10
	So p-value < 0.005 for values to accept the alternate hypothesis
	again we take moderator variable = ethnicity = PPETHM*/	
	PROC FREQ;	
	TABLES W1_F4_B*INCOME/chisq;
	by PPETHM;
		
	
	
/* 	comparison set 1 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 20 & 40';
IF income=20 OR income=40;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;
		
		
/* 	comparison set 2 */
DATA COMPARISON2; SET temp_chk;
TITLE 'Comparison range 20 & 60';
IF income=20 OR income=60;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 3 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 20 & 80';
IF income=20 OR income=80;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 4 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 20 & 100';
IF income=20 OR income=100;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 5 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 40 & 60';
IF income=40 OR income=60;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 6*/
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 40 & 80';
IF income=40 OR income=80;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 7 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 40 & 100';
IF income=40 OR income=100;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 8 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 60 & 80';
IF income=60 OR income=80;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 9 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 60 & 100';
IF income=60 OR income=100;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;


/* 	comparison set 10 */
DATA COMPARISON1; SET temp_chk;
TITLE 'Comparison range 80 & 100';
IF income=80 OR income=100;
PROC FREQ; TABLES  W1_F4_B*INCOME/chisq;
/*BY PPETHM;
*/


RUN;
