#[cfg(test)]
mod tests {
    use super::*;
    use crate::error::{Error, handle_error, RuntimeError, ErrorType};
    use crate::interpreter::Interpreter;

    #[test]
    fn test_syntax_error_handling() {
        let code = "﷽: x ۝ 1 + + 2";  // Invalid syntax
        let result = Interpreter::new().run(code);
        assert!(matches!(result, Err(RuntimeError { 
            error_type: ErrorType::SyntaxError,
            ..
        })));
    }

    #[test]
    fn test_division_by_zero() {
        let code = "﷽: x ۝ 5 / 0";
        let result = Interpreter::new().run(code);
        assert!(matches!(result, Err(RuntimeError { 
            error_type: ErrorType::DivisionByZero,
            ..
        })));
    }

    #[test]
    fn test_undefined_variable() {
        let code = "﷽: print(undefined_var)";
        let result = Interpreter::new().run(code);
        assert!(matches!(result, Err(RuntimeError { 
            error_type: ErrorType::UndefinedVariable,
            ..
        })));
    }

    #[test]
    fn test_type_error() {
        let code = "﷽: x ۝ 'text' + 42";  // String + number
        let result = Interpreter::new().run(code);
        assert!(matches!(result, Err(RuntimeError { 
            error_type: ErrorType::TypeError,
            ..
        })));
    }

    #[test]
    fn test_error_display() {
        let syntax_err = Error::Syntax("Test error".to_string());
        assert_eq!(
            format!("{}", syntax_err),
            "Syntax Error: Test error"
        );
    }
}
