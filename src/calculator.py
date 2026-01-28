"""
Simple Calculator Module
Demonstrates basic operations for CI/CD testing
"""


class Calculator:
    """Basic calculator with arithmetic operations"""

    @staticmethod
    def add(a: float, b: float) -> float:
        """Add two numbers"""
        return a + b

    @staticmethod
    def subtract(a: float, b: float) -> float:
        """Subtract b from a"""
        return a - b

    @staticmethod
    def multiply(a: float, b: float) -> float:
        """Multiply two numbers"""
        return a * b

    @staticmethod
    def divide(a: float, b: float) -> float:
        """Divide a by b"""
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b

    @staticmethod
    def power(base: float, exponent: float) -> float:
        """Calculate base raised to exponent"""
        return base ** exponent
