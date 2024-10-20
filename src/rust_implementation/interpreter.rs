// src/interpreter.rs

use crate::ast::{AstNode, AstNodeType};
use std::collections::HashMap;

pub struct Environment {
    pub variables: HashMap<String, Value>,
}

#[derive(Debug, Clone)]
pub enum Value {
    Number(f64),
    String(String),
    Function(Vec<String>, AstNode),
    None,
}

impl Environment {
    pub fn new() -> Self {
        Environment {
            variables: HashMap::new(),
        }
    }

    pub fn get(&self, name: &str) -> Option<Value> {
        self.variables.get(name).cloned()
    }

    pub fn set(&mut self, name: String, value: Value) {
        self.variables.insert(name, value);
    }
}

pub fn interpret(node: &AstNode, env: &mut Environment) -> Result<Value, String> {
    match &node.node_type {
        AstNodeType::Program | AstNodeType::Block => {
            let mut last_value = Value::None;
            for child in &node.children {
                last_value = interpret(child, env)?;
            }
            Ok(last_value)
        }
        AstNodeType::Number(n) => Ok(Value::Number(*n)),
        AstNodeType::String(s) => Ok(Value::String(s.clone())),
        AstNodeType::Identifier(name) => {
            env.get(name).ok_or_else(|| format!("Undefined variable: {}", name))
        }
        AstNodeType::BinaryOp(op) => {
            let left = interpret(&node.children[0], env)?;
            let right = interpret(&node.children[1], env)?;
            match (left, right) {
                (Value::Number(l), Value::Number(r)) => match op.as_str() {
                    "+" => Ok(Value::Number(l + r)),
                    "-" => Ok(Value::Number(l - r)),
                    "*" => Ok(Value::Number(l * r)),
                    "/" => Ok(Value::Number(l / r)),
                    "♡" => Ok(Value::Number(if l == r { 1.0 } else { 0.0 })),
                    _ => Err(format!("Unsupported operator: {}", op)),
                },
                (Value::String(l), Value::String(r)) if op == "+" => {
                    Ok(Value::String(l + &r))
                }
                _ => Err("Type error in binary operation".to_string()),
            }
        }
        AstNodeType::IfStatement => {
            let condition = interpret(&node.children[0], env)?;
            match condition {
                Value::Number(n) if n != 0.0 => interpret(&node.children[1], env),
                _ => {
                    if node.children.len() > 2 {
                        interpret(&node.children[2], env)
                    } else {
                        Ok(Value::None)
                    }
                }
            }
        }
        AstNodeType::FunctionDef(name, params) => {
            let body = node.children[0].clone();
            env.set(
                name.clone(),
                Value::Function(params.clone(), body),
            );
            Ok(Value::None)
        }
        AstNodeType::Call(name, args) => {
            if let Some(Value::Function(params, body)) = env.get(name) {
                if params.len() != args.len() {
                    return Err(format!(
                        "Function {} expects {} arguments, got {}",
                        name,
                        params.len(),
                        args.len()
                    ));
                }
                let mut local_env = Environment::new();
                for (param, arg) in params.iter().zip(args) {
                    let value = interpret(arg, env)?;
                    local_env.set(param.clone(), value);
                }
                interpret(&body, &mut local_env)
            } else {
                Err(format!("Undefined function: {}", name))
            }
        }
        _ => Err(format!("Unsupported AST node: {:?}", node.node_type)),
    }
}
