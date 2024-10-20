def print(*args):
    # Simple print function for Moon's standard library
    print(' '.join(map(str, args)))

def input(prompt=""):
    # Simple input function for Moon's standard library
    return input(prompt)

# Math Module
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        raise ValueError("Division by zero is undefined")
    return a / b
