from dataclasses import dataclass, field
from typing import Dict, Any, List, Optional
from .scope import Scope

@dataclass
class Frame:
    name: str
    scope: Scope
    return_value: Any = None
    parent: Optional['Frame'] = None
    
    def __post_init__(self):
        if self.parent is None:
            self.depth = 0
        else:
            self.depth = self.parent.depth + 1

@dataclass
class CallStack:
    frames: List[Frame] = field(default_factory=list)
    max_depth: int = 1000  # Maximum call stack depth
    
    def push(self, frame: Frame) -> None:
        """Push a new frame onto the call stack"""
        if len(self.frames) >= self.max_depth:
            raise RecursionError("Maximum recursion depth exceeded")
        
        if self.frames:
            frame.parent = self.frames[-1]
        self.frames.append(frame)
    
    def pop(self) -> Frame:
        """Pop the top frame from the call stack"""
        if not self.frames:
            raise RuntimeError("Cannot pop from empty call stack")
        return self.frames.pop()
    
    def peek(self) -> Optional[Frame]:
        """Get the current frame without removing it"""
        return self.frames[-1] if self.frames else None
    
    def get_variable(self, name: str) -> Any:
        """Get a variable from the current scope chain"""
        if not self.frames:
            raise RuntimeError("No active frame")
        
        frame = self.frames[-1]
        while frame:
            try:
                return frame.scope.get(name)
            except NameError:
                frame = frame.parent
        
        raise NameError(f"Variable '{name}' is not defined")
    
    def set_variable(self, name: str, value: Any) -> None:
        """Set a variable in the current scope"""
        if not self.frames:
            raise RuntimeError("No active frame")
        self.frames[-1].scope.set(name, value)
