#[cfg(test)]
mod tests {
    use super::*;
    use crate::lexer::{Lexer, TokenType};

    #[test]
    fn test_tokenize_number() {
        let mut lexer = Lexer::new("42");
        lexer.tokenize().unwrap();
        assert_eq!(lexer.tokens[0], TokenType::Number(42.0));
    }

    #[test]
    fn test_tokenize_identifier() {
        let mut lexer = Lexer::new("variable_name");
        lexer.tokenize().unwrap();
        assert_eq!(lexer.tokens[0], TokenType::Identifier("variable_name".to_string()));
    }

    #[test]
    fn test_tokenize_islamic_symbols() {
        let mut lexer = Lexer::new("﷽ ☪ ۩");
        lexer.tokenize().unwrap();
        assert_eq!(lexer.tokens[0], TokenType::Symbol("﷽".to_string()));
        assert_eq!(lexer.tokens[1], TokenType::Symbol("☪".to_string()));
        assert_eq!(lexer.tokens[2], TokenType::Symbol("۩".to_string()));
    }
}

