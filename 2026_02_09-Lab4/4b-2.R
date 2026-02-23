V1 = c(2,3,1,5,4,6,8,7,9)

rownames = c("row1", "row2", "row3")
colnames = c("col1", "col2", "col3")

# Elements are arranged sequentially by row.
matrix1 <- matrix(V1, nrow = 3, byrow = TRUE)
dimnames(matrix1) <- list(rownames,colnames)
cat("\n","Matrix 1","\n")
print(matrix1)

# Elements are arranged sequentially by column.
matrix2 <- matrix(V1, nrow = 3, byrow = FALSE)
dimnames(matrix2) <- list(rownames,colnames)
cat("\n","Matrix 2","\n")
print(matrix2)

# Add the matrices.
result <- matrix1 + matrix2
cat("\n","Result of addition","\n")
print(result)

# Subtract the matrices
result <- matrix1 - matrix2
cat("\n","Result of subtraction","\n")
print(result)

# Multiply the matrices.
result <- matrix1 * matrix2
cat("\n","Result of multiplication","\n")
print(result)

# Divide the matrices
result <- matrix1 / matrix2
cat("\n","Result of division","\n")
print(result)
cat("\n")
