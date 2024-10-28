# vm.py

from enum import Enum, auto
from typing import List, Any, Dict, Optional

class OpCode(Enum):
    LOAD_CONST = auto()
    ADD = auto()
    RETURN_VALUE = auto()
    ROT_THREE = auto()
    MAKE_FUNCTION = auto()
    GET_ITER = auto()
    POP_JUMP_IF_FALSE = auto()
    STORE_NAME = auto()
    LOAD_NAME = auto()
    CALL_FUNCTION = auto()
    BINARY_ADD = auto()
    BINARY_SUBTRACT = auto()
    BINARY_MULTIPLY = auto()
    BINARY_DIVIDE = auto()
    COMPARE_OP = auto()
    # Add other opcodes as needed

class Frame:
    def __init__(self, code: List['Instruction'], globals_: Dict[str, Any]):
        self.code = code
        self.globals = globals_
        self.locals: Dict[str, Any] = {}
        self.stack: List[Any] = []
        self.ip = 0  # Instruction pointer

class Instruction:
    def __init__(self, opcode: OpCode, arg: Any = None):
        self.opcode = opcode
        self.arg = arg

class VirtualMachine:
    def __init__(self):
        self.frames: List[Frame] = []
        self.current_frame: Optional[Frame] = None
        self.globals: Dict[str, Any] = {}
        self.stack: List[Any] = []

    def push_frame(self, frame: Frame) -> None:
        self.frames.append(frame)
        self.current_frame = frame

    def pop_frame(self) -> Optional[Frame]:
        if self.frames:
            old_frame = self.frames.pop()
            self.current_frame = self.frames[-1] if self.frames else None
            return old_frame
        return None

    def execute(self, instructions: List[Instruction]) -> Any:
        frame = Frame(instructions, self.globals)
        self.push_frame(frame)

        while frame.ip < len(frame.code):
            instruction = frame.code[frame.ip]
            frame.ip += 1

            if instruction.opcode == OpCode.LOAD_CONST:
                frame.stack.append(instruction.arg)
            elif instruction.opcode == OpCode.STORE_NAME:
                frame.locals[instruction.arg] = frame.stack.pop()
            elif instruction.opcode == OpCode.LOAD_NAME:
                name = instruction.arg
                if name in frame.locals:
                    frame.stack.append(frame.locals[name])
                elif name in frame.globals:
                    frame.stack.append(frame.globals[name])
                else:
                    raise NameError(f"name '{name}' is not defined")
            elif instruction.opcode == OpCode.BINARY_ADD:
                right = frame.stack.pop()
                left = frame.stack.pop()
                frame.stack.append(left + right)
            elif instruction.opcode == OpCode.MAKE_FUNCTION:
                code = frame.stack.pop()
                frame.stack.append(lambda: self.execute(code))
            elif instruction.opcode == OpCode.GET_ITER:
                frame.stack.append(iter(frame.stack.pop()))
            elif instruction.opcode == OpCode.POP_JUMP_IF_FALSE:
                if not frame.stack.pop():
                    frame.ip = instruction.arg
            elif instruction.opcode == OpCode.RETURN_VALUE:
                return frame.stack.pop() if frame.stack else None

        self.pop_frame()
        return None
