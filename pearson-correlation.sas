/*	Author - Anupama Rajaram
	Function - DV Tools week1 assignment
	Chi-square test of independence between 2 categorical variables
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
		

/* 	Pearson Correlation */
	Proc corr;
	var cnt atemp temp mnth season casual;
