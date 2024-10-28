#[cfg(test)]
mod tests {
    use super::*;
    use crate::optimizer::{optimize, OptimizationPass};
    use crate::ast::{AstNode, AstNodeType};

    #[test]
    fn test_constant_folding() {
        // Test folding of constant expressions
        let input = AstNode::new(
            AstNodeType::BinaryOp("+".to_string()),
            vec![
                AstNode::new(AstNodeType::Number(5.0), vec![]),
                AstNode::new(AstNodeType::Number(3.0), vec![])
            ]
        );
        
        let optimized = optimize(&input);
        assert!(matches!(optimized.node_type, AstNodeType::Number(8.0)));
    }

    #[test]
    fn test_dead_code_elimination() {
        // Test removal of unreachable code
        let input = AstNode::new(
            AstNodeType::If,
            vec![
                AstNode::new(AstNodeType::Boolean(false), vec![]),
                AstNode::new(AstNodeType::Block, vec![
                    AstNode::new(AstNodeType::Print, vec![])
                ])
            ]
        );
        
        let optimized = optimize(&input);
        assert_eq!(optimized.children.len(), 0);
    }

    #[test]
    fn test_expression_simplification() {
        // Test simplification of expressions like x * 1, x + 0
        let input = AstNode::new(
            AstNodeType::BinaryOp("*".to_string()),
            vec![
                AstNode::new(AstNodeType::Identifier("x".to_string()), vec![]),
                AstNode::new(AstNodeType::Number(1.0), vec![])
            ]
        );
        
        let optimized = optimize(&input);
        assert!(matches!(optimized.node_type, 
            AstNodeType::Identifier(ref name) if name == "x"
        ));
    }

    #[test]
    fn test_islamic_symbol_preservation() {
        // Ensure Islamic symbols are preserved during optimization
        let input = AstNode::new(
            AstNodeType::BinaryOp("۩".to_string()),  // Islamic concatenation operator
            vec![
                AstNode::new(AstNodeType::String("Salam".to_string()), vec![]),
                AstNode::new(AstNodeType::String(" Alaikum".to_string()), vec![])
            ]
        );
        
        let optimized = optimize(&input);
        assert!(matches!(optimized.node_type, 
            AstNodeType::String(ref s) if s == "Salam Alaikum"
        ));
    }
}
