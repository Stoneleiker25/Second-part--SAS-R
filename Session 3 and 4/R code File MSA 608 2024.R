Data Import

#First Approach

#First One: Setup a working directory

setwd("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4")
list.files()

#If the file is in .csv format 
directory_data1<-read.csv("Session3-iris.csv")
directory_data1

#If it is a text file
directory_data2<-read.table("Session3-iris.txt")


#If the file is an excel file
install.packages("readxl")
library("readxl")

directory_data3<-read_excel("Session3-renew_behavior_xxx_logit.xlsx")

direct_import1<-read.table("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4/Session3-iris.txt", header=T)
direct_import2<-read.csv("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4/Session3-iris.csv", header=T)
direct_import3<-read_excel("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4/Session3-renew_behavior_xxx_logit.xlsx")


###Exploring Dataset
df<-read.csv("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4/Session3-iris.csv", header=T)

View(df)  # allows us to view the data set
names(df)  # names of the variables 
dim(df)  # dimension (number of rows and columns)
str(df)  # structure of the data set
head (df,30)  #provides structure of the data set along with number of obs and variables
tail (df,5)

#Getting summary statistics (How do we know which packages to use where?)
install.packages("Hmisc")#Contains many functions useful for data analysis, high-level graphics, utility operations, functions for computing sample size and power
library(Hmisc)
install.packages("pastecs")#https://cran.r-project.org/web/packages/pastecs/index.html (SPACE-TIME SERRIES)
library(pastecs)
install.packages("psych")#https://cran.r-project.org/web/packages/psych/index.html (FOR ALL DESCRIPTIVES)
library(psych)

summary(df)#this provides you with the descriptive statistics of each variable
summary(df$Sepal.Length)
fivenum(df$Sepal.Length)

describe(df$Sepal.Length)#This will need HMIS and pastac package

df1<-read.csv("C:/Users/leiker-s/Desktop/msa608_2024/Session 3 and 4/Session3-data_corr_mkt.csv")
names(df1)

df1$sum<-df1$Price+df1$Promotion
View(df1)

