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
