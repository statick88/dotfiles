from django.shortcuts import render
from .models import Medicamento, Venta

def lista_medicamentos(request):
    medicamentos = Medicamento.objects.all()
    return render(request, 'farmacia/lista_medicmaentos.html', {'medicamentos':medicamentos})

