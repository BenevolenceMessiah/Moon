#[cfg(test)]
mod tests {
    use super::*;
    use crate::interpreter::Interpreter;
    use crate::ast::{AstNode, AstNodeType};

    #[test]
    fn test_interpret_number() {
        let mut interpreter = Interpreter::new();
        let node = AstNode::new(
            AstNodeType::Number(42.0),
            vec![]
        );
        let result = interpreter.interpret(&node).unwrap();
        assert_eq!(result, Value::Number(42.0));
    }

    #[test]
    fn test_interpret_binary_operation() {
        let mut interpreter = Interpreter::new();
        let node = AstNode::new(
            AstNodeType::BinaryOp("+".to_string()),
            vec![
                AstNode::new(AstNodeType::Number(5.0), vec![]),
                AstNode::new(AstNodeType::Number(3.0), vec![])
            ]
        );
        let result = interpreter.interpret(&node).unwrap();
        assert_eq!(result, Value::Number(8.0));
    }

    #[test]
    fn test_interpret_islamic_symbols() {
        let mut interpreter = Interpreter::new();
        let node = AstNode::new(
            AstNodeType::Symbol("﷽".to_string()),
            vec![]
        );
        let result = interpreter.interpret(&node).unwrap();
        assert_eq!(result, Value::Symbol("﷽".to_string()));
    }
}

