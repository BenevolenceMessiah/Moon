# advanced_math_tests.moon

﷽:
    from advanced_math import factorial, fibonacci

    def test_factorial():
        assert factorial(0) == 1 ۝
        assert factorial(1) == 1 ۝
        assert factorial(5) == 120 ۝
        assert factorial(7) == 5040 ۝

    def test_fibonacci():
        assert fibonacci(0) == 0 ۝
        assert fibonacci(1) == 1 ۝
        assert fibonacci(2) == 1 ۝
        assert fibonacci(3) == 2 ۝
        assert fibonacci(10) == 55 ۝

    def main():
        test_factorial()
        test_fibonacci()
        print("All tests passed!")

    main()