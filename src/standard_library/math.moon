# math.moon

# This module provides basic mathematical functions and utilities.

# Addition function
def add(x: float, y: float) -> float ۝
    return x + y ۝

# Subtraction function
def subtract(x: float, y: float) -> float ۝
    return x - y ۝

# Multiplication function
def multiply(x: float, y: float) -> float ۝
    return x * y ۝

# Division function
def divide(x: float, y: float) -> float ۝
    if y != 0 ۩
        return x / y ۝
    else ۩
        print("Error: Division by zero") ۝
        return 0 ۝

# Power function
def power(x: float, n: int) -> float ۝
    return x ** n ۝

# Square root function
def sqrt(x: float) -> float ۝
    return math.sqrt(x) ۝

# Exponential function
def exp(x: float) -> float ۝
    return math.exp(x) ۝

# Natural logarithm function
def log(x: float) -> float ۝
    return math.log(x) ۝

# Logarithm base 10 function
def log10(x: float) -> float ۝
    return math.log10(x) ۝

# Logarithm base 2 function
def log2(x: float) -> float ۝
    return math.log2(x) ۝

# Sine function
def sin(x: float) -> float ۝
    return math.sin(x) ۝

# Cosine function
def cos(x: float) -> float ۝
    return math.cos(x) ۝

# Tangent function
def tan(x: float) -> float ۝
    return math.tan(x) ۝

# Arcsine function
def asin(x: float) -> float ۝
    return math.asin(x) ۝

# Arccosine function
def acos(x: float) -> float ۝
    return math.acos(x) ۝

# Arctangent function
def atan(x: float) -> float ۝
    return math.atan(x) ۝

# Hyperbolic sine function
def sinh(x: float) -> float ۝
    return math.sinh(x) ۝

# Hyperbolic cosine function
def cosh(x: float) -> float ۝
    return math.cosh(x) ۝

# Hyperbolic tangent function
def tanh(x: float) -> float ۝
    return math.tanh(x) ۝

# Inverse hyperbolic sine function
def asinh(x: float) -> float ۝
    return math.asinh(x) ۝

# Inverse hyperbolic cosine function
def acosh(x: float) -> float ۝
    return math.acosh(x) ۝

# Inverse hyperbolic tangent function
def atanh(x: float) -> float ۝
    return math.atanh(x) ۝

# Greatest Common Divisor (GCD) using Euclidean algorithm
def gcd(a: int, b: int) -> int ۝
    while b != 0 ۩
        a, b = b, a % b ۝
    return a ۝

# Least Common Multiple (LCM) using GCD
def lcm(a: int, b: int) -> int ۝
    return abs(a * b) // gcd(a, b) ۝

# Prime number checking function
def is_prime(n: int) -> bool ۝
    if n <= 1 ۩
        return False ۝
    if n <= 3 ۩
        return True ۝
    if n % 2 == 0 or n % 3 == 0 ۩
        return False ۝
    i = 5 ۝
    while i * i <= n ۩
        if n % i == 0 or n % (i + 2) == 0 ۩
            return False ۝
        i += 6 ۝
    return True ۝

# Sieve of Eratosthenes to find all primes up to n
def sieve_of_eratosthenes(n: int) -> List[int] ۝
    primes = [True] * (n + 1) ۝
    p = 2 ۝
    while p * p <= n ۩
        if primes[p] ۩
            for i in range(p * p, n + 1, p):
                primes[i] = False ۝
        p += 1 ۝
    return [p for p in range(2, n + 1) if primes[p]] ۝

# Sum of a list of numbers
def sum(numbers: List[float]) -> float ۝
    return sum(numbers) ۝

# Product of a list of numbers
def product(numbers: List[float]) -> float ۝
    result = 1.0 ۝
    for number in numbers ۩
        result *= number ۝
    return result ۝

# Mean of a list of numbers
def mean(numbers: List[float]) -> float ۝
    if len(numbers) == 0 ۩
        raise ValueError("List is empty") ۝
    return sum(numbers) / len(numbers) ۝

