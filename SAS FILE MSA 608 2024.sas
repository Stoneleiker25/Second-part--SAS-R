/*****SESSION 1 CODE*/
/*CREATE A LIBRARY*/
libname m6082024 "C:\Users\leiker-s\Desktop\msa608_2024";run; quit; 
/*Import Data*/
/*Approach 1: Importaing through codes*/
PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\Dataset 1-Retail SalesMarketing.xls"
OUT=dataset1/*since the ouput dataset dataset does not start with name of the library, it will be stored in the work folder*/
DBMS=xls
REPLACE;
SHEET="Sheet1";
GETNAMES=YES;
RUN;
/*Storing a work file into the library*/
data m6082024.dataset1; set dataset1;run; quit;

/*Arithmatic operations (this is also for new variable creation*/
data pl;set M6082024.dataset1_UPDATED;
percentage_revenue=revenue*.1;
total_rev=Planned_revenue+revenue;
differce_revenue=revenue-Planned_revenue;
ratio_revenue=revenue/Planned_revenue;run; QUIT;

/*Convert character variable to numeric*/
/*Check the distribution of the variable*/
PROC freq data=m6082024.dataset1_updated; table Order_method_type;run; quit;

/*Convert the ordermethod type to binary classification*/

data p2;set m6082024.dataset1_updated; 
if order_method_type="E-mail" then email=1;else email=0;
if order_method_type="Fax" then fax=1;else fax=0;
if order_method_type="Mail" then mail=1;else mail=0;
if order_method_type="Sales vis" then sales_vis=1;else sales_vis=0;
if order_method_type="Special" then Special=1;else Special=0;
if order_method_type="Telephone" then Telephone=1;else Telephone=0;
if order_method_type="Web" then Web=1;else Web=0;run;quit;

/* We need to create additional variables and different transformation. * represents multiplication and ** means power*/
data p3;set p2;
revenue_cube=revenue**3; 
revenue_sq=revenue**2;
revenue_sqroot=revenue**(1/2); 
revenue_cuberoot=revenue**(1/3);run;

/* We will create two groups: high_revenue_product represented by 1 if revenue>100000 and by 0 if revenue<100000*/
/* We will also create a classification: high_cost, medium_cost, and low cost based on product_cost*/
data p4;set p3; if revenue>100000 then high_revenue_product=1;else
high_revenue_product=0;
if product_cost>100000 then types_product="high_cost";
if 50000<product_cost=<100000 then types_product="medium_cost";
if product_cost=< 50000 then types_product="low_cost";run;

/*keep, rename, drop statements*/
/*keep, rename, keep statements you might want to drop (keep) unnecessary (necessary) variables, rename a variable*/

data p5(rename=(Unit_sale_price=unit_price unit_cost=cost));set p4;run;
data p6(drop=product_line);set p5;run; 
data p7 (keep=revenue--id);set p6;run;/*by putting --between two variables, we are asking SAS to keep all the variables between these two*/

/**_n_represents row number*/
/**Subsetting data: When dataset is large and you want to use a small portion or when you want data between specific obsrvations, we can subset data*/
data p8;set p7; if _n_>10000;run; 
data p9;set p7;if _n_<5000 then delete; run; 
data p10; set p7; if revenue>100000 then delete; run;
/**how to find the number of obs, menas of the variables, std of variables, and max of variables*/

proc means data=p7; var Revenue Quantity cost;run;; quit;
/*Session 2*/
/*Import Dataset2*/

/*Merge TWO DATASETS*/
PROC SORT DATA=M6082024.DATASET1;BY ID;run;
PROC SORT DATA=M6082024.DATASET2;BY ID;run;

data merged; merge msa.dataset2 msa.dataset1;by id; run;

PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\rollingsales_bronx.xlsx"
OUT=bronx
DBMS=xlsx
REPLACE;
SHEET="Bronx";
GETNAMES=NO;
RUN;

Data bronx1;set bronx;if _n_>4;run;

proc transpose data=bronx1 out=bronx2;
var _all_;
run;

proc transpose data=bronx2(drop=_name_ rename=(col1=_name_)) 
out=bronx3(drop=_name_ _label_);
 var col:;
 id _name_;
