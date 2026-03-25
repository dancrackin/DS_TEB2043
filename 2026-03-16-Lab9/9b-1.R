library(ggcorrplot)

data("ToothGrowth")

tg_data <- ToothGrowth
tg_data$supp <- as.numeric(tg_data$supp)

# Compute the Correlation Matrix
cor_matrix <- cor(tg_data)
print("Correlation Matrix:")
print(round(cor_matrix, 2))

# Plot the Correlation Heatmap
map <- ggcorrplot(cor_matrix, 
           hc.order = TRUE,       # Orders variables by hierarchical clustering
           type = "lower",        # Only shows the bottom half (removes duplicates)
           lab = TRUE,            # Adds the exact correlation numbers on the heatmap
           title = "Correlation Heatmap of ToothGrowth Dataset",
           colors = c("red", "white", "blue"))

print(map)

cat(
    "Based on the Pearson correlation analysis and the resulting heatmap,\n",
    "we can draw insights regarding the factors that affect tooth length:\n\n",
    
    "--- The Dominant Impact of Dosage (Strong Positive Correlation) ---\n",
    "   There is a strong positive correlation (r ≈ 0.80) between the \n",
    "   dose and tooth length. The heatmap's dark block \n",
    "   confirms a direct relationship: as the dosage increases, the \n",
    "   tooth length reliably increases. Dosage is the primary driver.\n\n"
)