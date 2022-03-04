from django.contrib.auth.models import AbstractUser
from django.db import models

# Create my own class hodling the User model
class User(AbstractUser):
    pass