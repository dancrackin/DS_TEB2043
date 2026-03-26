library(readxl)
library(dplyr)

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

cat("Out of all male passengers, only",male_survived_percentage,"% and",male_survived_3rd_class_percentage,"% out of them are from the 3rd Class")