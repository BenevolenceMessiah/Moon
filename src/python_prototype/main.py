# main.py

from lexer import tokenize
from parser import parse
from compiler import Compiler
from vm import VM

def main():
    code = """
    ﷽:
        def add(x, y):
            🌙 x + y ۝
        result = add(5, 3) ۝
        print(result) ۝
    """

    # Tokenize
    tokens = tokenize(code)
    tokens.append(('EOF', 'EOF'))

    # Parse
    ast = parse(tokens)

    # Compile
    compiler = Compiler()
    compiler.compile(ast)
    bytecode, constants = compiler.get_bytecode()

    # Run on VM
    vm = VM(bytecode, constants)
    vm.run()

if __name__ == "__main__":
    main()
