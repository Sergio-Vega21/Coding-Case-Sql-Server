from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from api.views import UsuarioViewSet
from api.views import AuditoriaAccesoViewSet
from api.views import ConsultaRolViewSet
from api.views import exportar_pdf_nomina_departamento
from django.contrib import admin
from rest_framework.response import Response
from rest_framework.decorators import api_view



#Enrutador para las rutas de los ViewSets
router = DefaultRouter()

router.register(r'usuarios', UsuarioViewSet)
router.register(r'auditoria', AuditoriaAccesoViewSet, basename='auditoria')
router.register(r'consulta-rol', ConsultaRolViewSet, basename='consulta-rol')


# Nueva vista API root personalizada
@api_view(['GET'])
def custom_api_root(request, format=None):
    return Response({
        "usuarios": request.build_absolute_uri('/usuarios/'),
        "auditoria": request.build_absolute_uri('/auditoria/'),
        "consulta-rol": request.build_absolute_uri('/consulta-rol/'),
        "exportar-pdf-nomina": request.build_absolute_uri('/exportar-pdf-nomina/')  # Agregamos la URL del PDF
    })

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', custom_api_root, name='api-root'),
    path('', include(router.urls)),
    path('exportar-pdf-nomina/', exportar_pdf_nomina_departamento, name='exportar_pdf_nomina_departamento'),


]
