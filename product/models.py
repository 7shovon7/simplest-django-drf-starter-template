from django.db import models


class Product(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    allergy_info = models.TextField(blank=True, null=True)
    price = models.FloatField()
    image = models.ImageField(blank=True, null=True)
    
    def __str__(self) -> str:
        return self.title
