from typing import Dict, Any, List, Optional
from pathlib import Path
import ctypes
from ctypes import c_int, c_float, c_char_p, POINTER, Structure, c_void_p
from .error import raise_runtime_error

class LLaMAContext(Structure):
    """Wrapper for llama_context"""
    _fields_ = [("ctx", c_void_p)]

class LLaMAModel(Structure):
    """Wrapper for llama_model"""
    _fields_ = [("model", c_void_p)]

class AIModel:
    """Interface with llama.cpp models"""
    def __init__(self, model_path: str):
        self.lib = self._load_llama_library()
        self.model_path = Path(model_path)
        self.model: Optional[LLaMAModel] = None
        self.ctx: Optional[LLaMAContext] = None
        
        if not self.model_path.exists():
            raise_runtime_error(f"Model file not found: {model_path}")
        
        self._initialize()
    
    def _load_llama_library(self) -> ctypes.CDLL:
        """Load the llama.cpp shared library"""
        try:
            if sys.platform == "linux":
                return ctypes.CDLL("libllama.so")
            elif sys.platform == "darwin":
                return ctypes.CDLL("libllama.dylib")
            elif sys.platform == "win32":
                return ctypes.CDLL("llama.dll")
        except OSError as e:
            raise_runtime_error(f"Failed to load llama.cpp library: {e}")
    
    def _initialize(self) -> None:
        """Initialize the model and context"""
        # Set function signatures
        self.lib.llama_load_model_from_file.argtypes = [c_char_p]
        self.lib.llama_load_model_from_file.restype = POINTER(LLaMAModel)
        
        self.lib.llama_new_context_with_model.argtypes = [POINTER(LLaMAModel)]
        self.lib.llama_new_context_with_model.restype = POINTER(LLaMAContext)
        
        # Load model
        model_path_bytes = self.model_path.as_posix().encode('utf-8')
        self.model = self.lib.llama_load_model_from_file(model_path_bytes)
        if not self.model:
            raise_runtime_error("Failed to load model")
            
        # Create context
        self.ctx = self.lib.llama_new_context_with_model(self.model)
        if not self.ctx:
            raise_runtime_error("Failed to create context")
    
    def generate(self, prompt: str, max_tokens: int = 100) -> str:
        """Generate text using the model"""
        if not self.ctx:
            raise_runtime_error("Model not initialized")
            
        # Prepare input
        prompt_bytes = prompt.encode('utf-8')
        output_buffer = ctypes.create_string_buffer(4096)
        
        # Call generation function
        self.lib.llama_generate.argtypes = [
            POINTER(LLaMAContext),
            c_char_p,  # input prompt
            c_int,     # max tokens
            c_char_p,  # output buffer
            c_int      # output buffer size
        ]
        
        result = self.lib.llama_generate(
            self.ctx,
            prompt_bytes,
            max_tokens,
            output_buffer,
            len(output_buffer)
        )
        
        if result < 0:
            raise_runtime_error("Text generation failed")
            
        return output_buffer.value.decode('utf-8')
    
    def __del__(self):
        """Cleanup resources"""
        if self.ctx:
            self.lib.llama_free_context(self.ctx)
        if self.model:
            self.lib.llama_free_model(self.model)

class TextClassifier:
    """Islamic text classification using llama.cpp"""
    def __init__(self, model_path: str = "models/classifier.gguf"):
        self.model = AIModel(model_path)
    
    def classify(self, text: str) -> Dict[str, Any]:
        prompt = f"""Analyze the following text and determine its language and script type:
Text: {text}
Analysis:"""
        
        result = self.model.generate(prompt)
        # Parse the generated result into structured data
        # This is a simplified implementation
        return {
            "language": "Arabic" if any('\u0600' <= c <= '\u06FF' for c in text) else "Unknown",
            "script": "Arabic" if any('\u0600' <= c <= '\u06FF' for c in text) else "Unknown"
        }
    
    def analyze_sentiment(self, text: str) -> Dict[str, Any]:
        prompt = f"""Analyze the sentiment of this text:
Text: {text}
Sentiment:"""
        
        result = self.model.generate(prompt)
        return {
            "is_positive": "positive" in result.lower(),
            "sentiment": result.strip()
        }

class PatternRecognizer:
    """Islamic geometric pattern recognition"""
    def __init__(self, model_path: str = "models/pattern.gguf"):
        self.model = AIModel(model_path)
    
    def extract_features(self, image_path: str) -> List[str]:
        # This would normally use computer vision
        # For now, we'll use LLM to describe patterns
        prompt = f"""Describe the geometric patterns in this Islamic art:
Image: {image_path}
Features:"""
        
        result = self.model.generate(prompt)
        return [feature.strip() for feature in result.split(',')]
    
    def is_islamic_pattern(self, features: List[str]) -> bool:
        prompt = f"""Are these features typical of Islamic geometric patterns?
Features: {', '.join(features)}
Analysis:"""
        
        result = self.model.generate(prompt)
        return "yes" in result.lower() 