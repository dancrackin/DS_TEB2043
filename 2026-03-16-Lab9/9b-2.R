library(caret)

data(mtcars)

# normalizing data
scaled_data <- log(mtcars)
print(scaled_data)

# normalizing data with standard scaling
scaled_data2 <- as.data.frame(scale(mtcars))
print(scaled_data2)

# normalizing data with min-max scaling
minmax <- preProcess(as.data.frame(mtcars), method=c("range"))
scaled_data3 <- predict(minmax, as.data.frame(mtcars))
print(scaled_data3)

cat("\n--- RAW DATA SUMMARY FOR ---\n")
print(summary(mtcars$mpg))
cat("\n--- LOG TRANSFORMED SUMMARY ---\n")
print(summary(scaled_data$mpg))
cat("\n--- STANDARD SCALED SUMMARY ---\n")
print(summary(scaled_data2$mpg))
cat("\n--- MIN-MAX SCALED SUMMARY ---\n")
print(summary(scaled_data3$mpg))

cat(
    "\n--- NORMALIZATION COMPARISON (Focus on MPG) ---\n\n",
    
    "1. Raw Data: The original 'mpg' values have a wide spread, ranging from a minimum of 10.4 to a maximum of 33.9.\n",
    "2. Log Transform: The 'mpg' values are heavily compressed (now ranging from roughly 2.3 to 3.5). This technique reduces skewness and pulls extreme outliers closer to the average.\n",
    "3. Standard Scaling: The mean of the 'mpg' column has been forced to exactly 0.00. The numbers now represent how many standard deviations a specific car's MPG is from the overall average.\n",
    "4. Min-Max Scaling: The car with the worst MPG is now exactly 0.0, and the car with the best MPG is exactly 1.0. All other cars are strictly scaled between these two absolute boundaries.\n\n",
    
    "Overall Conclusion:\n",
    "Log handles extreme outliers, Standard scaling centers the data for normal distribution, and Min-Max creates rigid boundaries.\n"
)