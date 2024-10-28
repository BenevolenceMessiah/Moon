# Moon Language Specification

## Overview

Moon is a programming language designed to bridge simplicity and performance, inspired by Python's readability and Mojo's high-performance capabilities. It introduces a unique cultural aesthetic rooted in Islamic symbolism, making it a distinctive and culturally enriching language.

## Syntax

### Entry Point

```moon
﷽:  # Entry point (Alternative: def main():)
    print("ٱلسَّلَامُ عَلَيْكُمْ")  # Outputs "Peace be upon you"
    print("Hello, World! ☪")  # Decorator symbol
```

## Control Structures

### If-Else

```moon
def check_positive(number):
    if number > 0 ۩  # Block closure with ۩
        print("Number is positive") ۝  # Statement terminator with ۝
    else ۩
        print("Number is not positive") ۝
```

## For Loop

```moon
# Loop using 📿 (Prayer Beads)
def iterate_list(items):
    📿 item in items ۩
        print(item) ۝
```

## Functions

```moon
def add(x: float, y: float) -> float ۝
    return x + y ۝
```

## Decorators

```moon
☪@synchronized  # Decorator using ☪
def critical_section():
    # Code that needs synchronization
    pass
```

## Modules

```moon
🕌 math_module  # Module declaration using 🕌

from 🕋 import tensor  # Importing from core library using 🕋

def calculate():
    tensor_a = tensor([1, 2, 3])
    tensor_b = tensor([4, 5, 6])
    result = tensor_a + tensor_b
    print("Result:", result) ۝

main()  # Using English alternative entry point
```

## Special Symbols

| Symbol | Unicode | Meaning | Usage in Moon | English Alternative | |--------|---------|---------|---------------|---------------------| | 🕋 | U+1F54C | Mosque | Module declaration (module) | module | | 🕋 | U+1F54B | Kaaba | Core library import (import core) | import core | | 📿 | U+1F4FF | Prayer Beads | Loop iterator (for) | for loop | | 🌙 | U+1F319 | Crescent Moon | Import Moon libraries (import_moon or moon) | import moon | | ۝ | U+06DD | End of Ayah | Statement terminator (;) | ; or newline | | ۩ | U+06E9 | Place of Sajdah | Block closure (end) | end | | ☪ | U+262A | Star and Crescent | Decorator symbol (@decorator) | @decorator | | ☭ | U+262D | Hammer and Sickle | Synchronization primitive (synchronize) | synchronize | | لَا إِلَٰهَ إِلَّا ٱللَّٰهُ | - | "There is no god but Allah" | Boolean true | true | | ♡ | U+2661 | White Heart | Equality operator (==) or like | == or like |

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

## Examples

### Hello World

```moon
# hello_world.🌙

﷽:  # Entry point (Alternative: def main():)
    print("ٱلسَّلَامُ عَلَيْكُمْ")  # Outputs "Peace be upon you"
    print("Hello, World! ☪")  # Decorator symbol

# Alternative entry point using English
def main():
    print("Assalamu Alaikum")
    print("Hello, World! @decorator")
```

### Islamic Calendar

```moon
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

### AI Example

```moon
# ai_example.🌙

﷽:
    from ai import load_model, generate

    # Load the GGUF model
    model = load_model("models/gguf_model.gguf") ۝

    # Generate text using the model
    prompt = "In the beginning, Allah created the heavens and the earth." ۝
    response = generate(model, prompt) ۝

    # Print the generated text
    print(response) ۝
```

## Installation

### Prerequisites

- Python 3.8+: Required for the Python prototype.
- Rust 1.50+: Necessary for the Rust-based implementation.
- llama.cpp: For AI model integration.
- C++ Compiler: To compile llama.cpp and other C++ dependencies.

### Steps

1. Clone the Repository

```bash
git clone https://github.com/BenevolenceMessiah/Moon.git
cd Moon
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

5. Follow specific instructions for building the IDE.
    - Note: Detailed build instructions will be provided as development progresses.

## Usage

### Running the Example

- Navigate to the Python prototype directory and execute the main.py script.

```bash
cd src/python_prototype
python main.py
```

- Expected Output

```bash
Peace be upon you
Assalamu Alaikum
Hello, World! @decorator
```

### Contributing

#### How to Contribute

1. Fork the Repository
    - Click the "Fork" button at the top-right corner of the repository page to create your own fork.

2. Clone Your Fork

```bash
git clone https://github.com/yourusername/moon.git
cd moon
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

6. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

7. Create a Pull request
    - Navigate to the original repository and click "New Pull Request." Provide a clear description of your changes and submit.

### Guidelines

- **Code Quality**: Ensure your code adheres to the project's coding standards and is well-documented.
- **Testing**: Write unit tests for your contributions to maintain the project's reliability.
- **Documentation**: Update the documentation if your changes affect usage or add new features.
- **Respect and Inclusivity**: Maintain a respectful and inclusive environment. Discriminatory language or behavior will not be tolerated.

### Reporting Issues

If you encounter bugs or have feature requests, please open an issue in the Issues section of the repository. Provide as much detail as possible to help us address the problem effectively.

### Donations

Developing and maintaining Moon requires significant time and resources. If you find Moon valuable and wish to support its ongoing development, consider making a donation. Your generosity helps us improve the language, expand its capabilities, and foster a vibrant community.

#### How to Donate

- **GitHub Sponsors**: Sponsor Moon
- **Patreon**: Support us on Patreon
- **PayPal**: Donate via PayPal
- **Bitcoin**: Send to 1BoatSLRHtKNngkdXEeobR76b53LETtpyT
- **Ethereum**: Send to 0x1BoatSLRHtKNngkdXEeobR76b53LETtpyT

All donations are greatly appreciated and will be used to fund development, tooling, and community initiatives.

### License

Moon is released under the MIT License. You are free to use, modify, and distribute Moon as per the terms of the license.

### Getting Involved

Join the Moon community and be a part of shaping the future of this unique programming language!

- **GitHub**: https://github.com/yourusername/moon
- **Forums**: https://forums.moonlang.org (Placeholder)
- **Discord**: Join our Discord (Placeholder)
- **Twitter** (**X**): @MoonLang (Placeholder)

Stay updated with the latest developments, share your projects, and collaborate with fellow Moon enthusiasts!

## Example Code

Islamic Calendar Example

```bash
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

Using Special Symbols in Control Structures

```bash
# control_structures.🌙

def check_positive(number):
    if number > 0 ۩  # Block closure with ۩
        print("Number is positive") ۝  # Statement terminator with ۝
    else ۩
        print("Number is not positive") ۝

☪@synchronized  # Decorator using ☪
def critical_section():
    # Code that needs synchronization
    pass

# Loop using 📿 (Prayer Beads)
def iterate_list(items):
    📿 item in items ۩
        print(item) ۝
```

## Contact

For any questions, suggestions, or support, feel free to reach out:

- **Email**: support@moonlanguage.org
- **GitHub Issues**: https://github.com/BenevolenceMessiah/Moon/issues
- **Discord**: Join our Discord (Placeholder)

Assalamu Aliakum!
Thank you for choosing Moon! Together, let's build a language that bridges technology and culture, fostering innovation and community. 🌙