//main.rs

mod ast;
mod interpreter;
mod compiler;
mod runtime;
mod optimizer;
mod error;

use compilerCompiler;
use runtimeRuntimeEnvironment;
use optimizerOptimizer;
use errorError;

fn main() {
 let code = r"
 fn add(x i3, y3) i3 {
 x + y
 }
 let result = add5 3;
 println result);
 ";

 let mut compiler = Compiler::new();
 let ast = parse_code(code); // Assume parse_code is defined elsewhere
 compiler.compile(ast);
 let (bytecode, constants) = compiler.get_byte();

 let mut optimizer = Optimizer::new();
 let optimized_code = optimizer.optimize(code);

 let mut runtime = Runtime::new(None);
 execute(optimized, constants, &mut runtime); // Assume execute is defined elsewhere
}