run;

/*for brooklyn data*/
PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\rollingsales_brooklyn.xlsx"
OUT=brooklyn
DBMS=xlsx
REPLACE;
SHEET="Brooklyn";
GETNAMES=NO;
RUN;
Data brooklyn1;set brooklyn;if _n_>4;run;
proc transpose data=brooklyn1 out=brooklyn2;
var _all_;
run;
proc transpose data=brooklyn2(drop=_name_ rename=(col1=_name_)) 
out=brooklyn3(drop=_name_ _label_);
 var col:;
 id _name_;
run;

/*for Manhattan data*/
PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\rollingsales_manhattan.xlsx"
OUT=manhattan
DBMS=xlsx
REPLACE;
SHEET="Manhattan";
5
GETNAMES=NO;
RUN;
Data manhattan1;set manhattan;if _n_>4;run;
proc transpose data=manhattan1 out=manhattan2;
var _all_;
run;
proc transpose data=manhattan2(drop=_name_ rename=(col1=_name_)) 
out=manhattan3(drop=_name_ _label_);
 var col:;
 id _name_;
run;

/*for Queens data*/
PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\rollingsales_queens.xlsx"
OUT=queens
DBMS=xlsx
REPLACE;
SHEET="Queens";
GETNAMES=NO;
RUN;
Data queens1;set queens;if _n_>4;run;
proc transpose data=queens1 out=queens2;
var _all_;
run;
proc transpose data=queens2(drop=_name_ rename=(col1=_name_)) 
out=queens3(drop=_name_ _label_);
 var col:;
 id _name_;
run;
/*for STATEISLAND data*/
PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\rollingsales_statenisland.xlsx"
OUT=statenisland
DBMS=xlsx
REPLACE;
SHEET="State_Island";
GETNAMES=NO;
RUN;
Data statenisland1;set statenisland;if _n_>4;run;
proc transpose data=statenisland1 out=statenisland2;
var _all_;
run;
proc transpose data=statenisland2(drop=_name_ rename=(col1=_name_)) 
out=statenisland3(drop=_name_ _label_);
var col:;
 id _name_;
run;

/*Combine all 5 datasets*/
DATA combined; set bronx3 brooklyn3 manhattan3 queens3 statenisland3;run;

/*In class exercise 2*/

PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 2\In Class Practice Product1_Data"
OUT=p1
DBMS=xlsx
REPLACE;
SHEET="Sheet1";
GETNAMES=YES;
RUN;


PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 2\In Class Practice Product2_Data"
OUT=p2
DBMS=xlsx
REPLACE;
SHEET="Sheet1";
GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 2\In Class Practice Product3_Data"
OUT=p3
DBMS=xlsx
REPLACE;
SHEET="Sheet2";
GETNAMES=YES;
RUN;

data p11(rename=(id=_Market_code year_and_date=time));set p1;run;
data p22(rename=(code=_market_code));set p2;run;

proc sort data=p11; by _market_code time; run;
proc sort data=p22; by _market_code time; run;
proc sort data=p3; by _market_code time; run;

data final; merge p11 p22 p3;by _market_code time;run;


data final1;set final; sum_of_sales=sales_product1+sales_product2+sales_product3;run;

/*Question 3*/
proc sql;
Create table final as
select *, sum(sales_product1) as sum_sales_product1, sum(production_product1) as sum_production_product1
from final1 group by _Market_code;run; quit;

proc sort data=fianl2 out=final3 nodupkey;by _Market_code;run;

data final4(keep= _Market_code sum_sales_product1);set final3;run;

/*******Proc SQL (used for Creating new datasets from an existing one, 
sorting dataset, Merging datasets, Selecting distinct rows from dataset***/
/*Showing what is in the data*/
proc sql; create table t1 as
select * from sashelp.class
;
quit;

proc print data=sashelp.class;
var name age;
run;
proc sql;
select name,age from sashelp.class;
quit;

/*Creating new dataset from existing data*/
Data class_new;
Set sashelp.class;
Run;

