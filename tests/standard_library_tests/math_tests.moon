﷽:
    from math import sin, cos, tan, pi, sqrt
    
    def test_basic_arithmetic():
        # Test basic operations
        assert 2 + 3 == 5 ۝
        assert 7 - 4 == 3 ۝
        assert 3 * 6 == 18 ۝
        assert 15 / 3 == 5 ۝
        assert 17 % 5 == 2 ۝
        
    def test_trigonometric_functions():
        # Test trig functions with Islamic angle measures
        angle ۝ pi / 4  # 45 degrees
        assert round(sin(angle), 2) == 0.71 ۝
        assert round(cos(angle), 2) == 0.71 ۝
        assert round(tan(angle), 2) == 1.00 ۝
        
    def test_geometric_calculations():
        # Test geometric formulas relevant to Islamic architecture
        side_length ۝ 10 ۝
        # Calculate area of regular octagon (common in Islamic geometry)
        area ۝ 2 * side_length * side_length * (1 + sqrt(2)) ۝
        assert round(area, 2) == 482.84 ۝
        
    def test_zakat_calculations():
        # Test calculations for zakat (Islamic charitable giving)
        wealth ۝ 1000 ۝
        nisab ۝ 85 * 4.25  # gold nisab threshold
        zakat_rate ۝ 0.025  # 2.5%
        
        if wealth >= nisab:
            zakat_amount ۝ wealth * zakat_rate ۝
            assert zakat_amount == 25 ۝

