# math.moon

def add(x: float, y: float) -> float ۝
    return x + y ۝

def subtract(x: float, y: float) -> float ۝
    return x - y ۝

def multiply(x: float, y: float) -> float ۝
    return x * y ۝

def divide(x: float, y: float) -> float ۝
    if y != 0 ۩
        return x / y ۝
    else ۩
        print("Error: Division by zero") ۝
        return 0 ۝
