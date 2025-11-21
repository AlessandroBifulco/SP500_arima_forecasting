# S&P 500 ARIMA Forecasting in R

This project performs time-series analysis and forecasting on the S&P 500 index using ARIMA models in R. The workflow includes data collection, preprocessing, model selection, training/test evaluation, prediction interval assessment, and future forecasting.

---

## Objectives

- Retrieve historical S&P 500 prices from 2010 onward.
- Convert data into a time series format with trading-frequency indexing.
- Automatically identify the best ARIMA model via `auto.arima()`.
- Validate the forecasting model using a train/test split.
- Compare predicted values with actual historical data.
- Visualize confidence intervals and evaluate prediction performance.
- Produce a 100-period ahead forecast on the full dataset.

---

## Packages Used and Why

### **quantmod**
Used to download financial market data directly from Yahoo Finance.  
Provides convenient tools for handling OHLCV data and is standard in quant finance workflows.

### **forecast**
Provides the `auto.arima()` function, forecast objects, and plotting utilities.  
Essential for ARIMA modelling, prediction intervals, and visualizing forecasts.

### **tseries**
Included for statistical tests and additional time-series functions often required in ARIMA workflows.  
Commonly used together with `forecast` for robust modelling.

---

## Methodology

### **1. Data Loading**
Historical daily closing prices of the S&P 500 are downloaded, starting from 2010.  
The data is converted into a time series with 252 observations per year (trading days).

### **2. Model Training and Validation**
A standard **80/20 train/test split** is used:
- The ARIMA model is trained on the training set.
- Forecasts are generated for the test horizon.
- Predictions are compared to actual values through overlapping plots.

### **3. Performance Assessment**
The predicted values and the real market prices are visually compared.  
Prediction intervals (confidence bands) help assess the model’s reliability.

### **4. Future Forecasting**
After validation, a new ARIMA model is fitted to the full dataset.  
A **100-period future forecast** is generated and plotted, including confidence intervals.

---

## Model Limitations and Observations

During the evaluation, it is noticeable that **actual test-set prices do not always fall within the predicted confidence intervals**.  
This is expected and highlights a key limitation of ARIMA models:

> **ARIMA assumes stable, linear, and mean-reverting dynamics, and performs well only when the time series exhibits predictable patterns without sudden shocks.**

Financial markets, however, may experience:
- abrupt jumps,  
- volatility spikes,  
- macroeconomic or geopolitical shocks,  
- regime changes.

These events violate the assumptions behind ARIMA and cause deviations between predicted intervals and actual values.

Thus, ARIMA offers a **useful baseline model**, but it is not fully equipped for capturing highly volatile, non-linear, or regime-switching behaviors typical of real financial data.

---

## Future Improvements

Potential enhancements include:
- Incorporating GARCH models for volatility modelling.  
- Using machine learning regressors (LSTM, XGBoost).  
- Applying regime-switching or state-space models.  
- Comparing ARIMA to exponential smoothing or Prophet.

---

## Requirements

```r
install.packages(c("quantmod", "forecast", "tseries"))

---

## Author
Alessandro Bifulco

