#!/bin/bash
function checkForFail(){
    if [ "$?" != "0" ]; then
        echo -e $1 1>&2 #Redirecciona stdout a stderror
        $2 $3 $4 $5 #Para realizar tareas a parte
        exit 1
    fi
}

sudo cat 51-android-ORIGINAL.rules > /etc/udev/rules.d/51-android.rules

#Controlamos si todo salio OK
checkForFail "***** ERROR: modificar el archivo /etc/udev/rules.d/51-android-rules falló, comprobar que exista el directorio ***** \n"
echo -e "************************** OK ************************** \n\n\n"
