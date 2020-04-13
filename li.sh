#!/bin/bash -ex
clear
# ruta=$1
ruta_local=$(pwd)
ruta_dive_local="${HOME}/.Mydrive2";
vacija="ENLACES_COPIA.txt"
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")


function unicaUrl()
{
    cd $ruta_dive_local && drive copy -id $ID "${ruta}"; cd $ruta_local;

    FILENAME=$(wget -q --show-progress -O - "https://drive.google.com/file/d/${ID}/view" | sed -n -e 's!.*<title>\(.*\)\ \-\ Google\ Drive</title>.*!\1!p')
    rclone copy midrivefull:/"${ruta}/${FILENAME}" drive7:/Movies/ -P;
    link=$(rclone link drive7:/Movies/${FILENAME});
    echo $FILENAME
    echo $link
    echo 
    echo $FILENAME >> $vacija;
    echo $link >> $vacija;
    echo " " >> $vacija;
}

function variasUrl()
{
    name=($(rclone lsf midrivefull:/"${ruta}"));

    for VAR in "${name[@]}"
    do
        rclone copy midrivefull:/"${ruta}/${VAR}" drive7:/Movies/ -P;
        link=$(rclone link drive7:/Movies/${VAR});
        echo $VAR
        echo $link
        echo 
        echo $VAR >> $vacija;
        echo $link >> $vacija;
        echo " " >> $vacija;
    done
}
function ayuda()
{
    echo "Indicar argumentos [-i][id google drive] [-r][ruta de la carpeta google drive] [-P][parametro la indicar la cantidad de enlaces]"
}


while getopts "i:r:P:h:" optname
  do
    case "$optname" in
        "i")
            ID=$OPTARG;
            ;;
        "r")
            ruta=$OPTARG;
            ;;
        "P")
            URL_UNICA=1
            ;;
        "h")
            ayuda
            ;;
        "?")
            echo "Opción desconocida $OPTARG"
            ;;
        ":")
            echo "Sin valor de argumentos para la opción $OPTARG"
            ;;
        *)
            echo "Error desconocido mientras se procesaban las opciones"
            ;;
        esac
done

case $URL_UNICA in
    1) unicaUrl
    ;;
    2|3) echo 2 or 3
    ;;
    *) echo default
    ;;
esac


IFS=$SAVEIFS
