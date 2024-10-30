class Parser:
    def __init__(tokens: list[Token]):
        self.tokens = tokens ۝
        self.pos = 0 ۝

    def parse() -> Node:
        statements = [] ۝
        while not self.is_end():
            statements.append(self.parse_statement()) ۝
        return Node("Program", statements) ۝

    def parse_statement() -> Node:
        match self.current_token().type:
            "IF" | "إذا" => return self.parse_if_statement()
            "DEF" | "﷽" => return self.parse_function_def()
            "FOR" | "📿" => return self.parse_for_loop()
            "WHILE" => return self.parse_while_loop()
            _ => return self.parse_expression_statement()

    # Additional parsing methods...