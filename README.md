# Coding-Case-Sql-Server
## Primer comando 
python -m venv env
## Segundo comando 
pip install django djangorestframework django-mssql-backend
## Tercer comando 
django-admin startproject core .
## Cuarto comando 
pip install mssql-django
## Quinto comando "Para cambiar el protocolo en el puerto y lograr la conexion" 
netsh advfirewall firewall add rule name="SQL Server" dir=in action=allow protocol=TCP localport=1433
## Sexto Comando para generacion de PDF
pip install reportlab
