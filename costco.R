library(readr)
Costco_Sales <- read_csv("Costco_Sales.csv")
View(Costco_Sales)

#Descriptive statistics

summary(Costco_Sales)

library(psych)
describe(Costco_Sales)


#bar plot for categorical variables

library(ggplot2)

# Bar plot for Date
ggplot(Costco_Sales) +
  geom_bar(aes(x = Date), fill = "skyblue", color = "black") +
  labs(title = "Date", x = "Date", y = "Frequency")


#histogram plots for all numeric variables
library(ggplot2)

# Exclude 'Date' variable from the dataset
Costco_Sales <- Costco_Sales[, !(names(Costco_Sales) %in% c("Date"))]

# Create a list of histograms for numeric variables
plots <- lapply(names(Costco_Sales), function(var) {
  ggplot(Costco_Sales, aes_string(var)) +
    geom_histogram(bins = 30, fill = "steelblue", color = "black") +
    theme_minimal() +
    labs(title = paste("Histogram of", var), x = var, y = "Frequency")
})

# Print the plots
plots


#Correlation heatmap

library(corrplot)

# Calculate correlation matrix
cor_matrix <- cor(Costco_Sales, use = "pairwise.complete.obs")

# Plot correlation matrix
corrplot(cor_matrix, method = "circle", type = "upper", tl.col = "black", tl.srt = 45)


#Timeseries plot for each sales

# Load required packages
library(ts)
library(forecast)

# Convert data to time series
ts_data <- ts(Costco_Sales$Weekly_Sales, frequency = 52, start = c(2010, 1))

# Decompose the time series into trend, seasonality, and remainder
decomp <- decompose(ts_data)

# Plot the decomposed time series
plot(decomp)


# Fit an ARIMA model
model <- arima(ts_data, order = c(1, 1, 1))

# Make predictions using the ARIMA model
predictions <- predict(model, n.ahead = 52)

# Plot the predicted values
plot(ts_data)
lines(predictions$pred, col = "red")

# Perform ANOVA
model_aov <- aov(Weekly_Sales ~ Store + Holiday_Flag + Temperature + Fuel_Price + CPI + Unemployment, data = Walmart_Store_sales)

# Summarize ANOVA results
summary(model_aov)

library(ggplot2)

# Create a data frame with group means
means <- aggregate(Weekly_Sales ~ Store + Holiday_Flag + Temperature + Fuel_Price + CPI + Unemployment, data = Walmart_Store_sales, FUN = mean)

# Plot bar plot of group means
ggplot(means, aes(x = Store, y = Weekly_Sales)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Group Means of Weekly Sales by Store", x = "Store", y = "Weekly Sales")
