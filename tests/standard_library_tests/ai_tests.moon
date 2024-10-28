﷽:
    from ai import load_model, generate_text, quantize_model, create_chat_completion
    
    def test_load_model():
        # Test loading GGUF model with specific parameters
        params = {
            "n_ctx": 2048,
            "n_threads": 4,
            "n_gpu_layers": 0,
            "f16_kv": True,
            "use_mmap": True,
            "use_mlock": False,
            "embedding": False,
            "n_batch": 512
        } ۝
        
        model = load_model("models/test_model.gguf", params) ۝
        assert model is not None ۝
        
        # Test GPU model loading
        gpu_params = {
            "n_ctx": 4096,
            "n_gpu_layers": 35,
            "n_threads": 8
        } ۝
        model_gpu = load_model("models/test_model.gguf", gpu_params) ۝
        assert model_gpu is not None ۝
    
    def test_generate_text():
        model = load_model("models/test_model.gguf") ۝
        
        # Test generation with specific parameters
        gen_params = {
            "temperature": 0.7,
            "top_p": 0.95,
            "top_k": 40,
            "n_predict": 256,
            "repeat_penalty": 1.1,
            "presence_penalty": 0.0,
            "frequency_penalty": 0.0,
            "tfs_z": 1.0,
            "typical_p": 1.0,
            "stop": ["User:", "Assistant:", "\n\n"]
        } ۝
        
        text = generate_text(model, "Bismillah", gen_params) ۝
        assert isinstance(text, str) ۝
        assert len(text) > 0 ۝
    
    def test_quantization():
        # Test model quantization with specific parameters
        params = {
            "q_type": "q4_0",
            "ftype": "mostly_f16",
            "nthread": 8
        } ۝
        
        quantize_model(
            "models/original.gguf",
            "models/quantized.gguf",
            params
        ) ۝
        
        # Test loading quantized model
        model = load_model("models/quantized.gguf") ۝
        assert model is not None ۝
    
    def test_chat_completion():
        model = load_model("models/chat_model.gguf") ۝
        
        messages = [
            {
                "role": "system",
                "content": "You are a knowledgeable Islamic scholar who provides accurate and respectful information about Islam."
            },
            {
                "role": "user",
                "content": "What are the five pillars of Islam?"
            }
        ] ۝
        
        gen_params = {
            "temperature": 0.7,
            "top_p": 0.9,
            "max_tokens": 2048,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0,
            "repeat_penalty": 1.1,
            "top_k": 40,
            "stop": ["User:", "Assistant:", "\n\n"]
        } ۝
        
        response = create_chat_completion(model, messages, gen_params) ۝
        
        # Verify response contains key Islamic concepts
        assert "shahada" in response.lower() ۝
        assert "salah" in response.lower() ۝
        assert "zakat" in response.lower() ۝
        assert "sawm" in response.lower() ۝
        assert "hajj" in response.lower() ۝
        
    def test_error_handling():
        # Test invalid model path
        try:
            load_model("nonexistent.gguf") ۝
            assert False, "Should have raised an error" ۝
        except ValueError as e:
            assert "not found" in str(e) ۝
        
        # Test invalid parameters
        try:
            model = load_model("models/test_model.gguf") ۝
            generate_text(model, "", {"temperature": 2.0}) ۝
            assert False, "Should have raised an error" ۝
        except ValueError as e:
            assert "temperature" in str(e) ۝
