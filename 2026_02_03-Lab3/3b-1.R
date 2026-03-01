exam_score <- c(33, 24, 54, 94, 16, 89, 60, 6, 77, 61, 13, 44, 26, 24, 73, 73, 90, 39, 90, 54)

# Assign grade
student_grade <- cut(
    exam_score,
    breaks = c(0,49,59,69,79,89,100),
    labels = c("F","E","D","C","B","A"),
    right = TRUE
)

# Count number of students per grade
grade_count <- table(student_grade)

pass_exam <- exam_score > 49

cat("\nNumber of students per grade:\n",grade_count)

cat("\n\nPass or fail for each student (TRUE = pass, FALSE = fail):\n",pass_exam)