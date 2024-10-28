# Moon User Manual

## Introduction

Welcome to the Moon User Manual! This guide is designed to help you get started with the Moon programming language, from installation to writing your first program. Moon is a unique language that combines Python-like simplicity with high-performance capabilities, enriched with Islamic symbols and phrases.

## Installation

### Prerequisites

- **Python 3.8+**: Required for the Python prototype.
- **Rust 1.50+**: Necessary for the Rust-based implementation.
- **llama.cpp**: For AI model integration.
- **C++ Compiler**: To compile llama.cpp and other C++ dependencies.

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/moon.git
   cd moon
   ```

2. Set Up Python Prototype

```bash
cd src/python_prototype
pip install -r requirements.txt
```

3. Set Up Rust Environment
    - Ensure Rust is installed. If not, install it via rustup.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

4. Compile Tools
    - Navigate to the tools/ directory and compile the necessary tools.

```bash
cd ../../tools/ide
```

- Follow specific instructions for building the IDE. Detailed build instructions will be provided as development progresses.

## Usage

### Running the Example

Navigate to the Python prototype directory and execute the main.py script.

```bash
cd src/python_prototype
python main.py
```

Expected Output:

```bash
Peace be upon you
Assalamu Alaikum
Hello, World! @decorator
```

### Writing Your First Program

#### Hello World

- Create a file named: 
**hello_world.🌙**
 in the **examples/** directory.

```.🌙
# hello_world.🌙

﷽:  # Entry point (Alternative: def main():)
    print("ٱلسَّلَامُ عَلَيْكُمْ")  # Outputs "Peace be upon you"
    print("Hello, World! ☪")  # Decorator symbol

# Alternative entry point using English
def main():
    print("Assalamu Alaikum")
    print("Hello, World! @decorator")
```

#### Running the Hello World Example

- Navigate to the Python prototype directory and execute the **main.py** script.

```bash
cd src/python_prototype
python main.py
```

#### Islamic Calendar Example

- Create a file named:
**islamic_calendar.🌙**
 in the **examples/** directory.

```.🌙
# islamic_calendar.🌙

﷽:
    from datetime import date
    from ummalqura import HijriCalendar

    def display_islamic_date(gregorian_date):
        hijri_date = HijriCalendar.from_gregorian(gregorian_date.year, gregorian_date.month, gregorian_date.day)
        print("📅 Gregorian Date:", gregorian_date.strftime("%Y-%m-%d"))
        print("🕌 Islamic Date:", hijri_date.format("{dd} {MMMM} {yyyy} AH"))
        print("🕋 التاريخ الهجري:", hijri_date.format_ar("{dd_ar} {MMMM_ar} {yyyy_ar} هـ"))

    if __name__ == "__main__":
        today = date.today()
        display_islamic_date(today)
```

#### Running the Islamic Calendar Example

- Navigate to the Python prototype directory and execute the main.py script.

```bash
cd src/python_prototype
python main.py
```

## Standard Library

### Math Module

```moon
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
```

### IO Module

```moon
# io.moon

def read_file(file_path: str) -> str ۝
    with open(file_path, 'r') as file ۩
        content = file.read() ۝
    return content ۝

def write_file(file_path: str, content: str) ۝
    with open(file_path, 'w') as file ۩
        file.write(content) ۝
    print("File written successfully") ۝

def print(message: str) ۝
    # Interop call to Python's print function
    moon.interop.print(message) ۝
```

### AI Module

```moon
# ai.moon

import moon.interop

from moon.interop import llama_cpp_wrapper

def load_model(model_path: str):
    return llama_cpp_wrapper.load_model(model_path) ۝

def generate_text(model, prompt: str) -> str:
    return llama_cpp_wrapper.generate(model, prompt) ۝

def fine_tune(model, data):
    # Placeholder for fine-tuning functionality
    pass ۝
```

## Contributing

### How to Contribute

1. Fork the Repository
    - Click the "Fork" button at the top-right corner of the repository page to create your own fork.

2. Clone Your Fork

```bash
git clone https://github.com/BenevolenceMessiah/Moon.git
cd Moon
```

3. Create a New Branch

```bash
git checkout -b feature/your-feature-name
```

4. Make Your Changes
    - Implement your feature or fix in the appropriate directory.

5. Stage and Commit Your Changes

```bash
git add .
git commit -m "Add feature: your feature description"
```

6. Push Your Fork

```bash
git push origin feature/your-feature-name
```

7. Create a Pull Request
    - Navigate to the original repository and click "New Pull Request." Provide a clear description of your changes and submit.

## Guidelines

- **Code Quality**: Ensure your code adheres to the project's coding standards and is well-documented.
- **Testing**: Write unit tests for your contributions to maintain the project's reliability.
- **Documentation**: Update the documentation if your changes affect usage or add new features.
- **Respect and Inclusivity**: Maintain a respectful and inclusive environment. Discriminatory language or behavior will not be tolerated.

## Reporting Issues

If you encounter bugs or have feature requests, please open an issue in the Issues section of the repository. Provide as much detail as possible to help us address the problem effectively.

## Donations

Developing and maintaining Moon requires significant time and resources. If you find Moon valuable and wish to support its ongoing development, consider making a donation. Your generosity helps us improve the language, expand its capabilities, and foster a vibrant community.

