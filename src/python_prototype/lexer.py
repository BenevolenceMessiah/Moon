# lexer.py

from enum import Enum, auto
from dataclasses import dataclass
from typing import List, Any

class TokenType(Enum):
    NUMBER = auto()
    STRING = auto()
    IDENTIFIER = auto()
    ENTRY_POINT = auto()
    COLON = auto()
    LEFT_PAREN = auto()
    RIGHT_PAREN = auto()
    ASSIGN = auto()
    CONCAT = auto()
    SYMBOL = auto()
    PLUS = auto()
    MINUS = auto()
    STAR = auto()
    SLASH = auto()
    IF = auto()
    ELSE = auto()
    WHILE = auto()
    RETURN = auto()
    NOT = auto()
    DEF = auto()
    MAKE_FUNCTION = auto()
    GET_ITER = auto()
    POP_JUMP_IF_FALSE = auto()
    COMMA = auto()  # Added missing COMMA token

@dataclass
class Token:
    type: TokenType
    value: Any

def tokenize(code: str) -> List[Token]:
    """Tokenizes input code into a list of tokens"""
    keywords = {
        'if': TokenType.IF,
        'else': TokenType.ELSE,
        'while': TokenType.WHILE,
        'return': TokenType.RETURN,
        'def': TokenType.DEF,
    }
    
    tokens = []
    i = 0
    
    while i < len(code):
        char = code[i]
        
        if char.isspace():
            i += 1
            continue
        
        if char.isdigit():
            num = ""
            while i < len(code) and (code[i].isdigit() or code[i] == '.'):
                num += code[i]
                i += 1
            tokens.append(Token(TokenType.NUMBER, float(num)))
            continue
            
        elif char == '"' or char == "'":
            string = ""
            quote = char
            i += 1
            while i < len(code) and code[i] != quote:
                string += code[i]
                i += 1
            i += 1  # Skip closing quote
            tokens.append(Token(TokenType.STRING, string))
            continue
            
        elif char.isalpha():
            ident = ""
            while i < len(code) and (code[i].isalnum() or code[i] == "_"):
                ident += code[i]
                i += 1
            # Check if it's a keyword
            token_type = keywords.get(ident, TokenType.IDENTIFIER)
            tokens.append(Token(token_type, ident))
            continue
            
        elif char == "﷽":
            tokens.append(Token(TokenType.ENTRY_POINT, char))
        elif char == "۝":
            tokens.append(Token(TokenType.ASSIGN, char))
        elif char == "۩":
            tokens.append(Token(TokenType.CONCAT, char))
        elif char == ":":
            tokens.append(Token(TokenType.COLON, char))
        elif char == "(":
            tokens.append(Token(TokenType.LEFT_PAREN, char))
        elif char == ")":
            tokens.append(Token(TokenType.RIGHT_PAREN, char))
        elif char == "+":
            tokens.append(Token(TokenType.PLUS, char))
        elif char == "-":
            tokens.append(Token(TokenType.MINUS, char))
        elif char == "*":
            tokens.append(Token(TokenType.STAR, char))
        elif char == "/":
            tokens.append(Token(TokenType.SLASH, char))
        elif char == ",":
            tokens.append(Token(TokenType.COMMA, char))
            
        i += 1
        
    return tokens
