import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, accuracy_score, precision_score, recall_score, f1_score
import matplotlib.pyplot as plt


def sigmoid(x):
    return 1 / (1 + np.exp(-x))


class ClassificationGD:
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
            y_predicted = sigmoid(X @ self.weights)
            gradients = X.T @ (y_predicted - y) / n_samples
            self.weights -= self.learning_rate * gradients
            mse_loss = np.mean((y - y_predicted) ** 2)
            self.loss.append(mse_loss)

            if len(self.loss) > 1 and np.abs(self.loss[-1] - self.loss[-2]) < self.tolerance:
                break

    def predict(self, X):
        probabilities = sigmoid(X @ self.weights)
        return np.where(probabilities >= 0.5, 1, 0)


X1 = np.array([4, 7, 5, 8, 5, 6, 7, 6, 6, 7, 6, 6])
X2 = np.array([6, 2, 34, 33, 11, 12, 43, 4, 15, 29, 55, 47])
y = np.array([0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1]).reshape(-1, 1)

X = np.column_stack((X1, X2))

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
X_scaled_with_bias = np.column_stack((X_scaled, np.ones(len(X1))))

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_scaled_with_bias, y, test_size=0.2, random_state=6)

model = ClassificationGD(learning_rate=0.1, n_iterations=10000)

model.fit(X_train, y_train)

y_pred = model.predict(X_test)

conf_matrix = confusion_matrix(y_test, y_pred)

TP = conf_matrix[1, 1]
TN = conf_matrix[0, 0]
FP = conf_matrix[0, 1]
FN = conf_matrix[1, 0]

accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

print("Weights (including bias):", model.weights.flatten())
print("Confusion Matrix:\n", conf_matrix)
print("True Positives:", TP)
print("True Negatives:", TN)
print("False Positives:", FP)
print("False Negatives:", FN)
print("Accuracy:", accuracy)
print("Precision:", precision)
print("Recall:", recall)
print("F1 Score:", f1)

plt.figure(figsize=(12, 6))

X_test_unscaled = scaler.inverse_transform(X_test[:, :2])

X1_test_unscaled = X_test_unscaled[:, 0]
X2_test_unscaled = X_test_unscaled[:, 1]

X1_class_1_unscaled = X1_test_unscaled[y_pred.flatten() == 1]
X2_class_1_unscaled = X2_test_unscaled[y_pred.flatten() == 1]
X1_class_0_unscaled = X1_test_unscaled[y_pred.flatten() == 0]
X2_class_0_unscaled = X2_test_unscaled[y_pred.flatten() == 0]

plt.subplot(1, 2, 1)
plt.scatter(X1_class_1_unscaled, X2_class_1_unscaled, color='blue', label='Predicted Class 1')
plt.scatter(X1_class_0_unscaled, X2_class_0_unscaled, color='red', label='Predicted Class 0')
plt.xlabel('X1')
plt.ylabel('X2')
plt.title('Graph of Predicted Points')
plt.legend()

# Plotting the loss function
plt.subplot(1, 2, 2)
plt.plot(range(len(model.loss)), model.loss)
plt.title("Loss Function")
plt.xlabel("Iterations")
plt.ylabel("Loss")

plt.tight_layout()
plt.show()
