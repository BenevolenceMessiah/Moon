from typing import Dict, Set, Optional, List
from dataclasses import dataclass, field
from .ast import AstNode
from .error import raise_type_error, raise_name_error

@dataclass
class Symbol:
    name: str
    type: str
    is_mutable: bool = True
    is_initialized: bool = False

@dataclass
class SymbolTable:
    symbols: Dict[str, Symbol] = field(default_factory=dict)
    parent: Optional['SymbolTable'] = None
    
    def define(self, name: str, type_: str, is_mutable: bool = True) -> None:
        """Define a new symbol in the current scope"""
        if name in self.symbols:
            raise_name_error(f"Symbol '{name}' already defined in current scope")
        self.symbols[name] = Symbol(name, type_, is_mutable)
    
    def lookup(self, name: str) -> Optional[Symbol]:
        """Look up a symbol in this scope or parent scopes"""
        if name in self.symbols:
            return self.symbols[name]
        if self.parent:
            return self.parent.lookup(name)
        return None

class SemanticAnalyzer:
    """Performs semantic analysis on the AST"""
    def __init__(self):
        self.current_scope = SymbolTable()
        self.loop_depth = 0
        self.function_depth = 0
    
    def analyze(self, node: AstNode) -> None:
        """Analyze an AST node"""
        if node.type == "Program":
            for child in node.children:
                self.analyze(child)
                
        elif node.type == "FunctionDef":
            self.function_depth += 1
            # Create new scope for function
            old_scope = self.current_scope
            self.current_scope = SymbolTable(parent=old_scope)
            
            # Add parameters to function scope
            for param in node.params:
                self.current_scope.define(param, "Any")  # Parameters are always mutable
            
            # Analyze function body
            for child in node.children:
                self.analyze(child)
            
            self.current_scope = old_scope
            self.function_depth -= 1
            
        elif node.type == "Assignment":
            # Check if variable exists and is mutable
            symbol = self.current_scope.lookup(node.value)
            if symbol and not symbol.is_mutable:
                raise_type_error(f"Cannot assign to immutable variable '{node.value}'")
            
            # Analyze right-hand side
            self.analyze(node.children[0])
            
            # Define new variable if it doesn't exist
            if not symbol:
                self.current_scope.define(node.value, "Any")
                
        elif node.type == "While":
            self.loop_depth += 1
            self.analyze(node.children[0])  # Condition
            for child in node.children[1:]:  # Body
                self.analyze(child)
            self.loop_depth -= 1
            
        elif node.type == "Break" or node.type == "Continue":
            if self.loop_depth == 0:
                raise_type_error(f"'{node.type.lower()}' outside loop")
                
        elif node.type == "Return":
            if self.function_depth == 0:
                raise_type_error("'return' outside function")
            if node.children:
                self.analyze(node.children[0])
                
        elif node.type == "Identifier":
            if not self.current_scope.lookup(node.value):
                raise_name_error(f"Undefined variable '{node.value}'")
                
        # Recursively analyze child nodes
        for child in node.children:
            self.analyze(child) 