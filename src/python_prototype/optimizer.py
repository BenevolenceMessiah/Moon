from typing import List, Optional, Dict
from dataclasses import dataclass
from .ast import AstNode
from .symbols import OperatorPrecedence, BINARY_OPS

@dataclass
class OptimizationPass:
    """Base class for optimization passes"""
    name: str
    enabled: bool = True

    def optimize(self, node: AstNode) -> AstNode:
        raise NotImplementedError

class ConstantFolding(OptimizationPass):
    """Fold constant expressions at compile time"""
    def __init__(self):
        super().__init__("constant_folding")
    
    def optimize(self, node: AstNode) -> AstNode:
        if node.type == "BinaryOp" and all(child.type == "Number" for child in node.children):
            left = float(node.children[0].value)
            right = float(node.children[1].value)
            
            if node.value == "+":
                return AstNode("Number", str(left + right))
            elif node.value == "-":
                return AstNode("Number", str(left - right))
            elif node.value == "*":
                return AstNode("Number", str(left * right))
            elif node.value == "/" and right != 0:
                return AstNode("Number", str(left / right))
                
        return node

class DeadCodeElimination(OptimizationPass):
    """Eliminate unreachable code"""
    def __init__(self):
        super().__init__("dead_code_elimination")
    
    def optimize(self, node: AstNode) -> AstNode:
        if node.type == "If":
            condition = node.children[0]
            if condition.type == "Boolean":
                if condition.value == "true":
                    return node.children[1]  # Return then branch
                elif condition.value == "false" and len(node.children) > 2:
                    return node.children[2]  # Return else branch
                
        return node

class ExpressionSimplification(OptimizationPass):
    """Simplify expressions like x * 1, x + 0"""
    def __init__(self):
        super().__init__("expression_simplification")
    
    def optimize(self, node: AstNode) -> AstNode:
        if node.type == "BinaryOp":
            left, right = node.children
            
            # x * 1 = x
            if node.value == "*" and right.type == "Number" and right.value == "1":
                return left
                
            # x + 0 = x
            if node.value == "+" and right.type == "Number" and right.value == "0":
                return left
                
            # 0 + x = x
            if node.value == "+" and left.type == "Number" and left.value == "0":
                return right
                
        return node

class Optimizer:
    """Main optimizer class that runs all optimization passes"""
    def __init__(self):
        self.passes: List[OptimizationPass] = [
            ConstantFolding(),
            DeadCodeElimination(),
            ExpressionSimplification()
        ]
    
    def optimize(self, node: AstNode) -> AstNode:
        """Run all optimization passes on the AST"""
        modified = True
        while modified:
            modified = False
            for pass_ in self.passes:
                if pass_.enabled:
                    new_node = self._optimize_tree(node, pass_)
                    if new_node != node:
                        node = new_node
                        modified = True
        return node
    
    def _optimize_tree(self, node: AstNode, pass_: OptimizationPass) -> AstNode:
        """Recursively optimize a node and its children"""
        # First optimize children
        if node.children:
            node.children = [self._optimize_tree(child, pass_) for child in node.children]
        
        # Then optimize this node
        return pass_.optimize(node) 