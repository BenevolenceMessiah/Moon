# compiler.py

class Compiler:
    def __init__(self):
        self.bytecode = []
        self.constants = []
        self.symbol_table = {}

    def compile(self, node):
        if node.type == 'PROGRAM':
            for child in node.children:
                self.compile(child)
        elif node.type == 'DEF':
            self.symbol_table[node.value] = len(self.constants)
            self.constants.append(('DEF', node.value, node.children))
        elif node.type == 'BINARY_OP':
            self.compile(node.children[0])
            self.compile(node.children[1])
            self.bytecode.append(('BINARY_OP', node.value))
        elif node.type == 'IF':
            self.compile(node.children[0])
            jump_if_false = len(self.bytecode)
            self.bytecode.append(('JUMP_IF_FALSE', None))  # Placeholder
            self.compile(node.children[1])
            if len(node.children) > 2:
                jump = len(self.bytecode)
                self.bytecode.append(('JUMP', None))  # Placeholder
                self.bytecode[jump_if_false] = ('JUMP_IF_FALSE', len(self.bytecode))
                self.compile(node.children[2])
                self.bytecode[jump] = ('JUMP', len(self.bytecode))
            else:
                self.bytecode[jump_if_false] = ('JUMP_IF_FALSE', len(self.bytecode))
        elif node.type == 'PRINT':
            self.compile(node.children[0])
            self.bytecode.append(('PRINT',))
        # Additional compilation rules here...
        elif node.type == 'HELLO_WORLD':
            self.compile(node.children[0])
        else:
            raise NotImplementedError(f"Compilation for node type '{node.type}' not implemented.")

    def get_bytecode(self):
        return self.bytecode, self.constants
