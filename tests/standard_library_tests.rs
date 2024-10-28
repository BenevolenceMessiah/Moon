// standard_library_tests.rs

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1.0, 2.0), 3.0);
    }

    #[test]
    fn test_subtract() {
        assert_eq!(subtract(5.0, 3.0), 2.0);
    }

    #[test]
    fn test_multiply() {
        assert_eq!(multiply(4.0, 3.0), 12.0);
    }

    #[test]
    fn test_divide() {
        assert_eq!(divide(10.0, 2.0), 5.0);
        assert_eq!(divide(10.0, 0.0), 0.0); // Division by zero should return 0
    }

    #[test]
    fn test_read_file() {
        let content = read_file("test.txt").unwrap();
        assert_eq!(content, "Hello, World!");
    }

    #[test]
    fn test_write_file() {
        write_file("test.txt", "Hello, Moon!").unwrap();
        let content = read_file("test.txt").unwrap();
        assert_eq!(content, "Hello, Moon!");
    }

    #[test]
    fn test_print() {
        // Capture stdout to test print function
        let output = std::sync::Arc::new(std::sync::Mutex::new(Vec::new()));
        let output_clone = output.clone();
        let _guard = std::io::set_output_capture(Some(Box::new(move |s| {
            output_clone.lock().unwrap().extend_from_slice(s.as_bytes());
        })));

        print("Hello, Moon!");
        let output = String::from_utf8(output.lock().unwrap().clone()).unwrap();
        assert_eq!(output, "Hello, Moon!");
    }
}
