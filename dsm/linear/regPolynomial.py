import numpy as np
from sklearn.preprocessing import PolynomialFeatures, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
import matplotlib.pyplot as plt

class PolynomialRegressionGD:
    def __init__(self, learning_rate=0.1, n_iterations=1000000, tolerance=1e-6):
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations
        self.weights = None
        self.loss = []
        self.tolerance = tolerance

    def fit(self, X, y):
        n_samples, n_features = X.shape
        self.weights = np.random.randn(n_features, 1) * 0.01

        for _ in range(self.n_iterations):
            y_predicted = np.dot(X, self.weights)
            gradients = X.T @ (y_predicted - y) / n_samples
            self.weights -= self.learning_rate * gradients

            mse_loss = np.mean((y - y_predicted) ** 2)
            self.loss.append(mse_loss)

            if len(self.loss) > 1 and np.abs(self.loss[-1] - self.loss[-2]) < self.tolerance:
                break

    def predict(self, X):
        return np.dot(X, self.weights)


X1 = np.array([1.5, 1.51, 1.7, 1.71, 1.72, 1.61, 1.6]).reshape(-1, 1)
y = np.array([12, 13, 20, 22, 21, 45, 49]).reshape(-1, 1)

poly = PolynomialFeatures(degree=2, include_bias=False)
X2 = poly.fit_transform(X1)

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X2)
X_scaled_with_bias = np.column_stack((X_scaled, np.ones((len(X1), 1))))

# joblib.dump(scaler, 'scaler.joblib')

# scaler = joblib.load('scaler.joblib')


X_train, X_test, y_train, y_test = train_test_split(X_scaled_with_bias, y, test_size=0.2, random_state=6)



model = PolynomialRegressionGD(learning_rate=0.25, n_iterations=100000)
# model.fit(X_scaled_with_bias, y)

# Aask why model is wrong(not enough data?)
model.fit(X_train, y_train)


y_pred = model.predict(X_test)


r2 = r2_score(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
mae = mean_absolute_error(y_test, y_pred)

# Coefficients
print("Weights (including bias):", model.weights.flatten())
print("R-squared (R^2):", r2)
print("Mean Squared Error (MSE):", mse)
print("Root Mean Squared Error (RMSE):", rmse)
print("Mean Absolute Error (MAE):", mae)


X_plot = np.linspace(min(X1), max(X1), 100).reshape(-1, 1)
X_plot_poly = poly.transform(X_plot)
X_plot_poly_scaled = scaler.transform(X_plot_poly)
X_plot_poly_scaled_with_bias = np.column_stack((X_plot_poly_scaled, np.ones((len(X_plot), 1))))

y_plot_gd_custom = model.predict(X_plot_poly_scaled_with_bias)


plt.figure(figsize=(12, 6))

plt.subplot(1, 2, 1)
plt.scatter(X1, y, color='blue', label='Data points')
plt.plot(X_plot, y_plot_gd_custom, color='green', label='Gradient Descent fit')
plt.xlabel('height')
plt.ylabel('age')
plt.title('Polynomial Regression with Gradient Descent')
plt.legend()


plt.subplot(1, 2, 2)
iterations = min(model.n_iterations, len(model.loss))
plt.plot(range(iterations), model.loss[:iterations])
plt.title("Loss Function")
plt.xlabel("Iterations")
plt.ylabel("Loss")
plt.tight_layout()
plt.show()
