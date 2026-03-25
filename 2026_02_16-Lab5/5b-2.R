# display the cube of the number up to a given integer

input <- readline(prompt = "Input an integer: ")

num <- as.numeric(input)

for (i in 1:num) {
    cat("Number is:",i,"and cube of the",i,"is :",i ^ 3,"\n")
}