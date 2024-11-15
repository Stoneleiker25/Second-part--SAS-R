/* --------------------------------------------------- */
/* Part 4: Student Data (Assignment 2 Q4 Data.csv) */
/* --------------------------------------------------- */

/* Import Student Data */
proc import datafile="C:\Users\leiker-s\Desktop\msa608_2024\Assignment 2\Assignment 2 Q4 Data.csv"
	out=student_data
	dbms=csv
	replace;
	getnames=yes;
run;

/* Multiple Regression for Reading Scores */
proc reg data=student_data;
	model reading = locus_of_control self_concept motivation female;
run;

/* Multiple Regression for Writing Scores */
proc reg data=student_data;
	model writing = locus_of_control self_concept motivation female;
run;

/* Multiple Regression for Math Scores */
proc reg data=student_data;
	model math = locus_of_control self_concept motivation female;
run;

/* Multiple Regression for Science Scores */
proc reg data=student_data;
	model science = locus_of_control self_concept motivation female;
run;


/* --------------------------------------------------- */
/* Part 5: Cereal Data (Assignment 2 Q5 Data.csv) */
/* --------------------------------------------------- */

/* Import Cereal Data */
proc import datafile="C:\Users\leiker-s\Desktop\msa608_2024\Assignment 2\Assignment 2 Q5 Data.csv"
	out=cereal_data
	dbms=csv
	replace;
	getnames=yes;
run;

/* P5-Q1: Multiple Regression Model for Sales */
proc reg data=cereal_data;
	model sales = shelf calories protein fat sodium fiber carbo sugars potass vitamins weight cups adv;
run;

/* P5-Q2: Simple Regression for Sales and Fat */
proc reg data=cereal_data;
	model sales = fat;
run;

/* P5-Q3: Effect of Shelf Placement on Sales */
proc reg data=cereal_data;
	model sales = shelf;
run;
