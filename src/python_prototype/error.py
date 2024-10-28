from dataclasses import dataclass
from enum import Enum, auto
from typing import Optional

class ErrorType(Enum):
    SYNTAX_ERROR = auto()
    NAME_ERROR = auto()
    TYPE_ERROR = auto()
    RUNTIME_ERROR = auto()
    DIVISION_BY_ZERO = auto()
    UNDEFINED_VARIABLE = auto()
    UNDEFINED_FUNCTION = auto()

@dataclass
class CompilerError(Exception):
    error_type: ErrorType
    message: str
    line: Optional[int] = None
    column: Optional[int] = None
    
    def __str__(self) -> str:
        location = f" at line {self.line}, column {self.column}" if self.line and self.column else ""
        return f"{self.error_type.name}: {self.message}{location}"

def raise_syntax_error(message: str, line: Optional[int] = None, column: Optional[int] = None) -> None:
    raise CompilerError(ErrorType.SYNTAX_ERROR, message, line, column)

def raise_name_error(message: str, line: Optional[int] = None, column: Optional[int] = None) -> None:
    raise CompilerError(ErrorType.NAME_ERROR, message, line, column)

def raise_type_error(message: str, line: Optional[int] = None, column: Optional[int] = None) -> None:
    raise CompilerError(ErrorType.TYPE_ERROR, message, line, column)

def raise_runtime_error(message: str, line: Optional[int] = None, column: Optional[int] = None) -> None:
    raise CompilerError(ErrorType.RUNTIME_ERROR, message, line, column)
