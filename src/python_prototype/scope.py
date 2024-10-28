from dataclasses import dataclass, field
from typing import Dict, Any, Optional

@dataclass
class Scope:
    variables: Dict[str, Any] = field(default_factory=dict)
    parent: Optional['Scope'] = None
    
    def get(self, name: str) -> Any:
        """Get a variable value from this scope or parent scopes"""
        if name in self.variables:
            return self.variables[name]
        if self.parent:
            return self.parent.get(name)
        raise NameError(f"Variable '{name}' is not defined")
    
    def set(self, name: str, value: Any) -> None:
        """Set a variable in the current scope"""
        self.variables[name] = value
    
    def define(self, name: str, value: Any) -> None:
        """Define a new variable in the current scope"""
        self.variables[name] = value

@dataclass
class Environment:
    current_scope: Scope = field(default_factory=Scope)
    
    def enter_scope(self) -> None:
        """Enter a new scope"""
        self.current_scope = Scope(parent=self.current_scope)
    
    def exit_scope(self) -> None:
        """Exit the current scope"""
        if self.current_scope.parent is None:
            raise RuntimeError("Cannot exit global scope")
        self.current_scope = self.current_scope.parent
    
    def get(self, name: str) -> Any:
        """Get a variable from the current scope"""
        return self.current_scope.get(name)
    
    def set(self, name: str, value: Any) -> None:
        """Set a variable in the current scope"""
        self.current_scope.set(name, value)
    
    def define(self, name: str, value: Any) -> None:
        """Define a new variable in the current scope"""
        self.current_scope.define(name, value)
