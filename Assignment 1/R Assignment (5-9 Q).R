# Set the working directory and list files
setwd("C:/Users/leiker-s/Desktop/msa608_2024/Assignment 1")
list.files()

# Create a sequence of weights from 7 to 40, spaced by 1.5
weights_of_babies <- seq(7, 40, by = 1.5)
mean_weights <- mean(weights_of_babies)

# Calculate the mean and standard deviation of the weights
sd_weights <- sd(weights_of_babies)
print(weights_of_babies)

#print the sequence, mean, and standard deviation
print(mean_weights)
print(sd_weights)

#Create and display a histogram of the weights
hist(weights_of_babies, main="Histogram of Weights of Babies", xlab="Weight", col="lightblue")

# Create a sales vector with mixed values and missing values
sales <- c(NA, "TP", 4, 6.7, 'c', NA, 12)

# Find the positions of NA values in the sales vector
na_positions <- which(is.na(sales))
print(na_positions)

# Count the total number of NA values in the sales vector
total_nas <- sum(is.na(sales))
print(total_nas)

# Create a data frame with missing values
dataframe <- data.frame(
  Name = c("Bell", "Dia", "KKN", "Nia"),
  Physics = c(98, 87, 91, 94),
  Chemistry = c(NA, 84, 93, 87),
  Mathematics = c(91, 86, NA, NA))

# Replace missing values in Chemistry and Mathematics columns with the column mean
dataframe$Chemistry[is.na(dataframe$Chemistry)] <- mean(dataframe$Chemistry, na.rm = TRUE)
dataframe$Mathematics[is.na(dataframe$Mathematics)] <- mean(dataframe$Mathematics, na.rm = TRUE)
# Print the updated data frame
print(dataframe)

# Import the Titanic dataset
t1 <- read.csv('titanic.csv')

# Find the total number of survivors and print the result
num_survived <- sum(t1$Survived == 1, na.rm = TRUE)
print(paste("Total survived:", num_survived))

# Find the total number of deaths and print the result
num_dead <- sum(t1$Survived == 0, na.rm = TRUE)
print(paste("Total dead:", num_dead))

# Count the number of males and print the result
num_males <- sum(t1$Sex == "male", na.rm = TRUE)
print(paste("Number of males:", num_males))

# Count the number of females and print the result
num_females <- sum(t1$Sex == "female", na.rm = TRUE)
print(paste("Number of females:", num_females))

# Find the maximum age and print the result
max_age <- max(t1$Age, na.rm = TRUE)
print(paste("Maximum age:", max_age))

# Find the medium age and print the result
median_age <- median(t1$Age, na.rm = TRUE)
print(paste("Median age:", median_age))

# Count the number of missing age values and print the result
missing_ages <- sum(is.na(t1$Age))
print(paste("Number of missing age values:", missing_ages))

# Drop all rows with missing values
t2 <- na.omit(t1)

# Create a pie chart showing the proportion of survivors vs deaths
pie(table(t1$Survived), labels = c("Dead", "Survived"), main="Survivors vs Deaths", col=c("red", "green"))

# Create a histogram of the survived people based on gender
survived_data <- t1[t1$Survived == 1, ]
hist(as.numeric(survived_data$Sex == "male"), breaks=2, main="Survived by Gender", xlab="Gender (0=Female, 1=Male)", col="blue")

# Create the data frame with player stats: player names, positions, points, and assists
df <- data.frame(
  player = c('A', 'B', 'C', 'D', 'E', 'F'),
  position = c('R1', 'R2', 'R3', 'R4', 'R5', NA),
  points = c(102, 105, 219, 322, 232, NA),
  assists = c(405, 407, 527, 412, 211, NA))

# Create a quality variable based on point
# high if points > 215, medium if points > 120, otherwise low
df$quality <- ifelse(df$points > 215, "high",
				ifelse(df$points > 120, "medium", "low"))

# Create a performance variable based on points and assists
# Great if points > 215 and assists > 10, good if points > 215 and assists > 5, otherwise average
df$performance <- ifelse(df$points > 215 & df$assists > 10, "great",
                         ifelse(df$points > 215 & df$assists > 5, "good", "average"))

# Print the updated data frame with the new variables 
print(df)
