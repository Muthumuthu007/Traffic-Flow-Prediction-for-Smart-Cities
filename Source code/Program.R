# Load necessary libraries
library(randomForest)
# Read the dataset
traffic_data <- read.csv("/Users/muthuk/Documents/STUDY FOLDER/R-Program/Traffic_data.csv")

# Convert DateTime column to proper datetime format
traffic_data$DateTime <- as.POSIXct(traffic_data$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Split the dataset into training and testing sets (in this case, we'll use all data for training)
train_data <- traffic_data

# Train the Random Forest model
model <- randomForest(Vehicles ~ ., data = train_data)

# Make predictions on the same data (not recommended for real scenarios, but for demonstration purposes)
predictions <- predict(model, train_data, type = "response")  # Specify type = "response"

# Print predictions
print("Predictions:")
print(predictions)

# Evaluate the  model (not recommended to evaluate on training data in real scenarios)
mae <- mean(abs(predictions - train_data$Vehicles))
rmse <- sqrt(mean((predictions - train_data$Vehicles)^2))
mape <- mean(abs((predictions - train_data$Vehicles)/train_data$Vehicles)) * 100

# Print evaluation metrics
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "%\n")
# Load necessary libraries
library(ggplot2)

# Create a data frame with actual and predicted values
prediction_df <- data.frame(Actual = train_data$Vehicles, Predicted = predictions)

# Create a scatter plot
ggplot(prediction_df, aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue") +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +  # Add a reference line
  labs(x = "Actual Traffic Volume", y = "Predicted Traffic Volume", title = "Actual vs. Predicted Traffic Volume")

