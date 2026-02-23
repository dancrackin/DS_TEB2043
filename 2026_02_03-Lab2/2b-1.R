# Get user input for weight (kg) and height (m)
weight <- as.numeric(readline(prompt = "Enter weight in kg: "))
height <- as.numeric(readline(prompt = "Enter height in meters: "))

# Calculate BMI using formula
bmi <- weight / (height^2)

# Categorize status based on logic
is_underweight <- bmi <= 18.4
is_normal      <- bmi >= 18.5 & bmi <= 24.9
is_overweight  <- bmi >= 25.0 & bmi <= 39.9
is_obese       <- bmi >= 40.0

# Display the results
cat("Underweight:", is_underweight, "\n")
cat("Normal:     ", is_normal, "\n")
cat("Overweight: ", is_overweight, "\n")
cat("Obese:      ", is_obese, "\n")