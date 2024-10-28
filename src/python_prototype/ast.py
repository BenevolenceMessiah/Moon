from dataclasses import dataclass, field
from typing import List, Optional, Any

@dataclass
class AstNode:
    type: str
    value: Optional[Any] = None
    children: List['AstNode'] = field(default_factory=list)
    params: List[str] = field(default_factory=list)
    name: Optional[str] = field(default=None)

    def __post_init__(self):
        if self.children is None:
            self.children = []
        if self.params is None:
            self.params = []
