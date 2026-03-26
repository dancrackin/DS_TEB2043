library(ggplot2)
library(readr)
library(tidyverse)
library(ggalluvial)

data <- read.csv("drug_deaths.csv")

colSums(is.na(data))

data_cleaned <- data %>%
    select(-X, -DateType) %>%
    mutate(Age = ifelse(is.na(Age), median(Age,na.rm = TRUE), Age)) %>%
    mutate(Age_Group = cut(Age, 
                           breaks = c(0, 24, 34, 44, 54, 64, 100), 
                           labels = c("Under 25", "25-34", "35-44", "45-54", "55-64", "65+")))

colSums(is.na(data_cleaned))

# Example: What percentage of each Race's overdoses involved Fentanyl?
race_fentanyl_table <- table(data_cleaned$Race, data_cleaned$Fentanyl)

# Margin = 1 calculates proportions across the rows (Race)
prop_table <- round((prop.table(race_fentanyl_table, margin = 1) * 100), 2)

# 1. Count the frequencies of each demographic combination
demo_counts <- data_cleaned %>%
    count(Race, Sex, Age_Group) %>%
    drop_na() # Removes any rows with missing demographic info

# 2. Plot the Alluvial Diagram
graph <- ggplot(demo_counts,
       aes(y = n, axis1 = Race, axis2 = Sex, axis3 = Age_Group)) +
    geom_alluvium(aes(fill = Sex), width = 1/12) + # Colors the ribbons by Sex
    geom_stratum(width = 1/12, fill = "grey80", color = "black") +
    geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 3) +
    scale_x_discrete(limits = c("Race", "Sex", "Age Group"), expand = c(.05, .05)) +
    theme_minimal() +
    labs(title = "Demographic Flow of Cases", y = "Total Number of Cases")

print(graph)