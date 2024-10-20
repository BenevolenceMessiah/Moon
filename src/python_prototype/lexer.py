# lexer.py

import re

# Define token types and their regex patterns
TOKENS = [
    ('NUMBER', r'\d+(\.\d*)?'),  # Integer or decimal number
    ('IDENTIFIER', r'[a-zA-Z_][a-zA-Z0-9_]*'),  # Identifier
    ('STRING', r'"([^\\"]|\\.)*"'),  # String enclosed in double quotes
    ('OPERATOR', r'[+\-*/%!=<>&|^]'),  # Operators
    ('DELIMITER', r'[;,()\{\}\[\]]'),  # Delimiters
    ('WHITESPACE', r'\s+'),  # Whitespace
    ('COMMENT', r'//.*|/\*[\s\S]*?\*/'),  # Comments
]

# Define keywords and their corresponding token types
KEYWORDS = {
    'if': 'IF',
    'else': 'ELSE',
    'for': 'FOR',
    'while': 'WHILE',
    'def': 'DEF',
    'class': 'CLASS',
    'return': 'RETURN',
    'main': 'MAIN',
}

# Islamic-themed symbols and phrases with their corresponding token types
ISLAMIC_SYMBOLS = {
    '﷽': 'BISMILLAH',
    '☪': 'DECORATOR',
    '☭': 'SYNCHRONIZE',
    '۩': 'BLOCK_END',
    'لَا إِلَٰهَ إِلَّا ٱللَّٰهُ': 'TRUE',
    '♡': 'LIKE',
    '۝': 'END_STATEMENT',
    'ٱلسَّلَامُ عَلَيْكُمْ': 'HELLO_WORLD',
    '🕌': 'MODULE',
    '🕋': 'CORE',
    '📿': 'ITERATE',
    '🌙': 'IMPORT_MOON',
}

# Combine all special symbols into a single regex pattern
SPECIAL_SYMBOLS_PATTERN = '|'.join(re.escape(sym) for sym in sorted(ISLAMIC_SYMBOLS.keys(), key=lambda x: -len(x)))

# Compile all token regex patterns
TOKEN_REGEX = [(typ, re.compile(pattern)) for typ, pattern in TOKENS]

# Function to tokenize the input code
def tokenize(code):
    tokens = []
    position = 0
    line = 1
    column = 1
    while position < len(code):
        match = None
        # Check for special symbols and phrases first
        special_match = re.match(SPECIAL_SYMBOLS_PATTERN, code[position:])
        if special_match:
            sym = special_match.group(0)
            tokens.append((ISLAMIC_SYMBOLS[sym], sym))
            consumed = len(sym)
            position += consumed
            column += consumed
            continue

        for token_type, regex in TOKEN_REGEX:
            match = regex.match(code, position)
            if match:
                value = match.group(0)
                if token_type == 'IDENTIFIER' and value in KEYWORDS:
                    tokens.append((KEYWORDS[value], value))
                elif token_type == 'OPERATOR':
                    tokens.append((token_type, value))
                elif token_type not in ['WHITESPACE', 'COMMENT']:
                    tokens.append((token_type, value))
                # Update position and column
                consumed = len(value)
                position += consumed
                column += consumed
                break
        if not match and not special_match:
            raise SyntaxError(f"Unexpected character: {code[position]} at line {line} column {column}")
    tokens.append(('EOF', 'EOF'))
    return tokens
