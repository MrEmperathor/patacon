#!/bin/bash
clear

ruta_json=/var/local
name_folder_gd="${ruta_json}/name_carpeta_google.db"


if [[ "$@" ]]; then
    id_enlace=$1
    nameFolder=$2
    
    if [[ $nameFolder ]]; then
        rclone lsjson midrivefull:/"${nameFolder}" > "${ruta_json}/${nameFolder}.json"
        # rutaCompletaJson="${ruta_json}/${nameFolder}"
        echo $nameFolder > "${name_folder_gd}"
    else
        nameFolder=$(cat "${name_folder_gd}")
    fi

else
    echo "!!ESPESIFIQUE UN ARGUMENTO.."
    exit
fi

# if [[ $nameFolder ]]; then

    # rclone lsjson midrivefull:/"${nameFolder}" > "${ruta_json}/${nameFolder}.json"
# else
    # nameFolder=$(cat "$name_folder_gd")
    jsonn="${ruta_json}/${nameFolder}.json"
    Name=$( cat "$jsonn" | grep -i "${id_enlace}" | jq -r '.Name' 2>/dev/null)
    echo "$Name"
    rclone copy midrivefull:/"${nameFolder}/${Name}" . -P
# fi

