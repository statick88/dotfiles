from django import forms
from .models import Medicamento, Venta

class ContactForm(forms.Form):
    nombre = forms.CharField(label='Nombre', max_length=100)
    email = forms.EmailField(label='Email', max_length=100)
    mensaje = forms.EmailField(label='Mensaje', widget=forms.Textarea)

class MedicamentoForm(forms.ModelForm):
    class Meta:
        model = Medicamento
        fields = ['nombre', 'precio', 'existencias', 'lugar']

class VentaForm(forms.ModelForm):
    class Meta:
        model = Venta
        fields = ['medicamento','cantidad']
