# compiler.py

from typing import List, Tuple, Dict, Any, Optional
from dataclasses import dataclass, field
from .vm import Instruction, OpCode
from .parser import parse
from .lexer import tokenize, Token
from .ast import AstNode
from .error import raise_syntax_error

@dataclass
class CompilerContext:
    constants: List[Any] = field(default_factory=list)
    names: List[str] = field(default_factory=list)
    instructions: List[Instruction] = field(default_factory=list)
    
    def add_constant(self, value: Any) -> int:
        """Add a constant and return its index"""
        if value in self.constants:
            return self.constants.index(value)
        self.constants.append(value)
        return len(self.constants) - 1
    
    def add_name(self, name: str) -> int:
        """Add a name and return its index"""
        if name in self.names:
            return self.names.index(name)
        self.names.append(name)
        return len(self.names) - 1

class Compiler:
    def __init__(self):
        self.context = CompilerContext()
    
    def compile(self, node: AstNode) -> None:
        """Compile an AST node"""
        method = getattr(self, f'compile_{node.type.lower()}', None)
        if method is None:
            raise_syntax_error(f"Cannot compile node type: {node.type}")
        method(node)
    
    def compile_program(self, node: AstNode) -> None:
        """Compile a program node"""
        for child in node.children:
            self.compile(child)
    
    def compile_number(self, node: AstNode) -> None:
        """Compile a number literal"""
        const_index = self.context.add_constant(float(node.value))
        self.context.instructions.append(
            Instruction(OpCode.LOAD_CONST, const_index)
        )
    
    def compile_string(self, node: AstNode) -> None:
        """Compile a string literal"""
        const_index = self.context.add_constant(str(node.value))
        self.context.instructions.append(
            Instruction(OpCode.LOAD_CONST, const_index)
        )
    
    def compile_binaryop(self, node: AstNode) -> None:
        """Compile a binary operation"""
        self.compile(node.children[0])
        self.compile(node.children[1])
        
        op_map = {
            "+": OpCode.BINARY_ADD,
            "-": OpCode.BINARY_SUBTRACT,
            "*": OpCode.BINARY_MULTIPLY,
            "/": OpCode.BINARY_DIVIDE,
            "۩": OpCode.BINARY_ADD  # Islamic concatenation uses add
        }
        
        if node.value not in op_map:
            raise_syntax_error(f"Unknown operator: {node.value}")
            
        self.context.instructions.append(
            Instruction(op_map[node.value])
        )
    
    def get_code(self) -> List[Instruction]:
        """Get the compiled bytecode"""
        return self.context.instructions

def compile_code(source: str) -> List[Instruction]:
    """Compile source code into VM instructions"""
    tokens = tokenize(source)
    ast = parse(tokens)
    
    compiler = Compiler()
    compiler.compile(ast)
    
    return compiler.get_code()
