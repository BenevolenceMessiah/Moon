// src/parser.rs

use crate::lexer::TokenType;
use crate::ast::{AstNode, AstNodeType};
use std::vec::Vec;

pub struct Parser {
    tokens: Vec<TokenType>,
    position: usize,
}

impl Parser {
    pub fn new(tokens: Vec<TokenType>) -> Self {
        Parser { tokens, position: 0 }
    }

    pub fn parse(&mut self) -> Result<AstNode, String> {
        let mut statements = Vec::new();
        while self.current_token() != &TokenType::EOF {
            statements.push(self.parse_statement()?);
        }
        Ok(AstNode::new(AstNodeType::Program, statements))
    }

    fn parse_statement(&mut self) -> Result<AstNode, String> {
        match self.current_token() {
            TokenType::Keyword(ref k) if k == "if" || k == "إذا" => self.parse_if_statement(),
            TokenType::Keyword(ref k) if k == "def" || k == "﷽" => self.parse_function_def(),
            TokenType::Keyword(ref k) if k == "for" || k == "📿" => self.parse_for_loop(),
            TokenType::Keyword(ref k) if k == "while" => self.parse_while_loop(),
            TokenType::Identifier(_) | TokenType::Symbol(_) => self.parse_expression_statement(),
            _ => Err(format!("Unexpected token: {:?}", self.current_token())),
        }
    }

    fn parse_if_statement(&mut self) -> Result<AstNode, String> {
        self.advance(); // Consume 'if'
        let condition = self.parse_expression()?;
        self.expect(TokenType::Operator(":".to_string()))?;
        self.expect(TokenType::Newline)?;
        self.expect(TokenType::Indent)?;
        let body = self.parse_block()?;
        self.expect(TokenType::Dedent)?;
        Ok(AstNode::new(
            AstNodeType::IfStatement,
            vec![condition, body],
        ))
    }

    fn parse_function_def(&mut self) -> Result<AstNode, String> {
        self.advance(); // Consume 'def' or '﷽'
        let name = match self.current_token() {
            TokenType::Identifier(ref s) => s.clone(),
            TokenType::Symbol(ref s) => s.clone(),
            _ => return Err("Expected function name".to_string()),
        };
        self.advance();
        self.expect(TokenType::Operator("(".to_string()))?;
        let params = self.parse_parameters()?;
        self.expect(TokenType::Operator(")".to_string()))?;
        self.expect(TokenType::Operator(":".to_string()))?;
        self.expect(TokenType::Newline)?;
        self.expect(TokenType::Indent)?;
        let body = self.parse_block()?;
        self.expect(TokenType::Dedent)?;
        Ok(AstNode::new(
            AstNodeType::FunctionDef(name, params),
            vec![body],
        ))
    }

    fn parse_parameters(&mut self) -> Result<Vec<String>, String> {
        let mut params = Vec::new();
        while let TokenType::Identifier(ref s) = self.current_token() {
            params.push(s.clone());
            self.advance();
            if self.current_token() == &TokenType::Operator(",".to_string()) {
                self.advance();
            } else {
                break;
            }
        }
        Ok(params)
    }

    fn parse_block(&mut self) -> Result<AstNode, String> {
        let mut statements = Vec::new();
        while self.current_token() != &TokenType::Dedent {
            statements.push(self.parse_statement()?);
        }
        Ok(AstNode::new(AstNodeType::Block, statements))
    }

    fn parse_expression_statement(&mut self) -> Result<AstNode, String> {
        let expr = self.parse_expression()?;
        if self.current_token() == &TokenType::Newline {
            self.advance();
        }
        Ok(expr)
    }

    fn parse_expression(&mut self) -> Result<AstNode, String> {
        self.parse_term()
    }

    fn parse_term(&mut self) -> Result<AstNode, String> {
        let mut node = self.parse_factor()?;
        while let TokenType::Operator(ref op) = self.current_token() {
            if op == "+" || op == "-" || op == "♡" {
                let operator = op.clone();
                self.advance();
                let right = self.parse_factor()?;
                node = AstNode::new(
                    AstNodeType::BinaryOp(operator),
                    vec![node, right],
                );
            } else {
                break;
            }
        }
        Ok(node)
    }

    fn parse_factor(&mut self) -> Result<AstNode, String> {
        match self.current_token() {
            TokenType::Number(n) => {
                let node = AstNode::new(AstNodeType::Number(*n), vec![]);
                self.advance();
                Ok(node)
            }
            TokenType::Identifier(ref s) => {
                let node = AstNode::new(AstNodeType::Identifier(s.clone()), vec![]);
                self.advance();
                Ok(node)
            }
            TokenType::String(ref s) => {
                let node = AstNode::new(AstNodeType::String(s.clone()), vec![]);
                self.advance();
                Ok(node)
            }
            TokenType::Operator(ref op) if op == "(" => {
                self.advance();
                let expr = self.parse_expression()?;
                self.expect(TokenType::Operator(")".to_string()))?;
                Ok(expr)
            }
            _ => Err(format!("Unexpected token in expression: {:?}", self.current_token())),
        }
    }

    fn expect(&mut self, expected: TokenType) -> Result<(), String> {
        if &expected == self.current_token() {
            self.advance();
            Ok(())
        } else {
            Err(format!(
                "Expected token {:?}, got {:?}",
                expected,
                self.current_token()
            ))
        }
    }

    fn current_token(&self) -> &TokenType {
        self.tokens.get(self.position).unwrap_or(&TokenType::EOF)
    }

    fn advance(&mut self) {
        if self.position < self.tokens.len() {
            self.position += 1;
        }
    }
}
