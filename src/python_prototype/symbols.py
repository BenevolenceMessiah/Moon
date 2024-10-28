from enum import Enum
from typing import Dict, Any

class IslamicSymbols:
    BISMILLAH = "﷽"  # Entry point marker
    ASSIGNMENT = "۝"  # Assignment operator
    CONCATENATION = "۩"  # String concatenation
    PRAYER = "☪"  # Prayer-related operations
    END_STATEMENT = "۞"  # Statement terminator
    
    # Mathematical symbols
    MULTIPLY = "×"
    DIVIDE = "÷"
    
    @classmethod
    def is_valid_symbol(cls, symbol: str) -> bool:
        return symbol in {
            cls.BISMILLAH,
            cls.ASSIGNMENT,
            cls.CONCATENATION,
            cls.PRAYER,
            cls.END_STATEMENT,
            cls.MULTIPLY,
            cls.DIVIDE
        }

class Constants:
    """Language constants and configuration"""
    MAX_RECURSION_DEPTH = 1000
    MAX_STRING_LENGTH = 1_000_000
    MAX_LIST_SIZE = 10_000
    
    # Special values
    NULL = None
    TRUE = True
    FALSE = False
    
    # Mathematical constants
    PI = 3.14159265359
    GOLDEN_RATIO = 1.61803398875
    
    # Islamic calendar constants
    LUNAR_YEAR = 354.367056
    HIJRI_EPOCH = 1948439.5  # Julian day for 1 Muharram 1 AH
    
    @classmethod
    def get_constant(cls, name: str) -> Any:
        """Get a constant value by name"""
        return getattr(cls, name.upper(), None)

class OperatorPrecedence(Enum):
    """Operator precedence levels"""
    ASSIGNMENT = 1
    LOGICAL_OR = 2
    LOGICAL_AND = 3
    EQUALITY = 4
    COMPARISON = 5
    TERM = 6
    FACTOR = 7
    UNARY = 8
    CALL = 9
    PRIMARY = 10

BINARY_OPS: Dict[str, int] = {
    "۝": OperatorPrecedence.ASSIGNMENT.value,  # Assignment
    "||": OperatorPrecedence.LOGICAL_OR.value,
    "&&": OperatorPrecedence.LOGICAL_AND.value,
    "==": OperatorPrecedence.EQUALITY.value,
    "!=": OperatorPrecedence.EQUALITY.value,
    "<": OperatorPrecedence.COMPARISON.value,
    ">": OperatorPrecedence.COMPARISON.value,
    "<=": OperatorPrecedence.COMPARISON.value,
    ">=": OperatorPrecedence.COMPARISON.value,
    "+": OperatorPrecedence.TERM.value,
    "-": OperatorPrecedence.TERM.value,
    "*": OperatorPrecedence.FACTOR.value,
    "/": OperatorPrecedence.FACTOR.value,
    "۩": OperatorPrecedence.TERM.value,  # Concatenation
} 