/*	Author - Anupama Rajaram
	Function - DV Tools week4 assignment
	Computing Pearson correlation with moderator variable
*/

data bikedata; 
   infile "/home/sunshinegirl48860/day.csv" 
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
		
/* 	Creating new varibale ws to convert windspeed to categorical variable */
	ws = windspeed;
	
	IF windspeed < 0.135 then ws = 25;
	if windspeed >= 0.135 and windspeed <0.18 then ws =50;
	if windspeed >= 0.18 and windspeed < 0.235  then ws = 75;
	if windspeed >= 0.235 then ws = 100;		
	
		PROC SORT; by ws;			
		proc freq;  tables ws;
	
/* 	Pearson Correlation */
	Proc corr;
	var cnt atemp temp mnth casual ; by ws;

