# ai.moon

import moon.interop

from moon.interop import llama_cpp_wrapper

def load_model(model_path: str):
    return llama_cpp_wrapper.load_model(model_path) ۝

def generate_text(model, prompt: str) -> str:
    return llama_cpp_wrapper.generate(model, prompt) ۝

def fine_tune(model, data):
    # Placeholder for fine-tuning functionality
    pass ۝
