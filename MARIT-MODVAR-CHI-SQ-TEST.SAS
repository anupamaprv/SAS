/*	Author - Anupama Rajaram
	Description - 	correlation test that includes a moderator.
					Coursera week4 assignment for Data Analysis tools
					This program imports data from a file called "anu_ool_pds-wc.csv"
					this file has ~2900 rows. 
					
	Process -   Moderator var = MARIT, which is computed from the excel variable PPMARIT.
					Input var PPINCIMP has been converted to a new variable INCOME wihth just 5 levels.
					Chi-square test is performed between W1_F4_B and INCOME, based on PPMARIT.
					The posthoc tests are also calculated for every variation of MARIT. 
					
	Conclusion -  Results indicate that only MARIT = 1 (Married or Living Together) has 
	        any statistical significance, since our adjusted p-value = 0.005.
	        That too only for comparisons between income = 20&100, 40&100, 60&100.
	        
	        If we do not use the moderator variable for posthoc tests, we see that p-value
	        <0.005 for samples = 20&80, 20&100, 40&100, 60&100.
	        i.e sample significance is now seen for 20&80 also.
	        
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
	just 4 groups based on frequency */
	INCOME  = PPINCIMP;
	IF PPINCIMP <= 6 THEN INCOME = 20;
	IF PPINCIMP > 6 AND PPINCIMP <= 10 THEN INCOME = 40;
	IF PPINCIMP = 11 OR PPINCIMP =12 THEN INCOME =  60;
	IF PPINCIMP >12 AND PPINCIMP <= 15 THEN INCOME =  80;
	IF PPINCIMP > 15 THEN INCOME = 100;
	
	
/*	CREATING NEW "MARIT" category  by collapsing PPMARIT  INTO
	just 3 groups based on frequency */
		
	IF PPMARIT = 1 OR PPMARIT = 6 THEN MARIT = 1; /* MARRIED OR LIVING WITH PARTNER */
	IF PPMARIT = 2 THEN MARIT = 2; /* WIDOWED */
	IF PPMARIT = 3 OR PPMARIT = 4 THEN MARIT = 3; /* SEPARATED OR DIVORCED */
 	IF PPMARIT = 5 THEN MARIT = 5 ;/* NEVER MARRIED / SINGLE  */
		
		
	
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

	proc sort ; by  MARIT;

/* 	Computing frequency distribution for 5 variables */
	PROC FREQ DATA = temp_chk;
	TABLES W1_F4_B PPETHM PPGENDER PPMARIT MARIT;
	
	PROC FREQ;	
	TABLES W1_F4_B*INCOME/chisq;
		BY MARIT;
		
	
	
	/* 	comparison set 1 */
DATA COMPARISON1; SET  temp_chk;
TITLE 'Comparison range 20 & 40';
IF INCOME=20 OR INCOME=40;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 2 */
DATA COMPARISON2; SET  temp_chk;
TITLE 'Comparison range 20 & 60';
IF INCOME=20 OR INCOME=60;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 3 */
DATA COMPARISON3; SET  temp_chk;
TITLE 'Comparison range 20 & 80';
IF INCOME=20 OR INCOME=80;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 4 */
DATA COMPARISON4; SET  temp_chk;
TITLE 'Comparison range 20 & 100';
IF INCOME=20 OR INCOME=100;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 5 */
DATA COMPARISON5; SET  temp_chk;
TITLE 'Comparison range 40 & 60';
IF INCOME=40 OR INCOME=60;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 6	*/
DATA COMPARISON6; SET  temp_chk;
TITLE 'Comparison range 40 & 80';
IF INCOME=40 OR INCOME=80;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 7 */
DATA COMPARISON7;	 SET  temp_chk;
TITLE 'Comparison range 40 & 100';
IF INCOME=40 OR INCOME=100;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 8*/
DATA COMPARISON8; SET  temp_chk;
TITLE 'Comparison range 60 & 80';
IF INCOME=60 OR INCOME=80;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 9 */
DATA COMPARISON9; SET  temp_chk;
TITLE 'Comparison range 60 & 100';
IF INCOME=60 OR INCOME=100;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;


	/* 	comparison set 10 */
DATA COMPARISON10; SET  temp_chk;
TITLE 'Comparison range 80 & 100';
IF INCOME=80 OR INCOME=100;
PROC FREQ; TABLES W1_F4_B*INCOME/chisq;
	BY MARIT;
