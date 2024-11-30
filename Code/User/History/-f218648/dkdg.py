from django.urls import path
from . import views

urlpatterns = [
    path('medicamentos/', views.lista_medicamentos, name='lista_medicamentos')
]
