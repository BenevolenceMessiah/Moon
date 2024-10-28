import unittest
from src.python_prototype.lexer import tokenize, Token, TokenType

class TestLexer(unittest.TestCase):
    def test_tokenize_numbers(self):
        tokens = tokenize("42")
        self.assertEqual(len(tokens), 1)
        self.assertEqual(tokens[0].type, "NUMBER")
        self.assertEqual(tokens[0].value, 42)

    def test_tokenize_islamic_symbols(self):
        tokens = tokenize("﷽")
        self.assertEqual(tokens[0].type, "SYMBOL")
        self.assertEqual(tokens[0].value, "﷽")

    def test_tokenize_operators(self):
        tokens = tokenize("+ - * /")
        operators = [token.value for token in tokens]
        self.assertEqual(operators, ["+", "-", "*", "/"])

    def test_tokenize_keywords(self):
        code = "def if else while"
        tokens = tokenize(code)
        keywords = [token.value for token in tokens]
        self.assertEqual(keywords, ["def", "if", "else", "while"])

    def test_tokenize_complete_line(self):
        code = "def add(x, y): return x + y ۝"
        tokens = tokenize(code)
        self.assertEqual(tokens[0].value, "def")
        self.assertEqual(tokens[1].value, "add")
        self.assertEqual(tokens[-2].value, "y")
        self.assertEqual(tokens[-1].value, "۝")

    def test_tokenize_basic_symbols(self):
        code = "﷽: print('Salam')"
        tokens = tokenize(code)
        expected = [
            Token(TokenType.ENTRY_POINT, "﷽"),
            Token(TokenType.COLON, ":"),
            Token(TokenType.IDENTIFIER, "print"),
            Token(TokenType.LEFT_PAREN, "("),
            Token(TokenType.STRING, "Salam"),
            Token(TokenType.RIGHT_PAREN, ")")
        ]
        self.assertEqual(tokens, expected)

    def test_tokenize_islamic_operators(self):
        code = "x ۝ y ۩ z"  # Using ۝ for assignment and ۩ for concatenation
        tokens = tokenize(code)
        expected = [
            Token(TokenType.IDENTIFIER, "x"),
            Token(TokenType.ASSIGN, "۝"),
            Token(TokenType.IDENTIFIER, "y"),
            Token(TokenType.CONCAT, "۩"),
            Token(TokenType.IDENTIFIER, "z")
        ]
        self.assertEqual(tokens, expected)

    def test_tokenize_numbers_and_strings(self):
        code = 'num ۝ 42.5 ۝ text ۝ "Bismillah"'
        tokens = tokenize(code)
        self.assertEqual(tokens[2].type, TokenType.NUMBER)
        self.assertEqual(tokens[2].value, "42.5")
        self.assertEqual(tokens[6].type, TokenType.STRING)
        self.assertEqual(tokens[6].value, "Bismillah")

if __name__ == '__main__':
    unittest.main()
