from django.contrib import admin
from order.models import OrderProduct, PromoCode, Order


admin.site.register([Order, OrderProduct, PromoCode])
