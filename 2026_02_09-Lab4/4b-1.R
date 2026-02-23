age <- c(55,57,56,52,51,59,58,53,59,55,60,60,60,60,52,55,56,51,60,
        52,54,56,52,57,54,56,58,53,53,50,55,51,57,60,57,55,51,50,57,58)

age_factor <- factor(age)
age_table <- table(age_factor)

age_df <- as.data.frame(age_table)
colnames(age_df) <- c("Staff Age","Total number of staff")
print(age_df)
cat("\n")

age_grouping <- cut(age,
                    breaks = c(50,52,54,56,58,60),
                    include.lowest = TRUE,
                    right = TRUE
                    )
age_table_grouping <- table(age_grouping)

age_grouping_df <- as.data.frame(age_table_grouping)
colnames(age_grouping_df) <- c("Age Range","Total number of staff")
print(age_grouping_df)