import unittest
from src.python_prototype.parser import parse
from src.python_prototype.lexer import tokenize

class TestParser(unittest.TestCase):
    def test_parse_function_definition(self):
        code = """
        def test(x, y):
            return x + y
        """
        tokens = tokenize(code)
        ast = parse(tokens)
        self.assertEqual(ast.type, "Program")
        self.assertEqual(len(ast.children), 1)
        func_def = ast.children[0]
        self.assertEqual(func_def.type, "FunctionDef")
        self.assertEqual(func_def.name, "test")
        self.assertEqual(len(func_def.params), 2)

    def test_parse_islamic_entry_point(self):
        code = """
        ﷽:
            print("Hello")
        """
        tokens = tokenize(code)
        ast = parse(tokens)
        self.assertEqual(ast.type, "Program")
        self.assertEqual(ast.children[0].type, "EntryPoint")

if __name__ == '__main__':
    unittest.main()

