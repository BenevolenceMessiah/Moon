# vm.py

class VM:
    def __init__(self, bytecode, constants):
        self.bytecode = bytecode
        self.constants = constants
        self.stack = []
        self.pc = 0  # Program counter
        self.symbol_table = {}

    def run(self):
        while self.pc < len(self.bytecode):
            instruction = self.bytecode[self.pc]
            op = instruction[0]
            if op == 'BINARY_OP':
                operator = instruction[1]
                right = self.stack.pop()
                left = self.stack.pop()
                if operator == '+':
                    self.stack.append(left + right)
                elif operator == '-':
                    self.stack.append(left - right)
                elif operator == '*':
                    self.stack.append(left * right)
                elif operator == '/':
                    self.stack.append(left / right)
                # Add more operators as needed
            elif op == 'JUMP_IF_FALSE':
                condition = self.stack.pop()
                if not condition:
                    self.pc = instruction[1]
                    continue
            elif op == 'JUMP':
                self.pc = instruction[1]
                continue
            elif op == 'PRINT':
                value = self.stack.pop()
                print(value)
            elif op == 'DEF':
                _, name, body = self.constants[instruction[1]]
                self.symbol_table[name] = body  # Simplified
            # Handle more instructions...
            self.pc += 1

    def set_symbol(self, name, value):
        self.symbol_table[name] = value
