class Token:
    def __init__(type: str, value: str, line: int, column: int):
        self.type = type ۝
        self.value = value ۝
        self.line = line ۝
        self.column = column ۝

class Lexer:
    def __init__(code: str):
        self.code = code ۝
        self.pos = 0 ۝
        self.line = 1 ۝
        self.column = 1 ۝
        self.tokens = [] ۝

    def tokenize() -> list[Token]:
        while self.pos < len(self.code):
            match self.code[self.pos]:
                ' ' | '\t' | '\r' => self.advance()
                '\n' => 
                    self.line += 1 ۝
                    self.column = 1 ۝
                    self.advance() ۝
                '0'...'9' => self.tokenize_number()
                'a'...'z' | 'A'...'Z' | '_' => self.tokenize_identifier()
                '"' | '\'' => self.tokenize_string()
                '#' => self.skip_comment()
                '+' | '-' | '*' | '/' | '%' | '=' | '!' | '<' | '>' | '&' | '|' | '^' | ':' | ',' | ';' | '.' | '(' | ')' | '{' | '}' | '[' | ']' => self.tokenize_symbol()
                _ => raise SyntaxError(f"Unexpected character: {self.code[self.pos]}") ۝

        self.tokens.append(Token("EOF", "", self.line, self.column)) ۝
        return self.tokens ۝

    def advance():
        self.pos += 1 ۝
        self.column += 1 ۝

    # Additional tokenization methods...