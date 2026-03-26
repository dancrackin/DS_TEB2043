array1 <- array(1:24, dim = c(2,4,3))
array2 <- array(25:54, dim = c(3,2,5))

var1 <- array1[2,,2]
var2 <- array2[3,2,1]

cat("Array1","\n")
print(array1)
cat("Array2","\n")
print(array2)

cat("\n","The second row of the second matrix of the array:","\n")
print(var1)
cat("\n","The element in the 3rd row and 3rd column of the 1st matrix:","\n")
print(var2)