from rest_framework import serializers
from .models import Usuario
from .models import AuditoriaAcceso

#Serializador para el modelo Usuario
class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = '__all__'  

#Serializador para el modelo AuditoriaAcceso 
class AuditoriaAccesoSerializer(serializers.ModelSerializer):
    class Meta:
        model = AuditoriaAcceso
        fields = '__all__'
