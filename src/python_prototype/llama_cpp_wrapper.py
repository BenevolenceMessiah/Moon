# llama_cpp_wrapper.py

import llama_cpp  # Hypothetical Python package for llama.cpp

def load_model(model_path):
    return llama_cpp.load_model(model_path)

def generate(model, prompt):
    return model.generate(prompt)
