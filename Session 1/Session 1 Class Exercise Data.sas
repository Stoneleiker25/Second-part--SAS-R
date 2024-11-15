PROC IMPORT DATADILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\Assignments\Session 1 Class Excercise Data\"
out=E1
DBMS=xlsx
REPLACE;
SHEET="Sheet1";
GETNAMES=YES;
RUN;

/****NAME AND PREQUENCY EXPOSURE*/
proc freq data=e1; table Channel_subscribed Gender_of_household ;run;

data e2; set e1; if Channel_subscribed="Amazon P" or Channel_subscribed="Amazon Prime" then amazon_prime=1;
if Channel_subscribed="Netflix; Amazon Prime" then  amazon_prime=1 ;
if Channel_subscribed="Netflix; Amazon Prime" then  netflix=1;
if Channel_subscribed="ESPN; Hulu" then espn=1;
if Channel_subscribed="ESPN; Hulu" then hulu=1;
if Channel_subscribed="Hulu" then hulu=1;
if Channel_subscribed="Hulu; Amazon" then hulu=1;
if Channel_subscribed="Amazon_xxx" then amazon_prime=1;

if Channel_subscribed="Hulu; Amazon" then amazon_prime=1;
if Channel_subscribed="Netflix" then netflix=1;
if Channel_subscribed="Netflix; Hulu" then  hulu=1;
if Channel_subscribed="Netflix; Hulu" then netflix=1;

if Gender_of_household="FE" or Gender_of_household="Female" then gender=1;else gender=0;run;

proc reg data=e3; model consumption=amazon_prime ne hulu espn;

/*In E2, we observe that there are missign values. How do we fill them?*/
data e3;set e2;
if amazon_prime=. then amazon_prime=0;
if netflix=. then netflix=0;
if espn=. then espn=0;
if hulu=. then hulu=0; run; quit;

/*now if we rant to randomly check if the codes were correctly*/
data e4; set e3; if _n_=60;run;

proc means data=e3; var Weekly_orange_juice_consumption Weekly_meat_consumption Income;run;

