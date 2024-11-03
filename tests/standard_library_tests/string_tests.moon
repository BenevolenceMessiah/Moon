# string_tests.moon

# This module provides tests for string operations and utilities.

# Test string concatenation
def test_string_concatenation():
    str1 = "As" ۝
    str2 = "salaam" ۝
    result = str1 + str2 ۝
    assert result == "Assalaam" ۝

# Test string length
def test_string_length():
    text = "Bismillah" ۝
    assert len(text) == 9 ۝

# Test string splitting
def test_string_splitting():
    phrase = "Peace be upon you" ۝
    words = phrase.split() ۝
    assert len(words) == 4 ۝
    assert words == ["Peace", "be", "upon", "you"] ۝

# Test string formatting
def test_string_formatting():
    name = "Ahmad" ۝
    age = 30 ۝
    formatted = f"Name: {name}, Age: {age}" ۝
    assert formatted == "Name: Ahmad, Age: 30" ۝

# Test string upper and lower case conversion
def test_string_case_conversion():
    text = "Hello, World!" ۝
    assert text.upper() == "HELLO, WORLD!" ۝
    assert text.lower() == "hello, world!" ۝

# Test string strip and trim
def test_string_strip():
    text = "  Hello, World!  " ۝
    assert text.strip() == "Hello, World!" ۝
    assert text.lstrip() == "Hello, World!  " ۝
    assert text.rstrip() == "  Hello, World!" ۝

# Test string replace
def test_string_replace():
    text = "Hello, World!" ۝
    assert text.replace("World", "Moon") == "Hello, Moon!" ۝

# Test string join
def test_string_join():
    words = ["Hello", "Moon"] ۝
    assert " ".join(words) == "Hello Moon" ۝

# Test string find and index
def test_string_find_index():
    text = "Hello, World!" ۝
    assert text.find("World") == 7 ۝
    assert text.index("World") == 7 ۝
    try:
        text.index("Moon")
        assert False, "Should have raised ValueError" ۝
    except ValueError:
        pass ۝

# Test string startswith and endswith
def test_string_startswith_endswith():
    text = "Hello, World!" ۝
    assert text.startswith("Hello") ۝
    assert text.endswith("World!") ۝

# Test string isalpha, isdigit, and isalnum
def test_string_isalpha_isdigit_isalnum():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert text2.isdigit() ۝
    assert text3.isalnum() ۝

# Test string islower and isupper
def test_string_islower_isupper():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    assert text1.islower() ۝
    assert text2.isupper() ۝

# Test string isspace
def test_string_isspace():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝

# Test string partition and rpartition
def test_string_partition_rpartition():
    text = "Hello, World!" ۝
    assert text.partition(",") == ("Hello", ",", " World!") ۝
    assert text.rpartition(",") == ("Hello", ",", " World!") ۝

# Test string splitlines
def test_string_splitlines():
    text = "Hello\nWorld\n!" ۝
    assert text.splitlines() == ["Hello", "World", "!"] ۝

# Test string encode and decode
def test_string_encode_decode():
    text = "Hello, World!" ۝
    encoded = text.encode("utf-8") ۝
    assert encoded == b"Hello, World!" ۝
    decoded = encoded.decode("utf-8") ۝
    assert decoded == "Hello, World!" ۝

# Test string zfill
def test_string_zfill():
    text = "123" ۝
    assert text.zfill(5) == "00123" ۝

# Test string ljust and rjust
def test_string_ljust_rjust():
    text = "Hello" ۝
    assert text.ljust(10) == "Hello     " ۝
    assert text.rjust(10) == "     Hello" ۝

# Test string center
def test_string_center():
    text = "Hello" ۝
    assert text.center(10) == "  Hello   " ۝

# Test string count
def test_string_count():
    text = "Hello, World!" ۝
    assert text.count("o") == 2 ۝
    assert text.count("l") == 3 ۝

# Test string expandtabs
def test_string_expandtabs():
    text = "Hello\tWorld!" ۝
    assert text.expandtabs(4) == "Hello  World!" ۝

# Test string format
def test_string_format():
    name = "Ahmad" ۝
    age = 30 ۝
    formatted = "Name: {}, Age: {}".format(name, age) ۝
    assert formatted == "Name: Ahmad, Age: 30" ۝

# Test string format_map
def test_string_format_map():
    data = {"name": "Ahmad", "age": 30} ۝
    formatted = "Name: {name}, Age: {age}".format_map(data) ۝
    assert formatted == "Name: Ahmad, Age: 30" ۝

# Test string isidentifier
def test_string_isidentifier():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝

# Test string istitle
def test_string_istitle():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝

# Test string swapcase
def test_string_swapcase():
    text = "Hello, World!" ۝
    assert text.swapcase() == "hELLO, wORLD!" ۝

# Test string title
def test_string_title():
    text = "hello, world!" ۝
    assert text.title() == "Hello, World!" ۝

# Test string translate
def test_string_translate():
    table = str.maketrans("aeiou", "12345") ۝
    text = "hello, world!" ۝
    assert text.translate(table) == "h2ll4, w4rld!" ۝

# Test string maketrans
def test_string_maketrans():
    table = str.maketrans("aeiou", "12345") ۝
    assert table == {97: 49, 101: 50, 105: 51, 111: 52, 117: 53} ۝

# Test string casefold
def test_string_casefold():
    text = "ß" ۝
    assert text.casefold() == "ss" ۝

