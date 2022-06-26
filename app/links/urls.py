from django.urls import path

from . import views

urlpatterns = [
    path('api/create_link', views.add_long_url),#post with body
    path('<str:short_url>', views.redirect)
]
