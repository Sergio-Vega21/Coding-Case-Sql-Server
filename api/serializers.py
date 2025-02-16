from rest_framework import serializers
from .models import Usuario
from .models import AuditoriaAcceso

class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = '__all__'  # Puedes especificar campos como ['id', 'nombre', 'email']



class AuditoriaAccesoSerializer(serializers.ModelSerializer):
    class Meta:
        model = AuditoriaAcceso
        fields = '__all__'
