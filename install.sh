#!/bin/sh

read -p "Voulez vous lancer le script?:" reponse1

if  [ $reponse1 = "yes" ]||
    [ $reponse1 = "yEs" ]||
    [ $reponse1 = "YEs" ]||
    [ $reponse1 = "YES" ]||
    [ $reponse1 = "yES" ]||
    [ $reponse1 = "y" ]||
    [ $reponse1 = "Y" ]||
    [ $reponse1 = "yeS" ],
then

echo "Lancement du script..."

clear

echo "Update des fichier"

sudo apt-get update
sudo apt-get upgrade -y 
sudo apt-get dist-upgrade -y

clear

echo "Installation de apache2"

sudo apt-get install apache2

clear

echo "Installation de mysql"

sudo apt-get install mysql-server mysql-client

clear

echo  "Correction d'un bug automatique de mysql"

sudo service mysql stop

sudo usermod -d /var/lib/mysql/ mysql

clear

echo "Installation de nodejs et de npm"

sudo apt install nodejs && sudo apt install npm -y

clear

echo "Installation de php"

sudo apt-get install php libapache2-mod-php php-mysql php-gd php-json php-curl php-xml php-mbstring -y

clear

echo "Installation de net tools"

sudo apt install net-tools -y

clear

echo "Update des fichier"

sudo apt-get update

clear

read -p "Voulez vous installer phpmyadmin?:" reponse2

if  [ $reponse2 = "yes" ]||
    [ $reponse2 = "yEs" ]||
    [ $reponse2 = "YEs" ]||
    [ $reponse2 = "YES" ]||
    [ $reponse2 = "yES" ]||
    [ $reponse2 = "y" ]||
    [ $reponse2 = "Y" ]||
    [ $reponse2 = "yeS" ],
then

sudo service mysql start

sudo apt-get install -y phpmyadmin

sudo chmod -R 777 /etc/apache2/apache2.conf

echo Include /etc/phpmyadmin/apache.conf >> /etc/apache2/apache2.conf

sudo chmod -R 755 /etc/apache2/apache2.conf

/etc/init.d/apache2 restart

sudo service mysql stop

clear

else

echo "Chargement de la suite du script"

fi

clear

echo "Instalaltion de composer"

sudo apt update

sudo apt install php-cli unzip

cd ~

mkdir Composer

cd Composer

curl -sS https://getcomposer.org/installer -o composer-setup.php

HASH=`curl -sS https://composer.github.io/installer.sig`

php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

clear

echo "Installation de symfony"

wget https://get.symfony.com/cli/installer -O - | bash

sudo mv /home/$USER/.symfony/bin/symfony /usr/local/bin/symfony

sudo chmod 755 /

clear

echo "Lancement de mysql"

sudo service mysql start

clear

read -p "Voulez-vous créez un nouveaux utilisateurs pour mysql avec toute les permissions?(conseillé):" reponse4

if  [ $reponse4 = "yes" ]||
    [ $reponse4 = "yEs" ]||
    [ $reponse4 = "YEs" ]||
    [ $reponse4 = "YES" ]||
    [ $reponse4 = "yES" ]||
    [ $reponse4 = "y" ]||
    [ $reponse4 = "Y" ]||
    [ $reponse4 = "yeS" ],
then

read -p "Entrez le nom d'utilisateur:" newuserusername

read -p "Entrez le mot de passe:" newuserpass

sudo mysql -u root -p << EOF
  CREATE USER '$newuserusername'@'localhost' IDENTIFIED BY '$newuserpass';
  GRANT ALL PRIVILEGES ON * . * TO '$newuserusername'@'localhost';
  FLUSH PRIVILEGES;
EOF

else
clear 

echo "Chargement de la suite du script"

fi

read -p "Voulez-vous changez le mot de passe du compte root de mysql:" reponse5

if  [ $reponse5 = "yes" ]||
    [ $reponse5 = "yEs" ]||
    [ $reponse5 = "YEs" ]||
    [ $reponse5 = "YES" ]||
    [ $reponse5 = "yES" ]||
    [ $reponse5 = "y" ]||
    [ $reponse5 = "Y" ]||
    [ $reponse5 = "yeS" ],
then

read -p "Entrez le nouveaux mot de passe mysql:" mdpmysql

sudo mysql -u root -p << EOF
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$mdpmysql';
EOF

sudo service mysql restart

clear

echo "Fin du script"
echo "Le mot passe root de mysql: $mdpmysql"

else

clear

echo "Fin du script"
fi

else 

echo "Anullation du script"

fi
