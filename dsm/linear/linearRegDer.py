import numpy as np
import matplotlib.pyplot as plt


class LinearRegressionGD:
    def __init__(self, learning_rate=0.001, n_iterations=1000):
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations
        self.slope = 0
        self.intercept = 0
        self.loss = []

    def fit(self, x, y):
        n_samples = len(y)
        self.intercept = 0
        self.slope = 0

        # Gradient Descent
        for _ in range(self.n_iterations):
            y_predicted = self.intercept + self.slope * x
            loss = (1 / n_samples) * np.sum((y - y_predicted) ** 2)
            self.loss.append(loss)

            # Partial derivatives
            dJ_dm = -(2 / n_samples) * np.sum(x * (y - y_predicted))
            dJ_db = -(2 / n_samples) * np.sum(y - y_predicted)

            # Update coefficients
            self.slope -= self.learning_rate * dJ_dm
            self.intercept -= self.learning_rate * dJ_db

    def predict(self, x):
        return self.intercept + self.slope * x


x = np.array([1, 2, 3, 4, 5, 6, 7])
y = np.array([1, 4, 9, 16, 25, 36, 49])


# Model training
model = LinearRegressionGD(learning_rate=0.01, n_iterations=1000)
model.fit(x, y)

# Predictions
y_pred = model.predict(x)

# Plotting
plt.figure(figsize=(12, 6))

# Plotting the model
plt.subplot(1, 2, 1)
plt.scatter(x, y, color='blue')
plt.plot(x, y_pred, color='red')
plt.title("Linear Regression Model")
plt.xlabel("X")
plt.ylabel("y")

# Plotting the loss function
plt.subplot(1, 2, 2)
plt.plot(range(model.n_iterations), model.loss)
plt.title("Loss Function")
plt.xlabel("Iterations")
plt.ylabel("Loss")

plt.tight_layout()
plt.show()

# Coefficients
print("Intercept (Bias):", model.intercept)
print("Slope (Weight):", model.slope)