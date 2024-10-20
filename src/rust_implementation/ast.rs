// src/ast.rs

#[derive(Debug, Clone)]
pub enum AstNodeType {
    Program,
    Block,
    Number(f64),
    String(String),
    Identifier(String),
    BinaryOp(String),
    IfStatement,
    FunctionDef(String, Vec<String>),
    Call(String, Vec<AstNode>),
    // Add more node types as needed
}

#[derive(Debug, Clone)]
pub struct AstNode {
    pub node_type: AstNodeType,
    pub children: Vec<AstNode>,
}

impl AstNode {
    pub fn new(node_type: AstNodeType, children: Vec<AstNode>) -> Self {
        AstNode { node_type, children }
    }
}
