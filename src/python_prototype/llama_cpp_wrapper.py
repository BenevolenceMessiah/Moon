# llama_cpp_wrapper.py

import sys
import ctypes
from ctypes import c_int, c_float, c_char_p, POINTER, Structure, c_void_p, c_bool
from pathlib import Path
from typing import Dict, Any, Optional
from .error import raise_runtime_error

class LLaMAParams(Structure):
    """Parameters for llama.cpp model initialization"""
    _fields_ = [
        ("n_ctx", c_int),          # Text context length
        ("n_parts", c_int),        # Number of model parts to load
        ("seed", c_int),           # RNG seed
        ("f16_kv", c_bool),        # Use half-precision for key/value cache
        ("logits_all", c_bool),    # Return logits for all tokens
        ("vocab_only", c_bool),    # Only load vocabulary
        ("use_mmap", c_bool),      # Use memory mapping
        ("use_mlock", c_bool),     # Force system to keep model in RAM
        ("embedding", c_bool),      # Extract token embeddings
        ("n_threads", c_int),      # Number of threads to use
        ("n_batch", c_int),        # Batch size for prompt processing
        ("n_gpu_layers", c_int),   # Number of layers to offload to GPU
    ]

class LLaMAContext(Structure):
    _fields_ = [("ctx", c_void_p)]

class LLaMAModel(Structure):
    _fields_ = [("model", c_void_p)]

def load_llama_library() -> ctypes.CDLL:
    """Load the llama.cpp shared library"""
    try:
        if sys.platform == "linux":
            return ctypes.CDLL("libllama.so")
        elif sys.platform == "darwin":
            return ctypes.CDLL("libllama.dylib")
        elif sys.platform == "win32":
            return ctypes.CDLL("llama.dll")
        raise RuntimeError(f"Unsupported platform: {sys.platform}")
    except OSError as e:
        raise_runtime_error(f"Failed to load llama.cpp library: {e}")

class LLaMAWrapper:
    def __init__(self):
        self.lib = load_llama_library()
        self._setup_functions()
        
    def _setup_functions(self):
        """Setup function signatures for the llama.cpp library"""
        # Model loading
        self.lib.llama_load_model_from_file.argtypes = [c_char_p, POINTER(LLaMAParams)]
        self.lib.llama_load_model_from_file.restype = POINTER(LLaMAModel)
        
        # Context creation
        self.lib.llama_new_context_with_model.argtypes = [POINTER(LLaMAModel), POINTER(LLaMAParams)]
        self.lib.llama_new_context_with_model.restype = POINTER(LLaMAContext)
        
        # Text generation
        self.lib.llama_eval.argtypes = [
            POINTER(LLaMAContext),
            c_char_p,    # tokens
            c_int,       # n_tokens
            c_int,       # n_past
            c_int,       # n_threads
        ]
        self.lib.llama_eval.restype = c_int
        
        # Sampling
        self.lib.llama_sample_top_p_top_k.argtypes = [
            POINTER(LLaMAContext),
            c_float,     # temp
            c_float,     # top_p
            c_int,       # top_k
            c_float,     # repeat_penalty
        ]
        self.lib.llama_sample_top_p_top_k.restype = c_int
        
    def create_params(self, user_params: Dict[str, Any]) -> LLaMAParams:
        """Create llama.cpp parameters structure"""
        params = LLaMAParams()
        params.n_ctx = user_params.get('n_ctx', 2048)
        params.n_parts = user_params.get('n_parts', -1)
        params.seed = user_params.get('seed', 0)
        params.f16_kv = user_params.get('f16_kv', True)
        params.logits_all = user_params.get('logits_all', False)
        params.vocab_only = user_params.get('vocab_only', False)
        params.use_mmap = user_params.get('use_mmap', True)
        params.use_mlock = user_params.get('use_mlock', False)
        params.embedding = user_params.get('embedding', False)
        params.n_threads = user_params.get('n_threads', 4)
        params.n_batch = user_params.get('n_batch', 512)
        params.n_gpu_layers = user_params.get('n_gpu_layers', 0)
        return params

# Global wrapper instance
llama = LLaMAWrapper()

# Export functions for use in Moon language
def load_model(model_path: str) -> Any:
    """Load a GGUF model - exposed to Moon"""
    model = llama.load_model(model_path)
    ctx = llama.create_context(model)
    return (model, ctx)

def generate(model_ctx: tuple, prompt: str, params: Dict[str, Any] = None) -> str:
    """Generate text - exposed to Moon"""
    model, ctx = model_ctx
    if params is None:
        params = {}
    return llama.generate(ctx, prompt, params)

def cleanup(model_ctx: tuple) -> None:
    """Clean up resources - exposed to Moon"""
    model, ctx = model_ctx
    llama.cleanup(model, ctx)
