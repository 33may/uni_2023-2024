import numpy as np
import matplotlib.pyplot as plt


class LinearRegressionGD:
    def __init__(self, learning_rate=0.001, n_iterations=1000):
        self.weights = None
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations
        self.loss = []

    def fit(self, X, y):
        n_samples, n_features = X.shape
        self.weights = np.random.randn(n_features, 1) * 0.01

        for _ in range(self.n_iterations):
            y_predicted = np.dot(X, self.weights)
            loss = (1 / n_samples) * np.sum((y - y_predicted) ** 2)
            self.loss.append(loss)

            # Update coefficients
            gradients = -2 * np.dot(X.T, y - y_predicted) / n_samples
            self.weights -= self.learning_rate * gradients
           
    def predict(self, X):
        return np.dot(X, self.weights)


X1 = np.array([1, 2, 3, 4, 5, 6, 7])
X2 = np.array([6, 7, 8, 9, 10, 11, 12])
X3 = np.array([11, 12, 13, 14, 15, 16, 17])
X = np.column_stack((X1, X2, X3, np.ones((len(X1), 1))))
y = np.array([1, 4, 9, 16, 25, 36, 49])
y = y.reshape(-1, 1)


# Model training
model = LinearRegressionGD(learning_rate=0.001, n_iterations=1000)
model.fit(X, y)

# Predictions
y_pred = model.predict(X)

# Plotting
plt.figure(figsize=(12, 6))

# Since X is multi-dimensional, we can't plot it directly against y.
# Instead, we'll plot the predicted values against the actual values.
plt.subplot(1, 2, 1)
plt.scatter(y, y_pred, color='blue')  # Plotting the actual vs predicted values
plt.xlabel("Actual Values")
plt.ylabel("Predicted Values")
plt.title("Predictions vs Actual Values")

# Add a line of perfect predictions
max_value = max(y.max(), y_pred.max())  # Get the maximum value for the plot range
min_value = min(y.min(), y_pred.min())  # Get the minimum value for the plot range
plt.plot([min_value, max_value], [min_value, max_value], color='red', linestyle='--')

# Plotting the loss function
plt.subplot(1, 2, 2)
plt.plot(range(model.n_iterations), model.loss)
plt.title("Loss Function")
plt.xlabel("Iterations")
plt.ylabel("Loss")

plt.tight_layout()
plt.show()

# Coefficients
print("Weights (including bias):", model.weights.flatten())