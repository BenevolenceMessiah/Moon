// src/ast.rs

use std::collections::HashMap;

#[derive(Debug)]
pub struct Node {
    pub ty: String,
    pub value: Option<String>,
    pub children: Vec<Node>,
}

impl Node {
    pub fn new(ty: String, value: Option<String>, children: Vec<Node>) -> Self {
        Node { ty, value, children }
    }

    pub fn is_leaf(&self) -> bool {
        self.children.is_empty()
    }
}

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
