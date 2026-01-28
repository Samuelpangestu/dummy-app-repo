"""
Unit tests for Calculator module
"""

import unittest
from src.calculator import Calculator


class TestCalculator(unittest.TestCase):
    """Test cases for Calculator class"""

    def setUp(self):
        """Set up test fixtures"""
        self.calc = Calculator()

    def test_add_positive_numbers(self):
        """Test addition of positive numbers"""
        result = self.calc.add(5, 3)
        self.assertEqual(result, 8)

    def test_add_negative_numbers(self):
        """Test addition of negative numbers"""
        result = self.calc.add(-5, -3)
        self.assertEqual(result, -8)

    def test_subtract(self):
        """Test subtraction"""
        result = self.calc.subtract(10, 4)
        self.assertEqual(result, 6)

    def test_multiply(self):
        """Test multiplication"""
        result = self.calc.multiply(6, 7)
        self.assertEqual(result, 42)

    def test_divide(self):
        """Test division"""
        result = self.calc.divide(10, 2)
        self.assertEqual(result, 5)

    def test_divide_by_zero(self):
        """Test division by zero raises exception"""
        with self.assertRaises(ValueError) as context:
            self.calc.divide(10, 0)
        self.assertIn("Cannot divide by zero", str(context.exception))

    def test_power(self):
        """Test power operation"""
        result = self.calc.power(2, 3)
        self.assertEqual(result, 8)


if __name__ == '__main__':
    unittest.main()
