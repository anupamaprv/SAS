/*	Author - Anupama Rajaram
	Program - We create a dataset called "data" and then sort it according to 
	          two variables : town, company
*/


options nodate pageno=1 linesize=80 pagesize=60;

/* create var called "data' and populate it*/
data account;
   input Company $ 1-22 Debt 25-30 AccountNumber 33-36 
         Town $ 39-51;
   datalines;
Paul's Pizza             83.00  1019  Apex
World Wide Electronics  119.95  1122  Garner
Strickland Industries   657.22  1675  Morrisville
Ice Cream Delight       299.98  2310  Holly Springs
Watson Tabor Travel      37.95  3131  Apex
Boyd & Sons Accounting  312.49  4762  Garner
Bob's Beds              119.95  4998  Morrisville
Tina's Pet Shop          37.95  5108  Apex
Elway Piano and Organ    65.79  5217  Garner
Tim's Burger Stand      119.95  6335  Holly Springs
Peter's Auto Parts       65.79  7288  Apex
Deluxe Hardware         467.12  8941  Garner
Pauline's Antiques      302.05  9112  Morrisville
Apex Catering            37.95  9923  Apex
;

/* sorting the data*/
proc sort data=account out=bytown;
by town company;
run;


proc print data=bytown;

var company town debt accountnumber;

 title  'Customers with Past-Due Accounts';
   title2 'Listed Alphabetically within Town';
run;
