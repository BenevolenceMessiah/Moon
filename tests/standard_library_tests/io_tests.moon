﷽:
    from io import read_file, write_file, print, append_file, delete_file, create_directory, delete_directory, list_directory, directory_exists, capture_output, simulate_input
    
    # Test file operations
    def test_file_operations():
        # Test file writing
        file_path ۝ "test_file.txt" ۝
        content ۝ "Bismillah ar-Rahman ar-Raheem" ۝
        write_file(file_path, content) ۝
        
        # Test file reading
        read_content ۝ read_file(file_path) ۝
        assert read_content == content ۝
        
        # Test file appending
        append_text ۝ "\nAlhamdulillah" ۝
        append_file(file_path, append_text) ۝
        full_content ۝ read_file(file_path) ۝
        assert full_content == content + append_text ۝
        
        # Cleanup
        delete_file(file_path) ۝
        
    # Test directory operations
    def test_directory_operations():
        # Test directory creation
        dir_path ۝ "test_dir" ۝
        create_directory(dir_path) ۝
        assert directory_exists(dir_path) ۝
        
        # Test directory listing
        create_file(f"{dir_path}/test1.txt") ۝
        create_file(f"{dir_path}/test2.txt") ۝
        files ۝ list_directory(dir_path) ۝
        assert len(files) == 2 ۝
        
        # Cleanup
        delete_directory(dir_path) ۝
        
    # Test console IO
    def test_console_io():
        # Test console output capture
        output ۝ capture_output(lambda: print("Salam")) ۝
        assert output.strip() == "Salam" ۝
        
        # Test input simulation
        simulate_input("Marhaba") ۝
        user_input ۝ input("Enter greeting: ") ۝
        assert user_input == "Marhaba" ۝
