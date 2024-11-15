/*CREATE A LIBRARY*/
libname m6082024 "C:\Users\leiker-s\Desktop\msa608_2024";run; quit; 

PROC IMPORT DATAFILE= "C:\Users\leiker-s\Desktop\msa608_2024\Session 1\Session 1 Class Excercise Data.xlsx"
OUT=E1
DBMS=xlsx
REPLACE;
SHEET="Sheet1";
GETNAMES=YES;
RUN;
