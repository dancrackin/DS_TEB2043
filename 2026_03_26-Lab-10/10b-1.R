# linear model and visualize the linear regression

data(Theoph)

x = Theoph$Wt
y = Theoph$Dose

relation <- lm(y~x)

# print summary to check for important values
print(relation)
print(summary(relation))

# based on the summary, the important numbers to look at is:
# 1. P-Value
#    When P-Value less than 0.05, it shows that this variables have actual
#    relationship and not just random coincidence.

# 2. Estimated
#    We look at the estimated to check how the variables interact
#    Positive estimate means that as your input increases, your outcome goes up with it 
#    while a negative estimate tells you that the outcome will go down.

# 3. R-Squared/Adjusted R-Squared
#    This one act as a final grade representing the exact percentage of your data the model successfully explains.

# visualize
print(plot(y, x, 
           main = "conc ~ Time",
           xlab = "Time",
           ylab = "Concentration"))

abline(relation)

print(scatter.smooth(y,x, 
                     main="conc ~ Time",
                     xlab = "Time",
                     ylab = "Concentration"))

# predict dose when weight (kg) = 90,95,100
model1 <- lm(y~x)
newspeed <- data.frame(x=c(90, 95, 100))
result <- predict(model1,newspeed)
print(result)
