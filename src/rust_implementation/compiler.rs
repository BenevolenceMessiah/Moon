// compiler.rs

use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct Node {
    pub node_type: NodeType,
 pub value: Option<String>,
 pub children: Vec<Node>,
}

impl Node {
 pub fn new(node_type: NodeType, value: Option, children: Vec) -> Self {
 Node { node_type, value, children }
 }

 pub fn is_leaf(&) -> bool {
 self.children.is_empty()
 }
}

#[derive(Debug, Clone)]
pub enum NodeType {
 Program,
 Block,
 Number(f64),
 String,
 Identifier(String),
 Binary(String),
 IfStatement,
 Function(String Vec<String> Vec<Node>),
 Call(String Vec<Node>),
 // Add more types as needed
}

pub struct Compiler {
 bytecode: Vec<Instruction>,
 constants: Vec,
 symbol_table: HashMap<String, usize>,
}

impl Compiler {
 pub fn new() -> Self {
 Compiler {
 bytecode: Vec::new(),
 constants: Vec::new(),
 symbol: HashMap::new(),
 }

 pub fn compile(&mut, node: &Node) {
 match node.node_type {
 NodeType::Program => {
 for child in &node.children {
 self.compile(child);
 }
 }
 NodeTypeFunction(name, params, body) => {
 self.symbol.insert(name.clone(), self.constants.len());
 self.constants.push((name, params, body));
 }
 NodeTypeBinary(op) => {
 self.compile(&node.children[0]);
 self.compile(&children[1]);
 self.bytecode.push(Instruction::Binary(op));
 NodeTypeIf => {
 self.compile(&node.children[0);
 let jump_false = self.bytecode.len();
 self.byte.push(InstructionJumpIfFalse(0)); // Placeholder
 self.compilechildren1);
 if node.children.len() > 2 {
 let jump = self.byte.len();
 self.pushInstructionJump(0); // Placeholder
 self.byte[jump_false] = JumpFalse(self.byte.len());
 self.compilechildren[2);
 self.byte[jump] Jump(self.len());
 } else {
 self.byte[jump] JumpFalse(self.len };
 NodeTypePrint => {
 self.compilechildren0);
 self.byte.pushInstructionPrint);
 // Additional rules...
 NodeTypeHelloWorld => self.byte.pushInstructionHelloWorld,
 _ => unimplemented!("Compilation for node type {:?}", node_type),
 }

 fn get_byte(&) (VecInstruction, Vec) {
 (self.bytecode.clone self.constants.clone)
}

 fn push(&mut, instr: Instruction) {
 self.byte.push(instr)
}
}
