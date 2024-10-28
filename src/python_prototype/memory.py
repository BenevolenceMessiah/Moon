from dataclasses import dataclass, field
from typing import Dict, Any, Optional, Set
from .error import raise_runtime_error

@dataclass
class MemoryBlock:
    value: Any
    size: int
    references: int = 0
    
    def increment_ref(self) -> None:
        self.references += 1
    
    def decrement_ref(self) -> None:
        self.references -= 1

class MemoryManager:
    def __init__(self, max_memory: int = 1024 * 1024):  # 1MB default
        self.max_memory = max_memory
        self.used_memory = 0
        self.blocks: Dict[int, MemoryBlock] = {}
        self.next_address = 1
        self.gc_threshold = 0.8  # Run GC when 80% memory is used
    
    def allocate(self, value: Any, size: int) -> int:
        """Allocate memory for a value and return its address"""
        if self.used_memory + size > self.max_memory:
            self.garbage_collect()
            if self.used_memory + size > self.max_memory:
                raise_runtime_error("Out of memory")
        
        address = self.next_address
        self.blocks[address] = MemoryBlock(value, size)
        self.used_memory += size
        self.next_address += 1
        return address
    
    def free(self, address: int) -> None:
        """Free memory at given address"""
        if address in self.blocks:
            block = self.blocks[address]
            self.used_memory -= block.size
            del self.blocks[address]
    
    def get(self, address: int) -> Any:
        """Get value at memory address"""
        if address not in self.blocks:
            raise_runtime_error(f"Invalid memory access at address {address}")
        return self.blocks[address].value
    
    def mark_and_sweep(self) -> None:
        """Perform mark and sweep garbage collection"""
        marked: Set[int] = set()
        
        def mark(address: int) -> None:
            if address not in marked:
                marked.add(address)
                block = self.blocks[address]
                # Mark any references in the value
                if isinstance(block.value, (list, dict, set)):
                    for item in block.value:
                        if isinstance(item, int) and item in self.blocks:
                            mark(item)
        
        # Mark phase
        for address in self.blocks:
            if self.blocks[address].references > 0:
                mark(address)
        
        # Sweep phase
        addresses = list(self.blocks.keys())
        for address in addresses:
            if address not in marked:
                self.free(address)
    
    def garbage_collect(self) -> None:
        """Run garbage collection if needed"""
        if self.used_memory / self.max_memory > self.gc_threshold:
            self.mark_and_sweep() 