# check Armstrong number of n digits

cat("Check whether an n digits number is Armstrong or not:
-----------------------------------------------------------")
input <- readline(prompt = "Input an integer: ")

digits <- as.numeric(strsplit(input, split = "")[[1]])

power_value <- length(digits)

calculated_value <- sum(digits ^ power_value)

if(as.numeric(input) == calculated_value){
    cat(input,"is an Armstrong number.")
} else {
    cat(input,"is not an Armstrong number.")
}