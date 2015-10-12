/*	Author - Anupama Rajaram
	Function - Calculate frequency distribution and graphs for research questions */


/*	Importing data from a file called "anu_ool_pds-w3.csv
	this file has 290 rows. Values stored in object call "temp_chk" */
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
		PPMARIT = "Marriage status"
		MARG = "Marital status";

/* Coding for missing values as part of Data Management */
	IF W1_F3 = -1 THEN W1_F3 = .;
	IF W1_F4_B  = -1 THEN W1_F4_B = .;
	if W1_F4_D = -1 then W1_F4_D =.;
	IF W1_F5_A = -1 THEN W1_F5_A =.;
	IF W1_F6 = -1 THEN W1_F6 =.;
	
/* 	collapsing marriage status categories into 2 categories under new variable "MARG"
	Combining option 1 = "married" and 6 = "living together" as MARG = 1;
	Marking missing values "-1" and "-2" as "." to denote missing for MARG
	all other options marked as 2 under single */
	IF (PPMARIT = 1 OR PPMARIT = 6) THEN MARG =1 ;
/*	ELSE IF (PPMARIT = -1 OR PPMARIT = -2) THEN MARG =, ;	*/
	ELSE MARG = 2;
	
/* 	collapsing W1_F4_B categories into 2 categories 
	Combining option 1 OR 2 INTO W1_F4_B = 1;
	OPTION 3,4  MARKED AS 4 */
	IF (W1_F4_B = 1 OR W1_F4_B = 2) THEN W1_F4_B =1 ;
	ELSE IF (W1_F4_B = 3 OR W1_F4_B = 4) THEN W1_F4_B =4 ;	
	
/* 	collapsing W1_F4_D categories into 2 categories 
	Combining option 1 OR 2 INTO W1_F4_D = 1;
	OPTION 3,4  MARKED AS 4 */
	IF (W1_F4_D = 1 OR W1_F4_D = 2) THEN W1_F4_D =1 ;
	ELSE IF (W1_F4_D = 3 OR W1_F4_D = 4) THEN W1_F4_D =4 ;
	
/* 	collapsing W1_F5_A categories into 2 categories 
	Combining option 1 OR 2 INTO W1_F5_A = 1;
	OPTION 3,4  MARKED AS 4 */
	IF (W1_F5_A = 1 OR W1_F5_A = 2) THEN W1_F5_A =1 ;
	ELSE IF (W1_F5_A = 3 OR W1_F5_A = 4) THEN W1_F5_A =4 ;
	
/* 	Only considering participants in age range 25-34 */
	IF PPAGECAT=2;

/* CREATING A COMPOUND VARIABLE - wealth_conf */
	WEALTH_CONF = SUM (OF W1_F4_B W1_F4_D W1_F5_A);
	
	IF W1_F4_B =. OR W1_F4_D = . OR W1_F5_A =. THEN WEALTH_CONF = .;	
/* 	The command above ensures that if values for either 
	of the THREE variables are missing, then the wealth_conf
	is also coded as "." or missing. */
	
LABEL WEALTH_CONF = "Wealth Confidence"; 

/* 	Computing frequency distribution for EXPLANATORY variables */
PROC FREQ DATA = temp_chk;
	TABLES WEALTH_CONF MARG PPGENDER ;
RUN;


/* creating univariate graph chart for varibale wealth_conf  */
TITLE 'Wealth Confidence in %';
PROC GCHART; VBAR WEALTH_CONF/DISCRETE  TYPE= percent width= 10 percent;
	run;
	
	
TITLE 'Marital Status';
PROC GCHART; VBAR MARG/DISCRETE  TYPE= percent width= 10 percent;
	run;
	
TITLE 'Gender';
PROC GCHART; VBAR PPGENDER/DISCRETE  TYPE= percent width= 10 percent;
	run;
	


/* graph showing wealth confidence by marital status */	
title1 ls=1.5 "wealth confidence by marital status";
pattern1 v=solid color= big;
pattern2 v=solid color = DARKORANGE;
proc gchart data=temp_chk;
vbar MARG/discrete type= sum sumvar=WEALTH_CONF
group=WEALTH_CONF subgroup=MARG freq;
run;	




/* graph showing wealth confidence by gender */	
title1 ls=1.5 "wealth confidence by gender";
pattern1 v=solid color= BLUE;
pattern2 v=solid color = PINK;
proc gchart data=temp_chk;
vbar PPGENDER/discrete type= sum sumvar=WEALTH_CONF
group=WEALTH_CONF subgroup=PPGENDER freq;
run;	
