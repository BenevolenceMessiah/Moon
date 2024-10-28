# API Reference

## Introduction

The API reference documentation provides detailed information about the public interfaces and functionalities available within the Moon programming language. This includes modules, functions, decorators, and other constructs that you can use to build applications and extend the language's capabilities.

## Modules

### Math Module

#### Functions
- **add(x: float, y: float) -> float**
  - Returns the sum of two floating-point numbers.
  
- **subtract(x: float, y: float) -> float**
  - Returns the difference between two floating-point numbers.
  
- **multiply(x: float, y: float) -> float**
  - Returns the product of two floating-point numbers.
  
- **divide(x: float, y: float) -> float**
  - Returns the quotient of two floating-point numbers. If `y` is zero, it prints an error message and returns 0.

### IO Module

#### Functions
- **read_file(file_path: str) -> str**
  - Reads the content of a file and returns it as a string.
  
- **write_file(file_path: str, content: str)**
  - Writes the given content to a file. Prints "File written successfully" upon completion.
  
- **print(message: str)**
  - Calls Python's built-in `print` function.

### AI Module

#### Functions
- **load_model(model_path: str)**
  - Loads an AI model from the specified path and returns it.
  
- **generate_text(model, prompt: str) -> str**
  - Generates text based on a given prompt using the provided model.
  
- **fine_tune(model, data)**
  - Placeholder for fine-tuning functionality.

## Decorators

### @synchronized

#### Description
A decorator used to synchronize critical sections of code. Ensures that only one thread can execute the decorated function at a time.

#### Usage Example
```moon
☪@synchronized
def critical_section():
    # Code that needs synchronization
    pass
```

### Functions

#### check_positive(number)

##### Description
Checks if a number is positive and prints an appropriate message.

##### Parameters
- number: A floating-point number to be checked.

##### Usage Example
```moon
def check_positive(number):
    if number > 0 ۩
        print("Number is positive") ۝
    else ۩
        print("Number is not positive") ۝
```

## Special Symbols

### ☪ (Star and Crescent)
Used as a decorator prefix in Moon.

### ۩ (Block Closure)
Used to denote block boundaries.

### ۝ (Statement Terminator)
Used to terminate statements.

### 🕌 (Module Declaration)
Used to declare modules.

#### Usage Example
```moon
🕌 math_module
```

Note: This documentation is generated from the Moon codebase. For more detailed information or specific implementations, refer to the source code.