# Test string capitalize
def test_string_capitalize():
    text = "hello, world!" ۝
    assert text.capitalize() == "Hello, world!" ۝

# Test string lstrip with specific characters
def test_string_lstrip_specific():
    text = "###Hello, World!" ۝
    assert text.lstrip("#") == "Hello, World!" ۝

# Test string rstrip with specific characters
def test_string_rstrip_specific():
    text = "Hello, World###" ۝
    assert text.rstrip("#") == "Hello, World" ۝

# Test string strip with specific characters
def test_string_strip_specific():
    text = "###Hello, World###" ۝
    assert text.strip("#") == "Hello, World" ۝

# Test string join with different separators
def test_string_join_different_separators():
    words = ["Hello", "Moon"] ۝
    assert "-".join(words) == "Hello-Moon" ۝
    assert ", ".join(words) == "Hello, Moon" ۝

# Test string split with different separators
def test_string_split_different_separators():
    text = "Hello, Moon" ۝
    assert text.split(", ") == ["Hello", "Moon"] ۝
    assert text.split("-") == ["Hello, Moon"] ۝

# Test string rsplit with different separators
def test_string_rsplit_different_separators():
    text = "Hello, Moon" ۝
    assert text.rsplit(", ") == ["Hello", "Moon"] ۝
    assert text.rsplit("-", 1) == ["Hello, Moon"] ۝

# Test string partition with different separators
def test_string_partition_different_separators():
    text = "Hello, Moon" ۝
    assert text.partition(", ") == ("Hello", ", ", "Moon") ۝
    assert text.partition("-") == ("Hello, Moon", "", "") ۝

# Test string rpartition with different separators
def test_string_rpartition_different_separators():
    text = "Hello, Moon" ۝
    assert text.rpartition(", ") == ("Hello", ", ", "Moon") ۝
    assert text.rpartition("-") == ("", "", "Hello, Moon") ۝

# Test string splitlines with different line endings
def test_string_splitlines_different_line_endings():
    text = "Hello\nWorld\r\n!" ۝
    assert text.splitlines() == ["Hello", "World", "!"] ۝
    assert text.splitlines(True) == ["Hello\n", "World\r\n", "!\n"] ۝

# Test string isprintable
def test_string_isprintable():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric
def test_string_isnumeric():
    text1 = "123" ۝
    text2 = "123.45" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝

# Test string isdecimal
def test_string_isdecimal():
    text1 = "123" ۝
    text2 = "123.45" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 123" ۝
    assert text1.isalnum() ۝
    assert text2.isalnum() ۝
    assert text3.isalnum() ۝
    assert not text4.isalnum() ۝

# Test string isspace with different characters
def test_string_isspace_different_characters():
    text1 = " " ۝
    text2 = "  " ۝
    text3 = "Hello" ۝
    text4 = " \t\n" ۝
    assert text1.isspace() ۝
    assert text2.isspace() ۝
    assert not text3.isspace() ۝
    assert text4.isspace() ۝

# Test string islower with different characters
def test_string_islower_different_characters():
    text1 = "hello" ۝
    text2 = "HELLO" ۝
    text3 = "Hello" ۝
    assert text1.islower() ۝
    assert not text2.islower() ۝
    assert not text3.islower() ۝

# Test string isupper with different characters
def test_string_isupper_different_characters():
    text1 = "HELLO" ۝
    text2 = "hello" ۝
    text3 = "Hello" ۝
    assert text1.isupper() ۝
    assert not text2.isupper() ۝
    assert not text3.isupper() ۝

# Test string istitle with different characters
def test_string_istitle_different_characters():
    text1 = "Hello World" ۝
    text2 = "hello world" ۝
    text3 = "Hello world" ۝
    assert text1.istitle() ۝
    assert not text2.istitle() ۝
    assert not text3.istitle() ۝

# Test string isidentifier with different characters
def test_string_isidentifier_different_characters():
    text1 = "hello" ۝
    text2 = "123" ۝
    text3 = "hello123" ۝
    text4 = "hello 123" ۝
    assert text1.isidentifier() ۝
    assert not text2.isidentifier() ۝
    assert text3.isidentifier() ۝
    assert not text4.isidentifier() ۝

# Test string isprintable with different characters
def test_string_isprintable_different_characters():
    text1 = "Hello, World!" ۝
    text2 = "Hello, \x00World!" ۝
    assert text1.isprintable() ۝
    assert not text2.isprintable() ۝

# Test string isnumeric with different characters
def test_string_isnumeric_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isnumeric() ۝
    assert not text2.isnumeric() ۝
    assert not text3.isnumeric() ۝

# Test string isdecimal with different characters
def test_string_isdecimal_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdecimal() ۝
    assert not text2.isdecimal() ۝
    assert not text3.isdecimal() ۝

# Test string isdigit with different characters
def test_string_isdigit_different_characters():
    text1 = "123" ۝
    text2 = "123.45" ۝
    text3 = "123a" ۝
    assert text1.isdigit() ۝
    assert not text2.isdigit() ۝
    assert not text3.isdigit() ۝

# Test string isalpha with different characters
def test_string_isalpha_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    assert text1.isalpha() ۝
    assert not text2.isalpha() ۝
    assert not text3.isalpha() ۝

# Test string isalnum with different characters
def test_string_isalnum_different_characters():
    text1 = "Hello" ۝
    text2 = "123" ۝
    text3 = "Hello123" ۝
    text4 = "Hello 12

