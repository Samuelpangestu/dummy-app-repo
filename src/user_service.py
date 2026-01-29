"""
Simple User Service Module
Simulates basic user management operations
"""

from typing import Dict, Optional


class UserService:
    """Basic user service for demonstration"""

    def __init__(self):
        self.users: Dict[int, Dict[str, str]] = {}
        self.next_id = 1

    def create_user(self, name: str, email: str) -> Dict[str, any]:
        """Create a new user"""
        if not name or not email:
            raise ValueError("Name and email are required")

        if not self._is_valid_email(email):
            raise ValueError("Invalid email format")

        user = {
            "id": self.next_id,
            "name": name,
            "email": email,
            "status": "active"
        }
        self.users[self.next_id] = user
        self.next_id += 1
        return user

    def get_user(self, user_id: int) -> Optional[Dict[str, any]]:
        """Get user by ID"""
        return self.users.get(user_id)

    def update_user(self, user_id: int, name: Optional[str] = None,
                   email: Optional[str] = None) -> Optional[Dict[str, any]]:
        """Update user information"""
        user = self.users.get(user_id)
        if not user:
            return None

        if name:
            user["name"] = name
        if email:
            if not self._is_valid_email(email):
                raise ValueError("Invalid email format")
            user["email"] = email

        return user

    def delete_user(self, user_id: int) -> bool:
        """Delete user by ID"""
        if user_id in self.users:
            del self.users[user_id]
            return True
        return False

    def list_users(self) -> list:
        """List all users"""
        return list(self.users.values())

    @staticmethod
    def _is_valid_email(email: str) -> bool:
        """Basic email validation"""
        return "@" in email and "." in email.split("@")[1]
        
