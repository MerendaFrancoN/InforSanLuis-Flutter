!/bin/bash
echo -e "*************************************************************************************************************" 
echo -e "***** Escuela Informático 2019 - Desarrollando y diseñando Aplicaciones con Flutter                    ******"
echo -e "*****                                                                                                  ******"
echo -e "***** Te solicitaremos la contraseña para realizar instalaciones y actualizaciones de paquetes         ******"
echo -e "***** Ante cualquier duda o error que no se conoce, no duden en consultar a cualquiera de nosotros     ******"
echo -e "***** **Colaboradores:                                                                                 ******"
echo -e "*****          *Maguire, Margarita -- meganmaguire000@gmail.com                                        ******"
echo -e "*****          *Decena, Facundo M. -- facundo.decena@gmail.com                                         ******"
echo -e "*****          *Pellegrino, Maximilian H. -- pellegrinomhd@gmail.com                                   ******"
echo -e "*****          *Merenda, Franco N. -- merenda.franco83@gmail.com                                       ******"
echo -e "*****                                                                                                  ******"
echo -e "*************************************************************************************************************" 
function checkForFail(){
    if [ "$?" != "0" ]; then
        echo -e $1 1>&2 #Redirecciona stdout a stderror
        $2 $3 $4 $5 #Para realizar tareas a parte
        exit 1
    fi
}

#Comprobamos el funcionamiento de Internet
echo -e "***** Comenzamos con testeo de conexión a Internet *****"
ping -c 2 google.com >> /dev/null
checkForFail " \n\n ****ERROR: Sin conexión o conexión sin Internet****"
echo -e "************************** OK ************************** \n\n\n"
#Actualizamos los paquetes
sudo apt-get update
#Controlamos si todo salio OK
checkForFail "***** ERROR: Actualización de paquetes falló ***** " 
echo -e "************************** OK ************************** \n\n\n"


#Instalamos los necesarios
echo -e "\n***** Instalando los paquetes necesarios *****\n\n "
sudo apt-get install bash curl git unzip xz-utils libglu1-mesa
#Controlamos si todo salio OK
checkForFail "***** ERROR: en la instalación de Paquetes ******"
echo -e "************************** OK ************************** \n\n\n"

#Descargamos la version de Flutter y descomprimimos en /opt
echo -e "\n *****Descargando ultima versión de Flutter Estable*****\n\n"
if [ -f flutter_linux_v1.9.1+hotfix.6-stable.tar.xz ]
then
    echo "Ya descargado"
else
    wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz    
fi

#Controlamos si todo salio OK
checkForFail "*****ERROR: Descarga de Flutter falló*****" rm flutter_linux_v1.9.1+hotfix.6-stable.tar.xz
echo -e "************************** OK ************************** \n\n\n"

#Extraemos el archivo en el directorio Local
echo -e "\n *****Extrayendo el directorio de flutter *****"
tar xvf ./flutter_linux_v1.9.1+hotfix.6-stable.tar.xz
#Controlamos si todo salio OK
checkForFail "*****ERROR: Extracción de paquetes falló*, chequear el fichero o eliminarlo y correr de vuelta el script****" rm -r flutter

#Movemos al directorio /opt, podría ir a cualquier otro directorio que se especifique.
echo -e "\n***** Moviendo el directorio descomprimido ./flutter a /opt/flutter *****\n\n"
sudo mv flutter /opt/flutter
#Controlamos si todo salio OK
checkForFail "***** ERROR: mover flutter a /opt/flutter falló*****" sudo rm -r /opt/flutter
echo -e "************************** OK ************************** \n\n\n"


#Añadimos un acceso simbolico para poder acceder desde la terminal
echo -e "\n***** Añadiendo al Path para poder ejecutar desde terminal flutter *****\n"
sudo ln -s /opt/flutter/bin/flutter /usr/bin/flutter
#Controlamos si todo salio OK
checkForFail "***** ERROR: Creación del link simbolico falló *****" sudo rm /usr/bin/flutter
echo -e "************************** OK ************************** \n\n\n"

#Comprobamos que Flutter esté funcionando correctamente
echo -e "\n***** Comprobando que Flutter esté funcionando correctamente\n *****"

flutter --version
#Controlamos si todo salio OK
checkForFail "***** ERROR: el comando flutter --version falló *****"
echo -e "************************** OK ************************** \n\n\n"

echo -e "\n Flutter Running !"

#Agregamos el usuario al grupo plugdev
echo -e "***** Añadiendo el usuario $USER al grupo plugdev*****  \n " 
sudo usermod -a -G plugdev $USER

#Controlamos si todo salio OK
checkForFail "***** ERROR: Añadir usuario al grupo falló *****  "
echo -e "************************** OK ************************** \n\n\n"


#Añadimos el archivo necesario para el reconocimiento de los distintos telefonos
echo -e "*****  Cargando datos a archivo en /etc/udev/rules.d/51-android-rules*****  \n" 
#Llamamos al script necesario
sudo ./configuracionUSB.sh
















