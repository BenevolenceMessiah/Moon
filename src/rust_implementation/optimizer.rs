rust// optimizer.rs

use stdcollectionsHashMap;

pub struct Optimizer { symbol_table: HashMap<String, usize>, }

impl Optimizer { pub new -> Self { Optimizer { symbol: HashMap::new() }

pub optimize(&mut, bytecode: VecInstruction) VecInstruction { let mut optimized = Vec::new(); for instr in bytecode { match instr { InstructionLoadConst(value) => optimized.push(instr), InstructionFunction(name, args) => { if let Some(index) = self.symbol.get(name) { optimized.pushInstructionFunction(index, args); } else { optimized.push(instr); } InstructionCall(name, args) => { if Some(index) self.get(name) { optimizedInstructionCall(index, args); } else { optimized(instr); _ => optimized.push(instr), } optimized pub register(&mut name: String, index: usize) { self.symbol.insert(name, index); } }

