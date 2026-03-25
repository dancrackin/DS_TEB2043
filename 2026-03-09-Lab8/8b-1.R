library(readxl)
library(dplyr)
library(ggplot2)

titanic <- read.csv("titanic.csv", na.strings = c("", "NA", " "))

titanic_cleaned <- titanic %>%
    filter(!is.na(Embarked)) %>% # remove rows where value is na in column Embarked
    mutate(Age = ifelse(is.na(Age), median(Age,na.rm = TRUE), Age)) # fill na Age with median age value

print(colSums(is.na(titanic_cleaned)))

male <- titanic_cleaned %>%
    filter(Sex == "male")

total_row <- nrow(titanic_cleaned)
total_male <- nrow(male)

male_survived <- titanic_cleaned %>%
    filter(Sex == "male",Survived == "1")

male_survived_3rd_class <- male_survived %>%
    filter(Pclass == "3")

male_survived_percentage <- round(((nrow(male_survived) / total_male) * 100) ,2)

male_survived_3rd_class_percentage <- round(((nrow(male_survived_3rd_class) / nrow(male_survived)) * 100) ,2)

cat("\nOut of all male passengers, only",male_survived_percentage,"% and",male_survived_3rd_class_percentage,"% out of them are from the 3rd Class")


# PLOT 1: Bar Chart (Overall Male Survival)
male_died_count <- total_male - nrow(male_survived)
male_survived_count <- nrow(male_survived)

survival_counts <- c(male_died_count, male_survived_count)
names(survival_counts) <- c("Did Not Survive", "Survived")

barplot(
    survival_counts,
    main = "Survival Status of Male Passengers",
    sub = paste("Only", male_survived_percentage, "% of all males survived."),
    ylab = "Number of Passengers",
    col = c("#e74c3c", "#2ecc71"),
    ylim = c(0, max(survival_counts) + 50)
)

# PLOT 2: Pie Chart (Class of Male Survivors)
survivor_class_counts <- table(male_survived$Pclass)

class_percentages <- round(prop.table(survivor_class_counts) * 100, 1)
pie_labels <- paste("Class", names(survivor_class_counts), "-", class_percentages, "%")

pie(
    survivor_class_counts,
    labels = pie_labels,
    main = "Passenger Class of Male Survivors",
    col = c("lightblue", "skyblue", "dodgerblue")
)