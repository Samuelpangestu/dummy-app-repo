"""
Unit tests for UserService module
"""

import unittest
from src.user_service import UserService


class TestUserService(unittest.TestCase):
    """Test cases for UserService class"""

    def setUp(self):
        """Set up test fixtures"""
        self.service = UserService()

    def test_create_user_success(self):
        """Test successful user creation"""
        user = self.service.create_user("John Doe", "john@example.com")
        self.assertEqual(user["name"], "John Doe")
        self.assertEqual(user["email"], "john@example.com")
        self.assertEqual(user["status"], "active")
        self.assertIsNotNone(user["id"])

    def test_create_user_invalid_email(self):
        """Test user creation with invalid email"""
        with self.assertRaises(ValueError) as context:
            self.service.create_user("John Doe", "invalid-email")
        self.assertIn("Invalid email format", str(context.exception))

    def test_create_user_missing_name(self):
        """Test user creation with missing name"""
        with self.assertRaises(ValueError) as context:
            self.service.create_user("", "john@example.com")
        self.assertIn("Name and email are required", str(context.exception))

    def test_get_user(self):
        """Test getting user by ID"""
        user = self.service.create_user("Jane Doe", "jane@example.com")
        retrieved = self.service.get_user(user["id"])
        self.assertEqual(retrieved["name"], "Jane Doe")

    def test_get_nonexistent_user(self):
        """Test getting non-existent user"""
        user = self.service.get_user(999)
        self.assertIsNone(user)

    def test_update_user(self):
        """Test updating user information"""
        user = self.service.create_user("Bob Smith", "bob@example.com")
        updated = self.service.update_user(user["id"], name="Robert Smith")
        self.assertEqual(updated["name"], "Robert Smith")
        self.assertEqual(updated["email"], "bob@example.com")

    def test_delete_user(self):
        """Test deleting user"""
        user = self.service.create_user("Alice Brown", "alice@example.com")
        result = self.service.delete_user(user["id"])
        self.assertTrue(result)
        self.assertIsNone(self.service.get_user(user["id"]))

    def test_delete_nonexistent_user(self):
        """Test deleting non-existent user"""
        result = self.service.delete_user(999)
        self.assertFalse(result)

    def test_list_users(self):
        """Test listing all users"""
        self.service.create_user("User 1", "user1@example.com")
        self.service.create_user("User 2", "user2@example.com")
        users = self.service.list_users()
        self.assertEqual(len(users), 2)


if __name__ == '__main__':
    unittest.main()
