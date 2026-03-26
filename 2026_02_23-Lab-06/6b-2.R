table_df <- data.frame(
  name = c("Anastasia","Dima","Michael","Matthew","Laura","Kevin","Jonas"),
  score = c(12.5,9.0,16.5,12.0,9.0,8.0,19.0),
  attempts = c(1,3,2,3,2,1,2)
)

# add new column 'qualify'
table_df$qualify <- c(TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE)

print(table_df)