/*Creating new dataset from existing data*/
Data class_new;
Set sashelp.class;
Run;
proc sql;
create table class_new as
 select * from sashelp.class
 ;
quit;
/*Conditional statement using where in proc sql*/
data classfit_males;
set sashelp.classfit;
 where sex = 'M';
run; 
proc sql;
 select * from classfit_males where sex="M"
 ;
quit; 
/***Update a dataset*/
proc sql;
create table class_heights as
select name, height as height_inches, (height*2.54) as height_cm from
sashelp.class;
quit;

data k1(rename= (height=height_inches)); set sashelp.class;
height_cm=height*2.54;run;

/*Data cleaning*/
data p;set sashelp.cars;run; 
proc sql;
 delete
 from p
 where Horsepower>200;
quit;

/* Loops and Visualization*/
/*constructing do loops*/
/*The General form of do loop is as follows

DO index-variable = start To stop BY increment;
	action statements;
END;

/*Practice 1: uses an iterative DO loop to tell SAS to determine the 
multiples of 10 up to 100*/
DATA multiply (drop = i);
 multiple = 0;
 do i = 1 to 20;
 multiple + 10;
 output;
end;
RUN;
PROC PRINT NOOBS;
title 'Multiples of 10 up to 200';
RUN;

/*Prcatice 2: uses an iterative DO loop to count backwards by 1*/
DATA backwardsbyone;
do i = 20 to 1 by -1;
 output;
 end;
RUN;
PROC PRINT data = backwardsbyone NOOBS;
title 'Counting Backwards by 1';
RUN;

/*Prcatice 3-Nested loop: Suppose you are interested in conducting an 
experiment with two factors A and B. Suppose factor A is, say, the amount of 
water with levels 1, 2, 3, and 4; 
and factor B is, say, the amount of sunlight, say with levels 1, 2, 3, 4, and 
5. 
Then, the following SAS code uses nested iterative DO loops to generate the 4 
by 5 factorial design*/
DATA design;
DO i = 1 to 4;
 DO j = 1 to 5;
 output;
 END;
 END;
RUN;
PROC PRINT data = design;
 TITLE '4 by 5 Factorial Design';
RUN;
/*Prcatice 4: Suppose factor A is the amount of water with levels 10, 20, 30, 
and 40 liters; and factor B is the amount of sunlight, say with levels 3, 6, 
9, 12, and 15 hours. 
The following SAS code uses two DO loops with BY options to generate a more 
meaningful 4 by 5 factorial design that corresponds to the exact levels of 
the factors*/
DATA design;
DO i = 10 to 40 by 10;
 DO j = 3 to 15 BY 3;
 output;
 END;
 END;
RUN;
PROC PRINT data = design;
 TITLE '4 by 5 Factorial Design';
RUN;

/*Practice 5-Calculating CD values: Every Monday morning, Discover bank 
announces the interest rates for certificates of deposit (CDs) that it will 
honor for CDs opened during the business week.
Suppose you want to determine how much each CD will earn at maturity with an 
initial investment of $5,000. 
The following program reads in the interest rates advertised one week in July 
2023, and then uses a DO loop to calculate the value of each CD when it 
matures*/

DATA cdinvest (drop = i);
input Type $ AnnualRate Months;/*$ after types is to so that the values 
should be numeric. If you do not put it, you will not see the types in the 
table*/
 Investment = 5000;
 do i = 1 to Months;
 Investment + (AnnualRate/12)*Investment;
end;
format Investment dollar8.2;/*format is used in the compile phase to 
create the program data vector. dollar8.2 is for fomatting, that allocates a 
total of 8 spaces for the output. 
One space will be for the decimal and 2 for the digits to the right of 
the decimal; this will leave 5 spaces for the digits to the left of the 
decimal.*/
 DATALINES;
03Month .04 3
06Month .0425 6
09Month .0450 9
12Month .0475 12
18Month .0500 18
24Month .0450 24
36Month .0425 36
48Month .0400 48
60Month .0375 60
;
RUN;
PROC PRINT data = cdinvest NOOBS;
 title 'Comparison of Different CD Rates';
