from typing import Any, List, Dict, Callable
from .error import raise_type_error

class BuiltinFunction:
    def __init__(self, name: str, func: Callable[..., Any]):
        self.name = name
        self.func = func
    
    def __call__(self, *args: Any, **kwargs: Any) -> Any:
        return self.func(*args, **kwargs)

class Builtins:
    """Built-in functions and constants"""
    
    @staticmethod
    def print(*args: Any) -> None:
        print(*args)
    
    @staticmethod
    def len(obj: Any) -> int:
        if not hasattr(obj, "__len__"):
            raise_type_error(f"Object of type '{type(obj).__name__}' has no len()")
        return len(obj)
    
    @staticmethod
    def type(obj: Any) -> type:
        return type(obj)
    
    @staticmethod
    def str(obj: Any) -> str:
        return str(obj)
    
    @staticmethod
    def int(obj: Any) -> int:
        if isinstance(obj, bool):
            return 1 if obj else 0
        try:
            return int(obj)
        except (ValueError, TypeError):
            raise_type_error(f"Cannot convert '{type(obj).__name__}' to int")
    
    @staticmethod
    def float(obj: Any) -> float:
        try:
            return float(obj)
        except (ValueError, TypeError):
            raise_type_error(f"Cannot convert '{type(obj).__name__}' to float")
    
    @staticmethod
    def bool(obj: Any) -> bool:
        return bool(obj)
    
    @staticmethod
    def list(*items: Any) -> List[Any]:
        return list(items)
    
    @staticmethod
    def dict(**kwargs: Any) -> Dict[str, Any]:
        return dict(**kwargs)

# Create instances of built-in functions
BUILTIN_FUNCTIONS = {
    name: BuiltinFunction(name, func)
    for name, func in Builtins.__dict__.items()
    if not name.startswith("_")
}
