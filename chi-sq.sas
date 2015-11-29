/*	Author - Anupama Rajaram
	Function - DV Tools week1 assignment
	Chi-square test of independence between 2 categorical variables
*/

data bikedata; 
   infile " /home/sunyblogger0/sasuser.v94/day.csv" 
   DELIMITER=',';
   Input instant dteday season yr mnth holiday weekday workingday weathersit temp atemp
   hum windspeed casual registered cnt; 

/* Giving labels to variable names for better understanding */
LABEL 	weathersit = "Weather"
		cnt = "Count"
		Season = "Season"
		temp = "Temperature"
		casual = "Casual Users"
		registered = "Member Users";
		
/* 	Computing frequency distribution for 5 variables  
PROC FREQ DATA = bikedata;
	TABLES season weathersit casual;*/
	
/* 	using number of casual users to create a new categorical variable = casual_rng
	we do this by dividing the number of casual users by % distribution
	20% = 245 users
	40% = 560 users
	60% = 845 users
	80% = 1263 users
	100% = 3410 users
*/
	casual_rng = casual;
	
	IF casual_rng < 245 THEN casual_rng = 20;
	IF casual_rng >= 245 AND casual_rng < 560 THEN casual_rng = 40;
	IF casual_rng >= 560 AND casual_rng < 845 THEN casual_rng = 60;
	IF casual_rng >= 845 AND casual_rng < 1263 THEN casual_rng = 80;
	IF casual_rng >= 1263 THEN casual_rng = 100;
	
	
/* 	similarly, changing season to just two categories, summer and winter.
	summer & fall = warm
	fall & spring = cold
*/ 		
	IF season = 3 or season = 2 then season = 1;
	ELSE season = 4;
	
	
	PROC FREQ ;
	TABLES season casual_rng;
	
/* 	Running the chi-sq test of independence to determine relation between season 
	and number of casual renters
*/	
PROC FREQ ;
	TABLES season*casual_rng/chisq;
	

/* 	Running the post hoc tests 
	There are 10 tests to be done in total
*/

/* 	comparison set 1 */
DATA COMPARISON1; SET bikedata;
TITLE 'Comparison range 20 & 40';
IF casual_rng=20 OR casual_rng=40;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 2 */
DATA COMPARISON2; SET bikedata;
TITLE 'Comparison range 20 & 60';
IF casual_rng=20 OR casual_rng=60;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 3 */
DATA COMPARISON3; SET bikedata;
TITLE 'Comparison range 20 & 80';
IF casual_rng=20 OR casual_rng=80;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 4 */
DATA COMPARISON4; SET bikedata;
TITLE 'Comparison range 20 & 100';
IF casual_rng=20 OR casual_rng=100;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 5 */
DATA COMPARISON5; SET bikedata;
TITLE 'Comparison range 40 & 60';
IF casual_rng=40 OR casual_rng=60;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 6 */
DATA COMPARISON6; SET bikedata;
TITLE 'Comparison range 40 & 80';
IF casual_rng=40 OR casual_rng=80;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 7 */
DATA COMPARISON7; SET bikedata;
TITLE 'Comparison range 40 & 100';
IF casual_rng=40 OR casual_rng=100;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 8 */
DATA COMPARISON8; SET bikedata;
TITLE 'Comparison range 60 & 80';
IF casual_rng=60 OR casual_rng=80;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 9 */
DATA COMPARISON9; SET bikedata;
TITLE 'Comparison range 60 & 100';
IF casual_rng=60 OR casual_rng=100;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;

/* 	comparison set 10 */
DATA COMPARISON10; SET bikedata;
TITLE 'Comparison range 80 & 100';
IF casual_rng=80 OR casual_rng=100;
PROC FREQ; TABLES season*casual_rng/chisq;
RUN;


