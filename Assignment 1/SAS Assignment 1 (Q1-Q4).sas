/*Create a library to store the health dataset*/
libname health 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\';
run;
/* Import the dataset and save in the health library as health1*/
run;PROC IMPORT DATAFILE='C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\Heath Data.csv'
	OUT=health.health1
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;
/* Create a dataset called t_health*/
data t_health;
	set health.health1;
run;
/* Calculate mean and standard deviation of all variables*/
proc means data=t_health mean std;
run;
/* Print the value of RBC for subject 11005*/
proc print data=t_health;
	where subj=110055;
	var rbc;
run;
/* Get summary statistics for RBC, Hcrit, WBC, and MCHC for each hospital*/
proc means data=t_health mean std min max;
	class hosp;
	var rbc hcrit wbc mchc;
run;
/* Output mean and medican for each Hospital*/
proc means data=t_health mean median;
	class hosp;
	var rbc wbc hcrit;
	output out=Hospitals_mean_median mean=mean_rbc mean_wbc mean_hcrit
									median=median_rbc median_wbc medican_hcrit;
run;
/* Create a histogram for WBC*/
proc sgplot data=t_health;
	histogram wbc;
	title "Histogram of WBC";
run;
/* Create a boxplot for WBC*/
proc sgplot data=t_health;
	vbox wbc;
	title "Boxplot of WBC";
run;
/* Create a scatterplot where X-axis is RBC and Y-axis is WBC*/
proc sgplot data=t_health;
	scatter x=rbc y=wbc;
	title "Scatterplot of RBC vs WBC";
run;
/*Create separate datasets for subject 210006, 310032, and 410010*/
data s210006;
	set t_health;
	where subj=210006;
run;

data s310032;
	set t_health;
	where subj=310032;
run;

data s410010;
	set t_health;
	where subj=410010;
run;
/*Create a library to store the grades dataset*/
libname grades 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1';
run;
/* Import the dataset and save in the grades library as student_grades*/
PROC IMPORT DATAFILE= 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\Student Grades.csv'
	OUT=grades.student_grades
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;
/*Sort the data by student ID and grade*/
Proc sort data=grades.student_grades out=sorted_grades;
	by idno grade;
run;
/* Create a dataset with the lowest grade for each student*/
data lowest_grade;
	set sorted_grades;
	by idno;
	if first.idno then output;
run;
/* Print the lowest grades and the corresponding semesters*/
proc print data=lowest_grade;
	title 'Lowest Grades and Semester for each Student';
run;
/* Transpose the dataset from long to wide format*/
proc transpose data=grades.student_grades out=wide_grades;
	by idno;
	id gtype;
	var grade;
run;
/* Print the transposed student grades*/
proc print data=wide_grades;
	title 'Transposed Student Grades';
run;
/*Create a library to store the weather dataset*/
libname weather 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1';
run;
/* Import the atmosphere dataset*/
PROC IMPORT DATAFILE= 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\Atmosphere.csv'
	OUT=weather.atmosphere
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;
/* Convert Celsius to Fahrenheit using a DO loop for each month*/
data fahrenheit;
	set weather.atmosphere;
	array months {*} jan--dec;
	do i = 1 to dim(months);
		months[i] = 1.8 * months[i] + 32;
	end;
run;
/* Print the converted temperatire data*/
proc print data=fahrenheit;
	title 'Temperature Converted to Fahrenheit';
run;

data fahrenheit2;
	set weather.atmosphere;
	array temps {*} jan--dec;
	do i = 1 to dim(temps);
		temps[i] = 1.8 * temps[i] + 32;
	end;
run;
/* Print the fahrenheit*/
proc print data=fahrenheit2;
	title 'Celsius to Fahrenheit Conversion (fahrenheit2 dataset)';
run;
/*Create a library to store the patient dataset*/
libname patients 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1';
run;
/* Import datasets d1 and d2*/
PROC IMPORT DATAFILE= 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\d1.csv'
	OUT=patients.d1
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE= 'C:\Users\leiker-s\Desktop\msa608_2024\Assignment 1\d2.csv'
	OUT=patients.d2
	DBMS=csv
	REPLACE;
	GETNAMES=YES;
RUN;
/* Sort both datasets by OD for merging*/
proc sort data=patients.d1; by id; run;
proc sort data=patients.d2; by id; run;
/* Merge two datasets by ID*/
/* Merge two datasets by ID*/
data merged;
	merge patients.d1 (in=a) patients.d2 (in=b);
	by id;
	if a and b;
run;

/*Display the structure of the merged dataset*/
proc contents data=merged; run;
proc print data=merged (obs=10); run;
/* Calculate the means of numeric variables for later use*/
proc means data=merged noprint;
	var _numeric_;
	output out=means mean= / autoname;
run;
/* Replace missing values with the mean of the corresponding variable*/
data cleaned_data;
	set merged;
	if _n_ = 1 then set means;

	array vars {*} _numeric_;
	array means_arr {*} _numeric_mean_;

	do i = 1 to dim(vars);
		if missing(vars[1]) then vars[i] = means_arr[i];
	end;
run;
/* Print the cleaned dataset with missing values replaced*/
proc print data=cleaned_data (obs=10);
	title 'Merged Dataset with Missing Values Replaced by Mean';
run;
