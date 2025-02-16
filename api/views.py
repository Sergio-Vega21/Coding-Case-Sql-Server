from django.shortcuts import render
from rest_framework import viewsets
from .models import Usuario
from .serializers import UsuarioSerializer
from rest_framework.decorators import api_view
from django.http import JsonResponse
from django.db import connection
from rest_framework import generics , status
from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse


class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer

def ejecutar_consulta_por_rol(request, id_usuario):
    try:
        with connection.cursor() as cursor:
            # Ejecutar el procedimiento almacenado
            cursor.execute("EXEC EjecutarConsultaSegunRol @idUsuario = %s", [id_usuario])

            # Ahora obtener los datos desde la tabla temporal global
            cursor.execute("SELECT * FROM ##TempTable")
            resultados = cursor.fetchall()

            # Si hay resultados, estructurarlos en JSON
            if resultados:
                columnas = [col[0] for col in cursor.description]  # Obtener nombres de columnas
                data = [dict(zip(columnas, row)) for row in resultados]
                return JsonResponse({"data": data}, safe=False)
            else:
                return JsonResponse({"error": "No hay datos para este usuario"}, status=404)

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)