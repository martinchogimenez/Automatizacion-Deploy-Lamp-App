Despliegue Automatizado de Aplicación LAMP
Este script automatiza el proceso de despliegue de una aplicación LAMP (Linux, Apache, MySQL, PHP) en un servidor. La aplicación utilizada es un sencillo sitio de comercio electrónico que vende productos electrónicos.

Requisitos
Este script debe ejecutarse en un sistema operativo basado en Linux.
Se requieren permisos de administrador (usuario ROOT) para ejecutar el script.
Pasos del Script
Actualización del Sistema:

Se realiza una actualización del sistema operativo para asegurar que todos los paquetes estén al día.
Verificación de Usuario ROOT:

El script verifica si está siendo ejecutado con privilegios de usuario ROOT. Si no es así, el script se detiene.
Instalación de Git:

Se verifica si Git está instalado en el sistema. En caso contrario, se instala automáticamente.
Instalación de Apache y PHP:

Se verifica la presencia de Apache en el sistema. Si no está instalado, se instala junto con PHP y sus extensiones necesarias.
Instalación de MariaDB:

Se verifica si MariaDB está instalado. Si no lo está, se realiza la instalación.
Configuración de la Base de Datos:

Se crea una base de datos llamada ecomdb.
Se crea un usuario llamado ecomuser con la contraseña ecompassword y se le otorgan todos los privilegios en la base de datos.
Carga de Datos Iniciales:

Se crea una tabla llamada products en la base de datos ecomdb.
Se insertan datos iniciales en la tabla de productos.
Clonación de la Aplicación desde GitHub:

Se verifica si la carpeta del repositorio (The-DevOps-Journey-101) ya existe. Si no existe, se clona el repositorio desde GitHub.
Los archivos de la aplicación se copian en el directorio de Apache.
Configuración de la Aplicación:

Se realiza una modificación en el archivo index.php para cambiar la dirección IP de conexión a localhost.
Recarga de Apache:

Se recarga el servicio de Apache para aplicar los cambios realizados.
Verificación del Despliegue:

Se realiza una solicitud HTTP a http://localhost para verificar que la aplicación está desplegada correctamente.
Nota:

Este script asume que se ejecuta en un entorno de desarrollo o prueba.
La seguridad y la configuración específica pueden necesitar ajustes según el entorno de implementación.
Asegúrese de revisar y comprender el contenido del script antes de ejecutarlo en un entorno de producción.
