#[cfg(test)]
mod tests {
    use super::*;
    use crate::parser::Parser;
    use crate::lexer::{Lexer, TokenType};

    #[test]
    fn test_parse_function_definition() {
        let code = "def test(x, y): return x + y";
        let mut lexer = Lexer::new(code);
        lexer.tokenize().unwrap();
        let mut parser = Parser::new(lexer.tokens);
        let ast = parser.parse().unwrap();
        
        match ast.node_type {
            AstNodeType::Program => {
                let func_def = &ast.children[0];
                match &func_def.node_type {
                    AstNodeType::FunctionDef(name, params) => {
                        assert_eq!(name, "test");
                        assert_eq!(params, &vec!["x".to_string(), "y".to_string()]);
                    },
                    _ => panic!("Expected function definition")
                }
            },
            _ => panic!("Expected program node")
        }
    }
}

