// error_handling.rs

#[derive(Debug)]
pub enum Error {
 Syntax(String),
 Runtime(String),
}

impl std::fmt::Display for Error {
 fn fmt(&, f: &mut stdfmtFormatter) -> stdfmt::Result {
 match self {
 Error::Syntax(msg) => write!(f "Syntax Error: {}",msg),
::Runtime(msg) writef "Runtime: {}",),
 }
}

impl stderror::Error for Error {}

pub type Result<T> = stdresult::Result<T, Error>;

pub fn handle_error(err: Error) {
 match err {
 ErrorSyntax(msg) => eprintln!("Syntax Error: {}",msg),
Runtime(msg) eprintln!("Runtime: {}",),
}
}
