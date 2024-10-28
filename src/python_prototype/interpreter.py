# interpreter.py

from typing import Any, Dict, Optional, Union, cast
from .ast import AstNode
from .stdlib import StdLib

class Interpreter:
    def __init__(self):
        self.variables: Dict[str, Any] = {}
        self.functions: Dict[str, AstNode] = {}
        self.stdlib = StdLib()
        
    def interpret(self, node: AstNode) -> Optional[Any]:
        """Interpret an AST node"""
        if node.type == "Program":
            result = None
            for child in node.children:
                result = self.interpret(child)
            return result
            
        elif node.type == "EntryPoint":
            result = None
            for child in node.children:
                result = self.interpret(child)
            return result
            
        elif node.type == "Number":
            return float(cast(str, node.value))
            
        elif node.type == "String":
            return str(cast(str, node.value))
            
        elif node.type == "Identifier":
            name = cast(str, node.value)
            if name in self.variables:
                return self.variables[name]
            raise NameError(f"Variable '{name}' is not defined")
            
        elif node.type == "BinaryOp":
            left = self.interpret(node.children[0])
            right = self.interpret(node.children[1])
            op = cast(str, node.value)
            
            if left is None or right is None:
                raise ValueError("Cannot perform operation on None values")
            
            if op == "+":
                return left + right
            elif op == "-":
                return left - right
            elif op == "*":
                return left * right
            elif op == "/":
                if right == 0:
                    raise ZeroDivisionError("Division by zero")
                return left / right
            elif op == "۩":  # Islamic concatenation
                return str(left) + str(right)
                
        elif node.type == "Assignment":
            name = cast(str, node.value)
            value = self.interpret(node.children[1])
            self.variables[name] = value
            return value
            
        elif node.type == "FunctionDef":
            name = cast(str, node.value)
            self.functions[name] = node
            return None
            
        elif node.type == "FunctionCall":
            name = cast(str, node.value)
            if hasattr(self.stdlib, name):
                func = getattr(self.stdlib, name)
                args = [self.interpret(arg) for arg in node.children]
                return func(*args)
            elif name in self.functions:
                func_node = self.functions[name]
                return self.call_function(func_node, node.children)
            else:
                raise NameError(f"Function '{name}' is not defined")
        
        raise NotImplementedError(f"Node type '{node.type}' not implemented")
    
    def call_function(self, func_node: AstNode, args: list) -> Any:
        """Execute a function call"""
        # Save current scope
        old_variables = self.variables.copy()
        
        # Bind parameters to arguments
        for param, arg in zip(func_node.params, args):
            self.variables[param] = self.interpret(arg)
            
        # Execute function body
        result = None
        for statement in func_node.children:
            result = self.interpret(statement)
            
        # Restore scope
        self.variables = old_variables
        return result
