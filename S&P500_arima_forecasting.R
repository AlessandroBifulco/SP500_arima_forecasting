## Analysis and forecasting of S&P500 time series (data from 2010)

library(quantmod)
library(forecast)
library(tseries)

# -----------------------------------------
# 1. Load data and extract closing prices
# -----------------------------------------

getSymbols("^GSPC", src = "yahoo", from = "2010-01-01")

ClosePrices = GSPC$GSPC.Close
ts_data = ts(ClosePrices, start = c(2010, 1), frequency = 252)


windows()
plot(ts_data, main = "S&P 500 - Closing Prices", ylab = "Price", xlab = "Time")

# -----------------------------------------
# 2. Train/Test split and ARIMA forecasting
# -----------------------------------------

train_size = ceiling(0.8 * length(ts_data))
test_size  = length(ts_data) - train_size

train_set = head(ts_data, train_size)
test_set  = tail(ts_data, test_size)

# Fit ARIMA to training set
fit_train = auto.arima(train_set)

# Forecast on test horizon
fc_test = forecast(fit_train$fitted, h = test_size)

# Plot forecast vs actual values
windows()
plot(fc_test, main = "ARIMA Forecast vs Real Test Data")
lines(test_set, col = "blue", lwd = 2)
legend("topleft", legend = c("Forecast", "Actual"),
       col = c("black", "blue"), lty = 1, lwd = 2)

# -----------------------------------------
# 3. Combined visualization of real series,
#    forecast intervals and test values
# -----------------------------------------

ymax = max(ts_data, fc_test$upper)
ymin = min(ts_data, fc_test$lower)

windows()
par(mfrow = c(2,1))

plot(ts_data, ylim = c(ymin, ymax),
     main = "Full S&P500 Series", ylab = "Price", xlab = "Time")

plot(fc_test, ylim = c(ymin, ymax),
     main = "Forecast with Prediction Intervals", ylab = "Price", xlab = "Time")
lines(test_set, col = "blue")

# -----------------------------------------
# 4. Forecasting the next 100 future periods
# -----------------------------------------

future_horizon = 100
fc_future = forecast(auto.arima(ts_data)$fitted, h = future_horizon)

windows()
plot(fc_future, main = paste("Forecast for Next", future_horizon, "Periods"),
     ylab = "Price", xlab = "Time")
