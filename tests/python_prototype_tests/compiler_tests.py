import unittest
from src.python_prototype.compiler import compile_code
from src.python_prototype.vm import OpCode

class TestCompiler(unittest.TestCase):
    def test_compile_basic_program(self):
        code = """
        ﷽:
            x ۝ 42
            y ۝ x + 8
            print(y)
        """
        bytecode = compile_code(code)
        self.assertIsNotNone(bytecode)
        self.assertTrue(len(bytecode) > 0)

    def test_compile_function_definition(self):
        code = """
        def calculate_zakat(amount):
            return amount * 0.025
        
        ﷽:
            result ۝ calculate_zakat(1000)
            print(result)
        """
        bytecode = compile_code(code)
        self.assertTrue(any(instr.opcode == OpCode.MAKE_FUNCTION for instr in bytecode))

    def test_compile_loops(self):
        code = """
        ﷽:
            for i in range(5):
                if i > 2:
                    print(i)
        """
        bytecode = compile_code(code)
        self.assertTrue(any(instr.opcode == OpCode.GET_ITER for instr in bytecode))
        self.assertTrue(any(instr.opcode == OpCode.POP_JUMP_IF_FALSE for instr in bytecode))

    def test_compile_islamic_symbols(self):
        code = """
        ﷽:
            greeting ۝ "السَّلامُ عَلَيْكُمْ"
            print(greeting)
        """
        bytecode = compile_code(code)
        self.assertTrue(any(instr.opcode == OpCode.LOAD_CONST for instr in bytecode))

    def test_compile_error_handling(self):
        invalid_code = """
        ﷽:
            x ۝ 
        """
        with self.assertRaises(SyntaxError):
            compile_code(invalid_code)

if __name__ == '__main__':
    unittest.main()
