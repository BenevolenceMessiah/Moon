#[cfg(test)]
mod tests {
    use super::*;
    use crate::compiler::Compiler;
    use crate::ast::{AstNode, AstNodeType};

    #[test]
    fn test_compile_number() {
        let mut compiler = Compiler::new();
        let node = AstNode::new(
            AstNodeType::Number(42.0),
            vec![]
        );
        compiler.compile(&node);
        let (bytecode, constants) = compiler.get_bytecode();
        assert_eq!(constants[0], 42.0);
    }

    #[test]
    fn test_compile_binary_operation() {
        let mut compiler = Compiler::new();
        let node = AstNode::new(
            AstNodeType::BinaryOp("+".to_string()),
            vec![
                AstNode::new(AstNodeType::Number(5.0), vec![]),
                AstNode::new(AstNodeType::Number(3.0), vec![])
            ]
        );
        compiler.compile(&node);
        let (bytecode, constants) = compiler.get_bytecode();
        assert_eq!(constants[0], 5.0);
        assert_eq!(constants[1], 3.0);
    }
}

