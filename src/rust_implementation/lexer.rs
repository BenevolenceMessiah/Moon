// src/lexer.rs

use std::str::Chars;
use std::iter::Peekable;

#[derive(Debug, Clone, PartialEq)]
pub enum TokenType {
    Identifier(String),
    Number(f64),
    String(String),
    Operator(String),
    Keyword(String),
    Symbol(String),
    Newline,
    Indent,
    Dedent,
    EOF,
}

pub struct Lexer<'a> {
    input: Peekable<Chars<'a>>,
    pub tokens: Vec<TokenType>,
    current_indent: usize,
    indent_stack: Vec<usize>,
}

impl<'a> Lexer<'a> {
    pub fn new(input: &'a str) -> Self {
        Lexer {
            input: input.chars().peekable(),
            tokens: Vec::new(),
            current_indent: 0,
            indent_stack: Vec::new(),
        }
    }

    pub fn tokenize(&mut self) -> Result<(), String> {
        while let Some(&ch) = self.input.peek() {
            match ch {
                c if c.is_whitespace() => {
                    self.consume_whitespace();
                }
                c if c.is_alphabetic() || c == '_' || c >= '\u{0600}' => {
                    let identifier = self.consume_identifier()?;
                    self.tokens.push(identifier);
                }
                c if c.is_digit(10) => {
                    let number = self.consume_number()?;
                    self.tokens.push(TokenType::Number(number));
                }
                '"' | '\'' => {
                    let string = self.consume_string(ch)?;
                    self.tokens.push(TokenType::String(string));
                }
                '#' => {
                    self.consume_comment();
                }
                _ => {
                    let symbol = self.consume_symbol()?;
                    self.tokens.push(symbol);
                }
            }
        }
        self.tokens.push(TokenType::EOF);
        Ok(())
    }

    fn consume_whitespace(&mut self) {
        while let Some(&ch) = self.input.peek() {
            if ch == '\n' {
                self.input.next();
                self.tokens.push(TokenType::Newline);
                self.handle_indent();
            } else if ch.is_whitespace() {
                self.input.next();
            } else {
                break;
            }
        }
    }

    fn handle_indent(&mut self) {
        let mut indent_level = 0;
        while let Some(&ch) = self.input.peek() {
            if ch == ' ' {
                indent_level += 1;
                self.input.next();
            } else {
                break;
            }
        }

        if indent_level > self.current_indent {
            self.indent_stack.push(indent_level);
            self.current_indent = indent_level;
            self.tokens.push(TokenType::Indent);
        } else if indent_level < self.current_indent {
            while let Some(&last_indent) = self.indent_stack.last() {
                if last_indent > indent_level {
                    self.indent_stack.pop();
                    self.tokens.push(TokenType::Dedent);
                } else {
                    break;
                }
            }
            self.current_indent = indent_level;
        }
    }

    fn consume_identifier(&mut self) -> Result<TokenType, String> {
        let mut identifier = String::new();
        while let Some(&ch) = self.input.peek() {
            if ch.is_alphanumeric() || ch == '_' || ch >= '\u{0600}' {
                identifier.push(ch);
                self.input.next();
            } else {
                break;
            }
        }
        // Check for special symbols and keywords
        match identifier.as_str() {
            "if" | "else" | "for" | "while" | "def" | "class" | "return" | "import" | "from" | "async" | "await" | "try" | "except" | "finally" | "raise" | "yield" | "main" => {
                Ok(TokenType::Keyword(identifier))
            }
            "﷽" | "☪" | "☭" | "۩" | "لَا" | "إِلَٰهَ" | "إِلَّا" | "ٱللَّٰهُ" | "♡" | "۝" | "ٱلسَّلَامُ" | "عَلَيْكُمْ" | "🕌" | "🕋" | "📿" | "🌙" => {
                Ok(TokenType::Symbol(identifier))
            }
            _ => Ok(TokenType::Identifier(identifier)),
        }
    }

    fn consume_number(&mut self) -> Result<f64, String> {
        let mut number = String::new();
        while let Some(&ch) = self.input.peek() {
            if ch.is_digit(10) || ch == '.' {
                number.push(ch);
                self.input.next();
            } else {
                break;
            }
        }
        number.parse::<f64>().map_err(|e| e.to_string())
    }

    fn consume_string(&mut self, quote_type: char) -> Result<String, String> {
        self.input.next(); // Consume the opening quote
        let mut string = String::new();
        while let Some(&ch) = self.input.peek() {
            if ch == quote_type {
                self.input.next(); // Consume the closing quote
                return Ok(string);
            } else {
                string.push(ch);
                self.input.next();
            }
        }
        Err("Unterminated string literal".to_string())
    }

    fn consume_comment(&mut self) {
        while let Some(&ch) = self.input.peek() {
            if ch == '\n' {
                break;
            } else {
                self.input.next();
            }
        }
    }

    fn consume_symbol(&mut self) -> Result<TokenType, String> {
        let ch = self.input.next().unwrap();
        match ch {
            '+' | '-' | '*' | '/' | '%' | '=' | '!' | '<' | '>' | '&' | '|' | '^' | ':' | ',' | ';' | '.' | '(', ')', '{', '}', '[', ']' => {
                Ok(TokenType::Operator(ch.to_string()))
            }
            _ => Err(format!("Unexpected character: {}", ch)),
        }
    }
}