RUN;
/*Prcatice 6- Suppose we want to know time required to have $1000000 in 
savings if we deposit 36000 with 6% interest-Do unitil loop*/
DATA investment;
DO UNTIL (value >= 1000000);
 value +36000;
 value + value * 0.06;
 year + 1;
 OUTPUT;
END;

RUN;
PROC PRINT data = investment NOOBS;
title 'Years until at least $1000,000';
RUN;
/*Practice 6-Do While loop for the same thing as in Prcatice 6*/
DATA investtwo;
 DO WHILE (value =< 1000000); /*only difference is here*/
value +36000;
value + value * 0.06;
year + 1;
OUTPUT;
 END;
RUN;
PROC PRINT data = investtwo NOOBS;
title 'Years until at least $1000,000';
RUN;
/*Practice 8: Suppose we want to know how many years it would take to 
accumulate 1000000 if we deposit 36000
into an account that earns 6% interest.suppose we also want to limit the 
number of years that we invest to 20 years.
The following program uses a conditional iterative DO loop to accumulate our 
investment until we reach 20 years or until the value of our investment 
exceeds 1000000, 
whichever comes first*/
DATA invest (drop = i);
 DO i = 1 to 20 UNTIL (value >= 1000000);
 value + 36000;
 value + value * 0.06;
 year + 1;
 OUTPUT;
 END;
RUN;

PROC PRINT data = invest NOOBS;
 title 'Value of Investment';
RUN;

/*Univariate Statistical Analysis--Knowing how each variable looks like*/
proc univariate data = sashelp.cars;run;
proc univariate data = sashelp.cars;var Weight; run;
proc univariate data = sashelp.cars plots;
var Weight; 
run;

/*Histogram*/
TITLE 'Summary of Weight Variable (in pounds)';
PROC UNIVARIATE DATA = sashelp.class NOPRINT;
HISTOGRAM weight/NORMAL;
RUN;

proc univariate data = sashelp.cars noprint;
histogram horsepower/ normal (
mu = est
sigma = est
color = blue
w = 2.5
)
barlabel = percent
midpoints = 70 to 550 by 50;
RUN;

/*Box Plot (normal)*/
PROC SQL;
create table CARS1 as
SELECT make, model, type, invoice, horsepower, length, weight
 FROM
 SASHELP.CARS
 WHERE make in ('Audi','BMW')
;
RUN;
PROC SGPLOT DATA = CARS1;
 VBOX horsepower 
 / category = type;
 title 'Horsepower of cars by types';
RUN;
/*Boxplot in Horizontal Panels*/
PROC SGPANEL DATA = CARS1;
PANELBY MAKE / columns = 1 novarname;
 VBOX horsepower / category = type;
 title 'Horsepower of cars by types';
RUN;

/*Bar Charts*/
PROC SGPLOT DATA = sashelp.cars;
VBAR type;
TITLE 'cars by types';
RUN;
/*Staked Bar*/
proc SGPLOT data = sashelp.cars;
vbar length /group = type ;
title 'Lengths of Cars by Types';
run;
quit;
/*clustered bars*/
data cars1;set sashelp.cars;run;
PROC SGPLOT DATA = sashelp.cars;
VBAR type / GROUP = origin GROUPDISPLAY = CLUSTER;
TITLE 'CARS BY TYPE AND ORIGIN';
RUN;
/*Pie diagram*/
proc chart data= cars1; 
pie type; 
run; 
/*or*/
PROC SQL;
create table CARS1 as
SELECT make, model, type, invoice, horsepower, length, weight
FROM
SASHELP.CARS
WHERE make in ('Audi','BMW')
;quit;
PROC TEMPLATE;
 DEFINE STATGRAPH pie;
 BEGINGRAPH;
 LAYOUT REGION;
 PIECHART CATEGORY = type /
 DATALABELLOCATION = OUTSIDE
 CATEGORYDIRECTION = CLOCKWISE
 START = 180 NAME = 'pie';
 DISCRETELEGEND 'pie' /
 TITLE = 'Car Types';
 ENDLAYOUT;
 ENDGRAPH;
 END;
RUN;
PROC SGRENDER DATA = cars1
 TEMPLATE = pie;
RUN;














