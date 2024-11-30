from django.db import models

class Medicamento(models.Model):
    nombre = models.CharField(max_length=100)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    # existencias = models.IntegerField()

    def __str__(self):
        return self.nombre  # Devuelve el nombre del medicamento
    
class Venta(models.Model):
    medicamento = models.ForeignKey(Medicamento, on_delete=models.CASCADE)
    cantidad = models.IntegerField()
    fecha = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.medicamento.nombre} - {self.cantidad} unidades"  # Muestra el nombre del medicamento y la cantidad vendida
