/*	Author - Anupama Rajaram
	  Program - This program creates a bar graph with side-by-side comparison of quarterly sales for 2 years.
	            Template program for 2-subgroup comparison graph.
	            Sort of univariate graphs, with each category shown in a different color.
*/



data my_data;
input Year Quarter Sales;
datalines;
2012 1 4
2012 2 8
2012 3 9
2012 4 12
2013 1 3
2013 2 5
2013 3 10
2013 4 13
;
run;


title1 ls=1.5 "Sales Comparison";
pattern1 v=solid color=graycc;
pattern2 v=solid color=cx437193;
axis1 label=none order=(0 to 15 by 3) minor=none
offset=(0,0);
axis2 label=none value=none;
axis3 label=('Quarter') offset=(2,2);
legend1 label=none position=(top left inside) across=2
shape=bar(.12in,.12in) offset=(2,-4);
proc gchart data=my_data;
vbar year / discrete type=sum sumvar=sales
group=quarter subgroup=year
raxis=axis1 maxis=axis2 gaxis=axis3
width=9 space=0 gspace=4 coutline=white
autoref clipref cref=graydd
legend=legend1;
run;
