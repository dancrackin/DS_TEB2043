# Creating the named list
student_scores <- list(
    Robert = 59,
    Hemsworth = 71,
    Scarlett = 83,
    Evans = 68,
    Pratt = 65,
    Larson = 57,
    Holland = 62,
    Paul = 92,
    Simu = 92,
    Renner = 59
)

# Converting to a numeric vector for calculations
scores <- unlist(student_scores)

highest <- max(scores)
lowest <- min(scores)
average <- mean(scores)

# Output
print(paste("Highest Score:", highest))
print(paste("Lowest Score:", lowest))
print(paste("Average Score:", average))
print(paste("Student with highest score:", names(scores[scores == max(scores)])))
print(paste("Student with lowest score:", names(scores[scores == min(scores)])))