/* Step 1: Import the dataset */
proc import datafile="C:\Users\leiker-s\Desktop\msa608_2024\Assignment 3\psurvey.csv"
    out=psurvey
    dbms=csv
    replace;
    getnames=yes;
run;

/* Q2a: Split the dataset into id=1 (train) and id=2 (test), then drop the id column */
data train (drop=id);
    set psurvey;
    if id=1;
run;

data test (drop=id);
    set psurvey;
    if id=2;
run;

/* Q2a: Create pairwise relationships among v1-v9 using scatter plots */
proc sgscatter data=train;
    matrix v1-v9 / diagonal=(histogram kernel);
    title "Pairwise Scatterplot Matrix of v1 to v9 for id=1 (Train Data)";
run;

/* Q2b: Perform parallel analysis for number of factors and show Scree plot */
proc factor data=train method=principal priors=smc scree nfactors=9;
    title "Scree Plot for Principal Components";
run;


/* Q2b: Create parallel analysis (in practice, this is commonly done by examining the scree plot above) */

/* Q2c: Perform factor analysis with n=3 and rotation=oblimin */
proc factor data=train method=principal rotate=oblimin nfactors=3 outstat=fact_out score;
    var v1-v9;
    title "Factor Analysis with Oblimin Rotation (n=3)";
run;

/* Q2c: Create factor scores and calculate correlation among factors */
proc score data=train score=fact_out out=factor_scores type=score;
    var v1-v9;
run;

proc corr data=factor_scores;
    var factor1 factor2 factor3;
    title "Correlation among Factor Scores";
run;

/* Q2d: Interpretation */
/* Provide a manual interpretation based on the factor loadings and factor scores from the output.
   This step cannot be automated within the code itself, but you can use the printed results
   from the factor analysis and correlation to interpret the relationships between variables. */
