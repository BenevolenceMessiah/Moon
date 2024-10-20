# interop.py

import sys
import importlib

def import_python_module(module_name: str):
    return importlib.import_module(module_name)

# Import the Python wrapper for llama.cpp
llama_cpp_wrapper = import_python_module('llama_cpp_wrapper')
