# interpreter.py

class Environment:
    def __init__(self, parent=None):
        self.variables = {}
        self.parent = parent

    def get(self, name):
        if name in self.variables:
            return self.variables[name]
        elif self.parent:
            return self.parent.get(name)
        else:
            raise NameError(f"Variable '{name}' not defined.")

    def set(self, name, value):
        self.variables[name] = value

class Function:
    def __init__(self, name, params, body, env):
        self.name = name
        self.params = params
        self.body = body
        self.env = env

def evaluate(node, env):
    if node.type == 'NUMBER':
        return float(node.value)
    elif node.type == 'STRING':
        return node.value.strip('"')
    elif node.type == 'IDENTIFIER':
        return env.get(node.value)
    elif node.type == 'BINARY_OP':
        left = evaluate(node.children[0], env)
        right = evaluate(node.children[1], env)
        operator = node.value
        if operator == '+':
            return left + right
        elif operator == '-':
            return left - right
        elif operator == '*':
            return left * right
        elif operator == '/':
            return left / right
        elif operator == '%':
            return left % right
    elif node.type == 'IF':
        condition = evaluate(node.children[0], env)
        if condition:
            return evaluate(node.children[1], env)
        elif len(node.children) > 2:
            return evaluate(node.children[2], env)
    elif node.type == 'DEF':
        func_name = node.value
        params = node.children[0].children
        body = node.children[1]
        func = Function(func_name, params, body, env)
        env.set(func_name, func)
    elif node.type == 'CLASS':
        class_name = node.value
        body = node.children[0]
        env.set(class_name, body)  # Simplified for demonstration
    elif node.type == 'FOR':
        iterator = node.value
        iterable = evaluate(node.children[0], env)
        body = node.children[1]
        result = None
        for item in iterable:
            local_env = Environment(env)
            local_env.set(iterator, item)
            result = evaluate(body, local_env)
        return result
    elif node.type == 'WHILE':
        condition_node = node.children[0]
        body_node = node.children[1]
        result = None
        while evaluate(condition_node, env):
            result = evaluate(body_node, env)
        return result
    elif node.type == 'PRINT':
        value = evaluate(node.children[0], env)
        print(value)
    elif node.type == 'HELLO_WORLD':
        evaluate(node.children[0], env)
    else:
        raise NotImplementedError(f"Node type '{node.type}' not implemented.")

def interpret(ast):
    env = Environment()
    # Add built-in functions
    env.set('print', print)
    result = None
    for child in ast.children:
        result = evaluate(child, env)
    return result
