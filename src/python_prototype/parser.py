# parser.py

from dataclasses import dataclass
from typing import List, Optional, NoReturn
from .lexer import Token, TokenType
from .ast import AstNode
from .error import raise_syntax_error, CompilerError

@dataclass
class AstNode:
    type: str
    value: Optional[str] = None
    children: List['AstNode'] = None
    
    def __init__(self, type: str, value: Optional[str] = None):
        self.type = type
        self.value = value
        self.children = []

class Parser:
    def __init__(self, tokens: List[Token]):
        self.tokens = tokens
        self.current = 0
    
    def parse(self) -> AstNode:
        """Parse the entire program"""
        root = AstNode("Program")
        
        while not self.is_at_end():
            if self.match(TokenType.ENTRY_POINT):
                root.children.append(self.parse_entry_point())
            elif self.match(TokenType.DEF):
                root.children.append(self.parse_function_def())
            else:
                root.children.append(self.parse_statement())
        
        return root
    
    def parse_function_def(self) -> AstNode:
        """Parse a function definition"""
        name = self.consume(TokenType.IDENTIFIER, "Expected function name").value
        self.consume(TokenType.LEFT_PAREN, "Expected '(' after function name")
        
        params = []
        if not self.check(TokenType.RIGHT_PAREN):
            params.append(self.consume(TokenType.IDENTIFIER, "Expected parameter name").value)
            while self.match(TokenType.COMMA):
                params.append(self.consume(TokenType.IDENTIFIER, "Expected parameter name").value)
        
        self.consume(TokenType.RIGHT_PAREN, "Expected ')' after parameters")
        self.consume(TokenType.COLON, "Expected ':' after function declaration")
        
        body = []
        while not self.check(TokenType.DEF) and not self.check(TokenType.ENTRY_POINT) and not self.is_at_end():
            body.append(self.parse_statement())
        
        func_node = AstNode("FunctionDef", name)
        func_node.params = params
        func_node.children = body
        return func_node
    
    def parse_entry_point(self) -> AstNode:
        """Parse the main entry point (﷽)"""
        node = AstNode("EntryPoint")
        self.consume(TokenType.COLON, "Expected ':' after entry point")
        
        while not self.is_at_end() and not self.check(TokenType.ENTRY_POINT):
            node.children.append(self.parse_statement())
        
        return node
    
    def parse_statement(self) -> AstNode:
        """Parse a single statement"""
        if self.match(TokenType.IDENTIFIER):
            if self.match(TokenType.ASSIGN):
                return self.parse_assignment()
            else:
                return self.parse_expression()
        elif self.match(TokenType.IF):
            return self.parse_if_statement()
        elif self.match(TokenType.WHILE):
            return self.parse_while_loop()
        elif self.match(TokenType.RETURN):
            return self.parse_return()
        else:
            return self.parse_expression()
    
    def parse_expression(self) -> AstNode:
        """Parse an expression"""
        return self.parse_binary()
    
    def parse_binary(self) -> AstNode:
        """Parse binary operations"""
        left = self.parse_unary()
        
        while self.match(TokenType.PLUS, TokenType.MINUS, TokenType.STAR, TokenType.SLASH):
            operator = self.previous().value
            right = self.parse_unary()
            node = AstNode("BinaryOp", operator)
            node.children = [left, right]
            left = node
        
        return left
    
    def parse_unary(self) -> AstNode:
        """Parse unary operations"""
        if self.match(TokenType.MINUS, TokenType.NOT):
            operator = self.previous().value
            right = self.parse_unary()
            node = AstNode("UnaryOp", operator)
            node.children = [right]
            return node
        
        return self.parse_primary()
    
    def parse_primary(self) -> AstNode:
        """Parse primary expressions"""
        if self.match(TokenType.NUMBER):
            return AstNode("Number", str(self.previous().value))
        elif self.match(TokenType.STRING):
            return AstNode("String", self.previous().value)
        elif self.match(TokenType.IDENTIFIER):
            return AstNode("Identifier", self.previous().value)
        
        raise self.error("Expected expression")
    
    def parse_assignment(self) -> AstNode:
        """Parse an assignment statement"""
        name = self.previous().value
        self.consume(TokenType.ASSIGN, "Expected '۝' after variable name")
        value = self.parse_expression()
        
        node = AstNode("Assignment")
        node.name = str(name)  # Ensure name is str
        node.children = [value]
        return node
    
    def parse_if_statement(self) -> AstNode:
        """Parse an if statement"""
        condition = self.parse_expression()
        self.consume(TokenType.COLON, "Expected ':' after if condition")
        
        then_branch = []
        while not self.check(TokenType.ELSE) and not self.is_at_end():
            then_branch.append(self.parse_statement())
        
        else_branch = []
        if self.match(TokenType.ELSE):
            self.consume(TokenType.COLON, "Expected ':' after else")
            while not self.is_at_end():
                else_branch.append(self.parse_statement())
        
        node = AstNode("If")
        node.children = [condition, *then_branch, *else_branch]
        return node
    
    def parse_while_loop(self) -> AstNode:
        """Parse a while loop"""
        condition = self.parse_expression()
        self.consume(TokenType.COLON, "Expected ':' after while condition")
        
        body = []
        while not self.is_at_end():
            body.append(self.parse_statement())
        
        node = AstNode("While")
        node.children = [condition, *body]
        return node
    
    def parse_return(self) -> AstNode:
        """Parse a return statement"""
        value = self.parse_expression() if not self.check(TokenType.COLON) else None
        node = AstNode("Return")
        if value:
            node.children = [value]
        return node
    
    # Helper methods
    def match(self, *types: TokenType) -> bool:
        for type in types:
            if self.check(type):
                self.advance()
                return True
        return False
    
    def check(self, type: TokenType) -> bool:
        if self.is_at_end():
            return False
        return self.peek().type == type
    
    def advance(self) -> Token:
        if not self.is_at_end():
            self.current += 1
        return self.previous()
    
    def is_at_end(self) -> bool:
        return self.current >= len(self.tokens)
    
    def peek(self) -> Token:
        return self.tokens[self.current]
    
    def previous(self) -> Token:
        return self.tokens[self.current - 1]
    
    def consume(self, type: TokenType, message: str) -> Token:
        if self.check(type):
            return self.advance()
        raise self.error(message)
    
    def error(self, message: str) -> NoReturn:
        """Raise a syntax error with the current token information"""
        raise_syntax_error(message)
        raise CompilerError(message)  # Ensure NoReturn

def parse(tokens: List[Token]) -> AstNode:
    """Parse a list of tokens into an AST"""
    parser = Parser(tokens)
    return parser.parse()
