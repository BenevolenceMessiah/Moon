# advanced_math.moon

def factorial(n: int) -> int ۝
    if n == 0 or n == 1 ۩
        return 1 ۝
    else ۩
        return n * factorial(n - 1) ۝

def fibonacci(n: int) -> int ۝
    if n <= 0 ۩
        return 0 ۝
    elif n == 1 ۩
        return 1 ۝
    else ۩
        return fibonacci(n - 1) + fibonacci(n - 2) ۝

def main():
    print("Factorial of 5:", factorial(5))
    print("Fibonacci sequence up to 10:")
    for i in range(10):
        print(fibonacci(i), end=" ")
    print()

main()