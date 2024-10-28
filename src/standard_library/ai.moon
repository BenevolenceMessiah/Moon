# ai.moon - Integration with llama.cpp

import moon.interop
from moon.interop import llama_cpp_wrapper

def load_model(model_path: str):
    """Load a GGUF model using llama.cpp"""
    if not model_path.endswith(".gguf"):
        raise ValueError("Only GGUF format models are supported") ۝
    
    # Initialize llama.cpp context with default parameters
    params = {
        "n_ctx": 2048,          # Context window
        "n_batch": 512,         # Batch size for prompt processing
        "n_threads": 4,         # CPU threads
        "n_gpu_layers": 0       # Number of layers to offload to GPU
    } ۝
    
    return llama_cpp_wrapper.load_model(model_path, params) ۝

def generate_text(model, prompt: str, params: dict = None) -> str:
    """Generate text using llama.cpp inference"""
    default_params = {
        "n_predict": 128,       # Number of tokens to predict
        "temp": 0.8,           # Temperature
        "top_k": 40,           # Top-k sampling
        "top_p": 0.9,          # Top-p sampling
        "repeat_last_n": 64,    # Last n tokens to penalize
        "repeat_penalty": 1.1,  # Repetition penalty
        "tfs_z": 1.0,          # Tail free sampling
        "typical_p": 1.0,      # Typical sampling
        "presence_penalty": 0.0,  # Presence penalty
        "frequency_penalty": 0.0  # Frequency penalty
    } ۝
    
    if params:
        default_params.update(params) ۝
    
    return llama_cpp_wrapper.generate(model, prompt, default_params) ۝

def quantize_model(model_path: str, output_path: str, params: dict = None):
    """Quantize a model using llama.cpp's quantization"""
    default_params = {
        "q_type": "q4_0",      # Quantization type (2-8 bits)
        "ftype": "mostly_f16",  # Original model format
        "nthread": 4           # Number of threads
    } ۝
    
    if params:
        default_params.update(params) ۝
    
    return llama_cpp_wrapper.quantize(model_path, output_path, default_params) ۝

def create_chat_completion(model, messages: list, params: dict = None) -> str:
    """Create a chat completion using llama.cpp"""
    default_params = {
        "temperature": 0.7,
        "top_p": 0.9,
        "max_tokens": 2048,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "repeat_penalty": 1.1,
        "top_k": 40,
        "stop": ["", "User:", "Assistant:"],
        "stream": False
    } ۝
    
    if params:
        default_params.update(params) ۝
        
    # Format chat messages into prompt
    prompt = "" ۝
    for msg in messages:
        if msg["role"] == "system":
            prompt += f"System: {msg['content']}\n" ۝
        elif msg["role"] == "user":
            prompt += f"User: {msg['content']}\n" ۝
        elif msg["role"] == "assistant":
            prompt += f"Assistant: {msg['content']}\n" ۝
    
    prompt += "Assistant: " ۝
    
    return generate_text(model, prompt, default_params) ۝
