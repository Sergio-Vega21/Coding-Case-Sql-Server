from django.db import models

#Modelo que representa los roles en el sistema
class Rol(models.Model):
    idRol = models.AutoField(primary_key=True)
    nombreRol = models.CharField(max_length=50, unique=True)

    class Meta:
        db_table = 'Roles'  

#Modelo que representa los departamentos en el sistema
class Departamento(models.Model):
    idDept = models.AutoField(primary_key=True)
    nombreDept = models.CharField(max_length=100, unique=True)

    class Meta:
        db_table = 'Departamentos'

#Modelo que representa los usuarios en el sistema
class Usuario(models.Model):
    idUsuario = models.AutoField(primary_key=True)
    nombreUsuario = models.CharField(max_length=100)
    emailUsuario = models.EmailField(unique=True)
    idRol = models.ForeignKey(Rol, on_delete=models.SET_NULL, null=True, db_column="idRol")
    idDept = models.ForeignKey(Departamento, on_delete=models.SET_NULL, null=True, db_column="idDept")
    idJefe = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True, db_column="idJefe")

    class Meta:
        db_table = 'Usuarios'

#Modelo que representa los pagos  en el sistema
class Pago(models.Model):
    idPago = models.AutoField(primary_key=True)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE, db_column="idUsuario")
    montoPago = models.DecimalField(max_digits=10, decimal_places=2)
    fechaPago = models.DateField()

    class Meta:
        db_table = 'Pagos'

#Modelo que almacena los accesos al sistema mediante la tabla AuditoriaAccesos
class AuditoriaAcceso(models.Model):
    idAcceso = models.AutoField(primary_key=True)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE, db_column="idUsuario")
    tablaAccedida = models.CharField(max_length=50)
    fechaAcceso = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'AuditoriaAccesos'

