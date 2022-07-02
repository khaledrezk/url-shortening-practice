import string
import random

from django.db import models
from hashlib import md5
from base62 import encodebytes
 
# Create your models here.
class Link(models.Model):
    long_url = models.TextField()
    short_url = models.CharField(max_length=10, unique=True)
    def __str__(self):
        return f"Link(long_url={self.long_url},short_url={self.short_url})"
alpha = string.ascii_letters + string.digits

def gen_short_url(long_url:str) -> str:
    """
    Generate a short url from long url.
    Note this function doesn't test for hash collisions 
    however we can retry until there is no collision.
    """
    nonse = "".join(random.choice(alpha) for i in range(10))
    hashed = md5((long_url + nonse).encode())
    encoded = encodebytes(hashed.digest())
    print("Encoded full is :", encoded)
    short = encoded[:7]
    return short
