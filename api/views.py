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
from .models import AuditoriaAcceso
from .serializers import AuditoriaAccesoSerializer
from reportlab.pdfgen import canvas



#ViewSet para manejar CRUD de los usuarios
class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer

#ViewSet para lectura de AuditoriaAccesos
class AuditoriaAccesoViewSet(viewsets.ReadOnlyModelViewSet):  
    queryset = AuditoriaAcceso.objects.all().order_by('-fechaAcceso')
    serializer_class = AuditoriaAccesoSerializer

#ViewSet personalizado para consultar los permisos de un usuario segun su rol
class ConsultaRolViewSet(viewsets.ViewSet):

    def list(self, request):  
        return Response({
            "detalle": "Para consultar un usuario específico, usa /consulta-rol/{id_usuario}/"
        })  

    def retrieve(self, request, pk=None):  # pk es el id_usuario
        try:
            with connection.cursor() as cursor:
                # Ejecutar el procedimiento almacenado
                cursor.execute("EXEC EjecutarConsultaSegunRol @idUsuario = %s", [pk])

                # Obtener los datos desde la tabla temporal global
                cursor.execute("SELECT * FROM ##TempTable")
                resultados = cursor.fetchall()

                # Si hay resultados, estructurarlos en JSON
                if resultados:
                    columnas = [col[0] for col in cursor.description]  
                    data = [dict(zip(columnas, row)) for row in resultados]
                    return Response({"data": data})
                else:
                    return Response({"error": "No hay datos para este usuario"}, status=404)

        except Exception as e:
            return Response({"error": str(e)}, status=500)

#Ejecuta el procedimiento en SQLServer y devuelve los resultados en una lista 
def obtener_nomina_por_departamento():
    """Ejecuta el procedimiento almacenado en SQL Server y devuelve los resultados"""
    with connection.cursor() as cursor:
        cursor.execute("EXEC ObtenerReporteNominaPorDepartamento")  
        columnas = [col[0] for col in cursor.description]  
        resultados = cursor.fetchall()  

    return [dict(zip(columnas, row)) for row in resultados]  

#Genera un reporte en PDF con la nómina total pagada por cada departamento
def exportar_pdf_nomina_departamento(request):
    datos = obtener_nomina_por_departamento()

    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="nomina_departamentos.pdf"'

    p = canvas.Canvas(response)
    p.setTitle("Reporte de Nómina por Departamento")
    
    p.drawString(100, 800, "Reporte de Nómina por Departamento")
    p.drawString(100, 780, "------------------------------------------")
    
    y = 760
    for pago in datos:
        texto = f"{pago['nombreDept']} - Total Pagado: ${pago['totalPagos']} - {pago['cantidadPagos']} pagos"
        p.drawString(100, y, texto)
        y -= 20
        if y < 50:  
            p.showPage()
            y = 800

    p.showPage()
    p.save()
    return response