from django.conf import settings
from django.core.validators import MinValueValidator
from django.db import models
from decimal import Decimal
from core.models import RestaurantCustomer
from product.models import Product

    
class PromoCode(models.Model):
    code = models.CharField(max_length=50, unique=True)
    minimum_spending = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(Decimal('0.00'))])
    percentage_discount = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True, validators=[MinValueValidator(Decimal('0.00'))])
    fixed_discount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True, validators=[MinValueValidator(Decimal('0.00'))])
    
    def __str__(self) -> str:
        return self.code
    
    def get_discount_amount(self, amount):
        amount = Decimal(amount)
        if amount >= self.minimum_spending:
            if self.fixed_discount:
                return self.fixed_discount
            elif self.percentage_discount:
                return amount * (self.percentage_discount / Decimal('100.0'))
        return Decimal('0.00')


class Order(models.Model):
    STATUS_CHOICES = [(c, c) for c in settings.K_ORDER_STATUS_LIST]
    
    promo_code = models.ForeignKey(PromoCode, on_delete=models.SET_NULL, null=True, blank=True, related_name='orders')
    sub_total = models.DecimalField(max_digits=10, decimal_places=2, default=Decimal('0.00'))
    final_total = models.DecimalField(max_digits=10, decimal_places=2, default=Decimal('0.00'))
    customer = models.ForeignKey(RestaurantCustomer, on_delete=models.SET_NULL, null=True, related_name='orders')
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=settings.K_STATUS_PENDING)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self) -> str:
        return f"Order {self.id} by {self.customer}"
    
    def calculated_sub_total(self):
        sub_total = sum(item.product.price * item.count for item in self.order_products.all() if item.product)
        self.sub_total = Decimal(sub_total)
        self.save()
    
    def calculate_final_total(self):
        self.calculated_sub_total()
        total = self.sub_total
        if self.promo_code:
            total -= self.promo_code.get_discount_amount(self.sub_total)
        self.final_total = total
        self.save()


class OrderProduct(models.Model):
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True)
    count = models.IntegerField(default=1, validators=[MinValueValidator(1)])
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_products')
    
    class Meta:
        unique_together = (('product', 'order'),)

    def __str__(self) -> str:
        return f"{self.product.title} ({self.count})"
