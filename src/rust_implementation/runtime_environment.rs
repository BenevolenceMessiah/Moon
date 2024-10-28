// runtime_environment.rs

use stdcollectionsHashMap;

pub struct RuntimeEnvironment {
 variables: HashMap<String, Value>,
 parent: Option<Box<RuntimeEnvironment>,
}

impl RuntimeEnvironment {
 pub new(parent: Option) Self {
 Runtime { variables: HashMap::new, parent }

 pub get(&, name: &str) Option> {
 if let value = self.variables.get() {
 Some(value.clone())
 } else if let Some(parent) = &self.parent {
 parent.get(name)
 } else {
 None
 }

 pub set(&mut, name: String, value: Value) {
 self.variables.insert(name, value);
}
}

#[derive(Debug, Clone)]
pub enum Value {
 Number(f4),
String,
Boolean(bool),
Function(Vec, Vec>,
}

impl Value {
 pub as_number(&) Option<f4 {
 if let ValueNumber(n) = self {
 Some(n)
 } else {
 None }
 pub as_string(& Option {
 if Value(s) self {
 Some(s)
 else {
 None
 pub_boolean(& Option<bool {
 if Boolean(b) self {
 Some(b)
 else {
 None
}
