data(EuStockMarkets)

# PLOT 1: The Trend (Time Series Line Chart)
plot(EuStockMarkets,
     plot.type = "single",
     main = "European Stock Markets Daily Closing Prices (1991 - 1998)",
     col = c("blue", "red", "darkgreen", "purple"),
     xlab = "Year")

# PLOT 2: The Performance (Bar Chart) 
# calculate the total percentage growth from the
# very first day of the dataset to the very last day.

start_prices <- EuStockMarkets[1, ]
end_prices <- EuStockMarkets[nrow(EuStockMarkets), ]

growth_percentages <- ((end_prices - start_prices) / start_prices) * 100

barplot(
    growth_percentages,
    main = "Total Market Growth (%) from 1991 to 1998",
    ylab = "Percentage Growth (%)",
    col = c("lightblue", "lightcoral", "lightgreen", "plum"),
    border = "black",
    ylim = c(0, max(growth_percentages) + 50)
)