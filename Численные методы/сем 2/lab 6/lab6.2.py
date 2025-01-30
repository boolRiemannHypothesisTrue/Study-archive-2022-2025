import numpy as np

def implicit_euler_step(t, y, h, f, y_prev=None):
    if y_prev is None:
        y_prev = y
    # Метод Ньютона для решения неявного уравнения
    def newton_method(f, f_prime, initial_guess, max_iterations=100, tolerance=1e-6):
        x = initial_guess
        for i in range(max_iterations):
            fx = f(x)
            if abs(fx) < tolerance:
                return x
            fpx = f_prime(x)
            if fpx == 0:
                return None
            x -= fx / fpx
        return None

    # Уравнение для метода Ньютона
    equation = lambda y_next: y_next - y - h * f(t + h, y_next)
    # Производная уравнения
    derivative = lambda y_next: 1 - h * f(t + h, y_next)
    # Запускаем метод Ньютона
    return newton_method(equation, derivative, y_prev)

def f(t, y):
    return y * (-1 / (2 * t + 1))

def solve_with_accuracy(f, y0, t0, T, epsilon):
    h = 0.1  # начальный размер шага
    y_old = None

    while True:
        t_values = np.arange(t0, T + h, h)
        y_values = np.zeros(len(t_values))
        y_values[0] = y0

        for i in range(1, len(t_values)):
            y_values[i] = implicit_euler_step(t_values[i-1], y_values[i-1], h, f)

        if y_old is not None:
            if np.all(np.abs(y_values[::2] - y_old) < epsilon):
                return t_values, y_values
        y_old = y_values
        h /= 2

t0 = 0
T = 2
y0 = 1.414
epsilon = 1e-6

t_values, y_values = solve_with_accuracy(f, y0, t0, T, epsilon)
print("Количество шагов, требуемых для достижения точности:", len(t_values))
