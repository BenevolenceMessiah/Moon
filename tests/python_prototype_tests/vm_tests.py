import unittest
from src.python_prototype.vm import VirtualMachine, Instruction, OpCode
from src.python_prototype.compiler import compile_code

class TestVirtualMachine(unittest.TestCase):
    def setUp(self):
        self.vm = VirtualMachine()

    def test_basic_arithmetic(self):
        # Test basic arithmetic operations
        instructions = [
            Instruction(OpCode.LOAD_CONST, 5),
            Instruction(OpCode.LOAD_CONST, 3),
            Instruction(OpCode.ADD),
            Instruction(OpCode.RETURN_VALUE)
        ]
        result = self.vm.execute(instructions)
        self.assertEqual(result, 8)

    def test_variable_operations(self):
        # Test variable storage and retrieval
        code = """
        ﷽:
            x ۝ 42
            y ۝ x + 8
            return y
        """
        bytecode = compile_code(code)
        result = self.vm.execute(bytecode)
        self.assertEqual(result, 50)

    def test_function_calls(self):
        # Test function definition and calling
        code = """
        def greet(name):
            return f"Salam, {name}"
        
        ﷽:
            return greet("Ahmad")
        """
        bytecode = compile_code(code)
        result = self.vm.execute(bytecode)
        self.assertEqual(result, "Salam, Ahmad")

    def test_islamic_operators(self):
        # Test special Islamic operators
        code = """
        ﷽:
            text1 ۝ "Bismillah"
            text2 ۝ "Alhamdulillah"
            return text1 ۩ text2  # Islamic concatenation operator
        """
        bytecode = compile_code(code)
        result = self.vm.execute(bytecode)
        self.assertEqual(result, "BismillahAlhamdulillah")

    def test_stack_operations(self):
        # Test stack manipulation
        instructions = [
            Instruction(OpCode.LOAD_CONST, 1),
            Instruction(OpCode.LOAD_CONST, 2),
            Instruction(OpCode.LOAD_CONST, 3),
            Instruction(OpCode.ROT_THREE),
            Instruction(OpCode.RETURN_VALUE)
        ]
        result = self.vm.execute(instructions)
        self.assertEqual(result, 1)
        self.assertEqual(len(self.vm.stack), 2)

if __name__ == '__main__':
    unittest.main()

