from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from api.views import UsuarioViewSet
from api.views import AuditoriaAccesoViewSet
from api.views import ConsultaRolViewSet

#Enrutador para las rutas de los ViewSets
router = DefaultRouter()

router.register(r'usuarios', UsuarioViewSet)
router.register(r'auditoria', AuditoriaAccesoViewSet, basename='auditoria')
router.register(r'consulta-rol', ConsultaRolViewSet, basename='consulta-rol')



urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),

]
