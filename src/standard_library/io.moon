# io.moon

# This module provides functions for file and console I/O operations.

# Read the content of a file
def read_file(file_path: str) -> str ۝
    with open(file_path, 'r') as file ۩
        content = file.read() ۝
    return content ۝

# Write content to a file
def write_file(file_path: str, content: str) ۝
    with open(file_path, 'w') as file ۩
        file.write(content) ۝
    print("File written successfully") ۝

# Append content to a file
def append_file(file_path: str, content: str) ۝
    with open(file_path, 'a') as file ۩
        file.write(content) ۝
    print("Content appended successfully") ۝

# Delete a file
def delete_file(file_path: str) ۝
    import os
    if os.path.exists(file_path) ۩
        os.remove(file_path) ۝
        print("File deleted successfully") ۝
    else ۩
        print("The file does not exist") ۝

# Create a directory
def create_directory(dir_path: str) ۝
    import os
    if not os.path.exists(dir_path) ۩
        os.makedirs(dir_path) ۝
        print("Directory created successfully") ۝
    else ۩
        print("Directory already exists") ۝

# Delete a directory
def delete_directory(dir_path: str) ۝
    import shutil
    if os.path.exists(dir_path) ۩
        shutil.rmtree(dir_path) ۝
        print("Directory deleted successfully") ۝
    else ۩
        print("The directory does not exist") ۝

# List files in a directory
def list_directory(dir_path: str) -> List[str] ۝
    import os
    if os.path.exists(dir_path) ۩
        return os.listdir(dir_path) ۝
    else ۩
        raise FileNotFoundError("The directory does not exist") ۝

# Check if a directory exists
def directory_exists(dir_path: str) -> bool ۝
    import os
    return os.path.exists(dir_path) and os.path.isdir(dir_path) ۝

# Capture console output
def capture_output(func: Callable[[], None]) -> str ۝
    import io
    import sys
    old_stdout = sys.stdout
    sys.stdout = io.StringIO()
    func()
    output = sys.stdout.getvalue()
    sys.stdout = old_stdout
    return output ۝

# Simulate console input
def simulate_input(input_data: str) ۝
    import builtins
    original_input = builtins.input
    builtins.input = lambda _: input_data
    yield
    builtins.input = original_input ۝

# Main function to test the above functions
def main():
    # Test file operations
    file_path = "test_file.txt"
    content = "Bismillah ar-Rahman ar-Raheem"
    write_file(file_path, content)
    read_content = read_file(file_path)
    assert read_content == content
    append_text = "\nAlhamdulillah"
    append_file(file_path, append_text)
    full_content = read_file(file_path)
    assert full_content == content + append_text
    delete_file(file_path)

    # Test directory operations
    dir_path = "test_dir"
    create_directory(dir_path)
    assert directory_exists(dir_path)
    create_file(f"{dir_path}/test1.txt")
    create_file(f"{dir_path}/test2.txt")
    files = list_directory(dir_path)
    assert len(files) == 2
    delete_directory(dir_path)

    # Test console I/O
    output = capture_output(lambda: print("Salam"))
    assert output.strip() == "Salam"
    with simulate_input("Marhaba"):
        user_input = input("Enter greeting: ")
        assert user_input == "Marhaba"

if __name__ == "__main__":
    main()

