
#!/bin/bash

#variables
REPO="The-DevOps-Journey-101"

USERID=$(id -u)
#colores
LRED='\033[1;31m'
LGREEN='\033[1;32m'
NC='\033[0m'
LBLUE='\033[0;34m'
LYELLOW='\033[1;33m'

#Actualizando
apt-get update

echo "El servidor está actualizado"


if [ "${USERID}" -ne 0 ]; then
    echo -e "\n${LRED}Correr con usuario ROOT${NC}"
    exit
fi


if dpkg -l |grep -q git ;
then
        echo "ya esta instalado"
else
        echo "instalando paquete" 
        apt install git -y 
fi

###Instalación Apache ######
if dpkg -l |grep -q apache2 ;
then
    echo "ya esta instalado"
else
        echo "instalando paquete" 
        apt install apache2 -y 
        apt install -y php libapache2-mod-php php-mysql php-mbstring php-zip php-gd php-json php-curl
        systemctl start apache2
        systemctl enable apache2
fi


###base de datos maria db ######
if dpkg -s mariadb-server > /dev/null 2>&1; then
    echo -e "\n${LBLUE}El servidor se encuentra Actualizado ...${NC}"
else
    echo -e "\n${LYELLOW}instalando MARIA DB ...${NC}"
    apt install -y mariadb-server
fi
###Iniciando la base de datos
    systemctl start mariadb
    systemctl enable mariadb

echo -e "\n${LBLUE}Configurando base de datos ...${NC}"

###Configuracion de la base de datos
mysql -e "
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
flush privileges;"

###Carga de datos iniciales a la base de datos

cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

EOF
mysql < db-load-script.sql



if [ -d "$REPO" ] ;
then    
    echo "la carpeta $REPO existe"
else
    echo "instalando web"
    sleep 1
    git clone https://github.com/roxsross/$REPO.git
    cp -r $REPO/CLASE-02/lamp-app-ecommerce/* /var/www/html/
    mv /var/www/html/index.html /var/www/html/index.html.bkp
fi

sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php
  
curl http://localhost

#reload
systemctl reload apache2


