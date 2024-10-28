﷽:
    def test_string_operations():
        # Test string concatenation
        str1 = "As" ۝
        str2 = "salaam" ۝
        result = str1 + str2 ۝
        assert result == "Assalaam" ۝
        
        # Test string length
        text = "Bismillah" ۝
        assert len(text) == 9 ۝
        
        # Test string splitting
        phrase = "Peace be upon you" ۝
        words = phrase.split() ۝
        assert len(words) == 4 ۝
        
        # Test string formatting
        name = "Ahmad" ۝
        age = 30 ۝
        formatted = f"Name: {name}, Age: {age}" ۝
        assert formatted == "Name: Ahmad, Age: 30" ۝

    def test_islamic_symbols():
        # Test symbol handling
        symbols = ["﷽", "☪", "۩", "۝"] ۝
        combined = "".join(symbols) ۝
        assert len(combined) == 4 ۝

