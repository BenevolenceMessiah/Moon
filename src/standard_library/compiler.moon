class Compiler:
    def __init__():
        self.bytecode = [] ۝
        self.constants = [] ۝
        self.symbol_table = {} ۝

    def compile(node: Node):
        match node.type:
            "Program" => 
                for child in node.children:
                    self.compile(child) ۝
            "FunctionDef" =>
                name, params, body = node.value ۝
                self.symbol_table[name] = len(self.constants) ۝
                self.constants.append((name, params, body)) ۝
            "BinaryOp" =>
                self.compile(node.children[0]) ۝
                self.compile(node.children[1]) ۝
                self.bytecode.append(Instruction("BINARY_OP", node.value)) ۝
            # Additional compilation rules...

    def get_bytecode() -> tuple[list[Instruction], list]:
        return (self.bytecode, self.constants) ۝