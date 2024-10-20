# parser.py

class Node:
    def __init__(self, type, value=None):
        self.type = type
        self.value = value
        self.children = []

def parse(tokens):
    position = 0

    def consume(expected_type):
        nonlocal position
        if tokens[position][0] == expected_type:
            token_value = tokens[position][1]
            position += 1
            return Node(expected_type, token_value)
        else:
            raise SyntaxError(f"Expected {expected_type}, got {tokens[position][0]} at position {position}")

    def parse_expression():
        node = parse_term()
        while tokens[position][0] == 'OPERATOR' and tokens[position][1] in ('+', '-'):
            operator = consume('OPERATOR')
            right = parse_term()
            new_node = Node('BINARY_OP', operator.value)
            new_node.children.append(node)
            new_node.children.append(right)
            node = new_node
        return node

    def parse_term():
        node = parse_factor()
        while tokens[position][0] == 'OPERATOR' and tokens[position][1] in ('*', '/', '%'):
            operator = consume('OPERATOR')
            right = parse_factor()
            new_node = Node('BINARY_OP', operator.value)
            new_node.children.append(node)
            new_node.children.append(right)
            node = new_node
        return node

    def parse_factor():
        token = tokens[position]
        if token[0] == 'NUMBER':
            consume('NUMBER')
            return Node('NUMBER', token[1])
        elif token[0] == 'IDENTIFIER':
            consume('IDENTIFIER')
            return Node('IDENTIFIER', token[1])
        elif token[0] == 'STRING':
            consume('STRING')
            return Node('STRING', token[1])
        elif token[0] == 'BISMILLAH':
            consume('BISMILLAH')
            return Node('BISMILLAH', '﷽')
        elif token[0] == 'LPAREN':
            consume('LPAREN')
            expr = parse_expression()
            consume('RPAREN')
            return expr
        else:
            raise SyntaxError(f"Unexpected token: {token} at position {position}")

    def parse_statement():
        token = tokens[position]
        if token[0] == 'IF':
            return parse_if_statement()
        elif token[0] == 'DEF':
            return parse_def_statement()
        elif token[0] == 'CLASS':
            return parse_class_statement()
        elif token[0] == 'FOR':
            return parse_for_statement()
        elif token[0] == 'WHILE':
            return parse_while_statement()
        elif token[0] == 'HELLO_WORLD':
            return parse_hello_world()
        else:
            return parse_expression_statement()

    def parse_if_statement():
        if_node = consume('IF')
        condition = parse_expression()
        consume('BLOCK_END')
        body = parse_block()
        if_node_node = Node('IF', 'if')
        if_node_node.children.append(condition)
        if_node_node.children.append(body)
        if tokens[position][0] == 'ELSE':
            consume('ELSE')
            consume('BLOCK_END')
            else_body = parse_block()
            else_node = Node('ELSE', 'else')
            else_node.children.append(else_body)
            if_node_node.children.append(else_node)
        return if_node_node

    def parse_def_statement():
        consume('DEF')
        name = consume('IDENTIFIER')
        consume('LPAREN')
        parameters = []
        while tokens[position][0] != 'RPAREN':
            param = consume('IDENTIFIER')
            parameters.append(param.value)
            if tokens[position][0] == 'COMMA':
                consume('COMMA')
        consume('RPAREN')
        consume('BLOCK_END')
        body = parse_block()
        def_node = Node('DEF', name.value)
        def_node.children.append(Node('PARAMS', parameters))
        def_node.children.append(body)
        return def_node

    def parse_class_statement():
        consume('CLASS')
        name = consume('IDENTIFIER')
        consume('BLOCK_END')
        body = parse_block()
        class_node = Node('CLASS', name.value)
        class_node.children.append(body)
        return class_node

    def parse_for_statement():
        consume('FOR')
        iterator = consume('IDENTIFIER')
        consume('ITERATE')
        iterable = parse_expression()
        consume('BLOCK_END')
        body = parse_block()
        for_node = Node('FOR', iterator.value)
        for_node.children.append(iterable)
        for_node.children.append(body)
        return for_node

    def parse_while_statement():
        consume('WHILE')
        condition = parse_expression()
        consume('BLOCK_END')
        body = parse_block()
        while_node = Node('WHILE', 'while')
        while_node.children.append(condition)
        while_node.children.append(body)
        return while_node

    def parse_hello_world():
        consume('HELLO_WORLD')
        print_stmt = consume('IDENTIFIER')  # Assuming 'print' function
        consume('LPAREN')
        message = consume('STRING')
        consume('RPAREN')
        consume('END_STATEMENT')
        print_node = Node('PRINT', message.value)
        hello_node = Node('HELLO_WORLD', 'hello_world')
        hello_node.children.append(print_node)
        return hello_node

    def parse_expression_statement():
        expr = parse_expression()
        consume('END_STATEMENT')
        return expr

    def parse_block():
        block = Node('BLOCK')
        while position < len(tokens) and tokens[position][0] not in ['ELSE', 'EOF', 'BLOCK_END']:
            stmt = parse_statement()
            block.children.append(stmt)
        return block

    def parse_program():
        program = Node('PROGRAM')
        while position < len(tokens) and tokens[position][0] != 'EOF':
            stmt = parse_statement()
            program.children.append(stmt)
        return program

    root = parse_program()
    consume('EOF')  # Ensure all tokens are consumed
    return root
