table_df <- data.frame(
  name = c("Anastasia","Dima","Michael","Matthew","Laura","Kevin","Jonas"),
  score = c(12.5,9.0,16.5,12.0,9.0,8.0,19.0),
  attempts = c(1,3,2,3,2,1,2)
)

# add new column 'qualify'
table_df$qualify <- c(TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE)

# add new row, create another data frame
new_data <- data.frame(
  name = "Emily",
  score = 14.5,
  attempts = 1,
  qualify = TRUE
)

# combine the data frame
updated_table_df <- rbind(table_df,new_data)

cat("\n")
print(updated_table_df)
cat("\n")
str(updated_table_df)
cat("\n")
print(summary(updated_table_df))
cat("\n")
cat("The data frame dimension:",dim(updated_table_df))
cat("\nNumber of column:",ncol(updated_table_df))
cat("\nNumber of row:",nrow(updated_table_df))

# insights
cat("\n\nFrom the data frame, students with 12.5 or more score will qualify.
higher scores are more strongly translated to qualification
instead of higher number of attempts.")