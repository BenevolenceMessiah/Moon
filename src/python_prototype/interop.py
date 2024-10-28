# interop.py

from typing import Any, Dict, Optional
from .llama_cpp_wrapper import load_model as llama_load, generate as llama_generate
from .error import raise_runtime_error

class LlamaCppWrapper:
    """Wrapper for llama.cpp functions to be used from Moon"""
    
    @staticmethod
    def load_model(model_path: str, params: Optional[Dict[str, Any]] = None) -> Any:
        """Load a GGUF model"""
        try:
            if params is None:
                params = {}
            return llama_load(model_path, params)
        except Exception as e:
            raise_runtime_error(f"Failed to load model: {e}")
    
    @staticmethod
    def generate(model: Any, prompt: str, params: Optional[Dict[str, Any]] = None) -> str:
        """Generate text using the model"""
        try:
            if params is None:
                params = {}
            return llama_generate(model, prompt, params)
        except Exception as e:
            raise_runtime_error(f"Text generation failed: {e}")
    
    @staticmethod
    def quantize(model_path: str, output_path: str, bits: int = 4) -> None:
        """Quantize a model using llama.cpp's quantize tool"""
        try:
            import subprocess
            result = subprocess.run([
                "llama-quantize",
                model_path,
                output_path,
                f"q{bits}_0"
            ], capture_output=True, text=True)
            
            if result.returncode != 0:
                raise_runtime_error(f"Quantization failed: {result.stderr}")
        except FileNotFoundError:
            raise_runtime_error(
                "llama.cpp quantize tool not found. Please install llama.cpp: "
                "https://github.com/ggerganov/llama.cpp#build"
            )
    
    @staticmethod
    def get_model_info(model_path: str) -> Dict[str, Any]:
        """Get information about a GGUF model"""
        try:
            import json
            import subprocess
            result = subprocess.run([
                "llama-info",
                model_path
            ], capture_output=True, text=True)
            
            if result.returncode != 0:
                raise_runtime_error(f"Failed to get model info: {result.stderr}")
                
            return json.loads(result.stdout)
        except FileNotFoundError:
            raise_runtime_error(
                "llama.cpp info tool not found. Please install llama.cpp: "
                "https://github.com/ggerganov/llama.cpp#build"
            )

# Create global instance
llama_cpp_wrapper = LlamaCppWrapper()