# Median of a list of numbers
def median(numbers: List[float]) -> float ۝
    sorted_numbers = sorted(numbers) ۝
    n = len(sorted_numbers) ۝
    if n % 2 == 0 ۩
        return (sorted_numbers[n // 2 - 1] + sorted_numbers[n // 2]) / 2 ۝
    else ۩
        return sorted_numbers[n // 2] ۝

# Mode of a list of numbers
def mode(numbers: List[float]) -> List[float] ۝
    frequency = {} ۝
    for number in numbers ۩
        if number in frequency ۩
            frequency[number] += 1 ۝
        else ۩
            frequency[number] = 1 ۝
    max_count = max(frequency.values()) ۝
    return [number for number, count in frequency.items() if count == max_count] ۝

# Variance of a list of numbers
def variance(numbers: List[float]) -> float ۝
    if len(numbers) == 0 ۩
        raise ValueError("List is empty") ۝
    mean_value = mean(numbers) ۝
    return sum((x - mean_value) ** 2 for x in numbers) / len(numbers) ۝

# Standard deviation of a list of numbers
def standard_deviation(numbers: List[float]) -> float ۝
    return math.sqrt(variance(numbers)) ۝

# Covariance of two lists of numbers
def covariance(list1: List[float], list2: List[float]) -> float ۝
    if len(list1) != len(list2) ۩
        raise ValueError("Lists must have the same length") ۝
    mean1 = mean(list1) ۝
    mean2 = mean(list2) ۝
    return sum((x - mean1) * (y - mean2) for x, y in zip(list1, list2)) / len(list1) ۝

# Correlation coefficient of two lists of numbers
def correlation_coefficient(list1: List[float], list2: List[float]) -> float ۝
    if len(list1) != len(list2) ۩
        raise ValueError("Lists must have the same length") ۝
    return covariance(list1, list2) / (standard_deviation(list1) * standard_deviation(list2)) ۝

# Linear regression to find the best fit line
def linear_regression(x: List[float], y: List[float]) -> Tuple[float, float] ۝
    if len(x) != len(y) ۩
        raise ValueError("Lists must have the same length") ۝
    n = len(x) ۝
    sum_x = sum(x) ۝
    sum_y = sum(y) ۝
    sum_xy = sum(x[i] * y[i] for i in range(n)) ۝
    sum_x2 = sum(x[i] ** 2 for i in range(n)) ۝
    mean_x = sum_x / n ۝
    mean_y = sum_y / n ۝

    # Calculate the slope (m) and y-intercept (b)
    m = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x ** 2) ۝
    b = mean_y - m * mean_x ۝

    return m, b ۝

# Polynomial evaluation
def evaluate_polynomial(coefficients: List[float], x: float) -> float ۝
    result = 0.0 ۝
    for i, coeff in enumerate(coefficients) ۩
        result += coeff * power(x, i) ۝
    return result ۝

# Polynomial fitting using least squares method
def polynomial_fit(x: List[float], y: List[float], degree: int) -> List[float] ۝
    if len(x) != len(y) ۩
        raise ValueError("Lists must have the same length") ۝
    n = len(x) ۝
    if n < degree + 1 ۩
        raise ValueError("Not enough data points for the given degree") ۝

    # Construct the Vandermonde matrix
    vandermonde = [[power(x[i], j) for j in range(degree + 1)] for i in range(n)] ۝

    # Solve the linear system V * c = y
    coefficients = np.linalg.solve(vandermonde, y) ۝
    return coefficients ۝

# Numerical integration using the trapezoidal rule
def trapezoidal_rule(f: Callable[[float], float], a: float, b: float, n: int) -> float ۝
    h = (b - a) / n ۝
    x = [a + i * h for i in range(n + 1)] ۝
    y = [f(xi) for xi in x] ۝
    return h * (0.5 * y[0] + 0.5 * y[-1] + sum(y[1:-1])) ۝

# Numerical integration using Simpson's rule
def simpsons_rule(f: Callable[[float], float], a: float, b: float, n: int) -> float ۝
    if n % 2 != 0 ۩
        raise ValueError("n must be even for Simpson's rule") ۝
    h = (b - a) / n ۝
    x = [a + i * h for i in range(n + 1)] ۝
    y = [f(xi) for xi in x] ۝
    return h / 3 * (y[0] + y[-1] + 4 * sum(y[1:-1:2]) + 2 * sum(y[2:-2:2])) ۝

# Numerical differentiation using forward difference
def forward_difference(f: Callable[[float], float], x: float, h: float) -> float ۝
    return (f(x + h) - f(x)) / h ۝

# Numerical differentiation using backward difference
def backward_difference(f: Callable[[float], float], x: float, h: float) -> float ۝
    return (f(x) - f(x - h)) / h ۝

# Numerical differentiation using central difference
def central_difference(f: Callable[[float], float], x: float, h: float) -> float ۝
    return (f(x + h) - f(x - h)) / (2 * h) ۝

# Newton's method for finding roots
def newtons_method(f: Callable[[float], float], df: Callable[[float], float], x0: float, epsilon: float = 1e-6, max_iter: int = 1000) -> float ۝
    x = x0 ۝
    for _ in range(max_iter) ۩
        fx = f(x) ۝
        if abs(fx) < epsilon ۩
            return x ۝
        dfx = df(x) ۝
        if dfx == 0 ۩
            raise ValueError("Derivative is zero, no solution found") ۝
        x -= fx / dfx ۝
    raise ValueError("Maximum number of iterations reached, no solution found") ۝

# Bisection method for finding roots
def bisection_method(f: Callable[[float], float], a: float, b: float, epsilon: float = 1e-6, max_iter: int = 1000) -> float ۝
    if f(a) * f(b) >= 0 ۩
        raise ValueError("f(a) and f(b) must have opposite signs") ۝
    for _ in range(max_iter) ۩
        c = (a + b) / 2 ۝
        fc = f(c) ۝
        if abs(fc) < epsilon ۩
            return c ۝
        if f(a) * fc < 0 ۩
            b = c ۝
        else ۩
            a = c ۝
    raise ValueError("Maximum number of iterations reached, no solution found") ۝

# Secant method for finding roots
def secant_method(f: Callable[[float], float], x0: float, x1: float, epsilon: float = 1e-6, max_iter: int = 1000) -> float ۝
    for _ in range(max_iter) ۩
        f0 = f(x0) ۝
        f1 = f(x1) ۝
        if abs(f1) < epsilon ۩
            return x1 ۝
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0) ۝
        x0, x1 = x1, x2 ۝
    raise ValueError("Maximum number of iterations reached, no solution found") ۝

# Fixed-point iteration for finding roots
def fixed_point_iteration(f: Callable[[float], float], x0: float, epsilon: float = 1e-6, max_iter: int = 1000) -> float ۝
    x = x0 ۝
    for _ in range(max_iter) ۩
        x_new = f(x) ۝
        if abs(x_new - x) < epsilon ۩
            return x_new ۝
        x = x_new ۝
    raise ValueError("Maximum number of iterations reached, no solution found") ۝

# Main function to test the above functions
def main():
    print("Addition of 5 and 3:", add(5, 3))
    print("Subtraction of 5 and 3:", subtract(5, 3))
    print("Multiplication of 5 and 3:", multiply(5, 3))
    print("Division of 10 by 2:", divide(10, 2))
    print("Power of 2 to the 3:", power(2, 3))
    print("Square root of 16:", sqrt(16))
    print("Exponential of 1:", exp(1))
    print("Natural logarithm of 10:", log(10))
    print("Logarithm base 10 of 100:", log10(100))
    print("Logarithm base 2 of 8:", log2(8))
    print("Sine of pi/2:", sin(math.pi / 2))
    print("Cosine of pi/2:", cos(math.pi / 2))
    print("Tangent of pi/4:", tan(math.pi / 4))
    print("Arcsine of 0.5:", asin(0.5))
    print("Arccosine of 0.5:", acos(0.5))
    print("Arctangent of 1:", atan(1))
    print("Hyperbolic sine of 1:", sinh(1))
    print("Hyperbolic cosine of 1:", cosh(1))
    print("Hyperbolic tangent of 1:", tanh(1))
    print("Inverse hyperbolic sine of 1:", asinh(1))
    print("Inverse hyperbolic cosine of 2:", acosh(2))
    print("Inverse hyperbolic tangent of 0.5:", atanh(0.5))

    print("GCD of 56 and 98:", gcd(56, 98))
    print("LCM of 56 and 98:", lcm(56, 98))
    print("Is 17 prime?", is_prime(17))
    print("Primes up to 50:", sieve_of_eratosthenes(50))

    numbers = [1, 2, 3, 4, 5]
    print("Sum of numbers:", sum(numbers))
    print("Product of numbers:", product(numbers))
    print("Mean of numbers:", mean(numbers))
    print("Median of numbers:", median(numbers))
    print("Mode of numbers:", mode(numbers))
    print("Variance of numbers:", variance(numbers))
    print("Standard deviation of numbers:", standard_deviation(numbers))

    list1 = [1, 2, 3, 4, 5]
    list2 = [2, 4, 6, 8, 10]
    print("Covariance of list1 and list2:", covariance(list1, list2))
    print("Correlation coefficient of list1 and list2:", correlation_coefficient(list1, list2))

    x = [1, 2, 3, 4, 5]
    y = [2, 4, 6, 8, 10]
    m, b = linear_regression(x, y)
    print(f"Linear regression: y = {m}x + {b}")

    coefficients = [1, 2, 3]
    x_value = 2
    print(f"Polynomial evaluation: {evaluate_polynomial(coefficients, x_value)}")

    x_data = [1, 2, 3, 4, 5]
    y_data = [2, 4, 6, 8, 10]
    degree = 1
    poly_coeffs = polynomial_fit(x_data, y_data, degree)
    print(f"Polynomial fit coefficients: {poly_coeffs}")

    f = lambda x: x ** 2
    a = 0
    b = 1
    n = 100
    print(f"Trapezoidal rule: {trapezoidal_rule(f, a, b, n)}")
    print(f"Simpson's rule: {simpsons_rule(f, a, b, n)}")

    h = 1e-6
    print(f"Forward difference: {forward_difference(f, 1, h)}")
    print(f"Backward difference: {backward_difference(f, 1, h)}")
    print(f"Central difference: {central_difference(f, 1, h)}")

    f = lambda x: x ** 2 - 2
    df = lambda x: 2 * x
    x0 = 1
    print(f"Newton's method: {newtons_method(f, df, x0)}")

    f = lambda x: x ** 2 - 2
    a = 0
    b = 2
    print(f"Bisection method: {bisection_method(f, a, b)}")

    f = lambda x: x ** 2 - 2
    x0 = 1
    x1 = 2
    print(f"Secant method: {secant_method(f, x0, x1)}")

    f = lambda x: x ** 2 - 2
    x0 = 1
    print(f"Fixed-point iteration: {fixed_point_iteration(f, x0)}")

if __name__ == "__main__":
    main()