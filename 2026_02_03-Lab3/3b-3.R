# Create the data frame
exam_score <- data.frame(
    Name = c("Robert", "Hemsworth", "Scarlett", "Evans", "Pratt", 
             "Larson", "Holland", "Paul", "Simu", "Renner"),
    Chemistry = c(59, 71, 83, 68, 65, 57, 62, 92, 92, 59),
    Physics = c(89, 86, 65, 52, 60, 67, 40, 77, 90, 61)
)

# Count failures (Score <= 49)
chem_fail_count <- sum(exam_score$Chemistry <= 49)
phys_fail_count <- sum(exam_score$Physics <= 49)

# Identify the highest scores
max_chem <- max(exam_score$Chemistry)
max_phys <- max(exam_score$Physics)

# Identify the students with the highest scores
top_chem_students <- exam_score$Name[exam_score$Chemistry == max_chem]
top_phys_students <- exam_score$Name[exam_score$Physics == max_phys]

# Output results
cat("--- Exam Failure Report ---\n")
print(paste("Students failed Chemistry:", chem_fail_count))
print(paste("Students failed Physics:", phys_fail_count))

cat("\n--- Top Performers ---\n")
cat("Highest Chemistry Score:", max_chem, "by", paste(top_chem_students, collapse = ", "), "\n")
cat("Highest Physics Score:", max_phys, "by", paste(top_phys_students, collapse = ", "), "\n")