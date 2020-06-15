#!/bin/bash
n_pagina=$1
id_carpeta="558104606"
uhash="d9ac4b4e384bdf5c"

#url para consulltar carpetas

nn=0
salir=1
i=0
datost=''
until [[ $i -eq ${n_pagina}0 ]]; do

    url_carpeta="https://uptobox.com/api/user/public?folder=${id_carpeta}&hash=${uhash}&limit=10&offset=${i}"
    salida_json=$(curl ${url_carpeta})

    cantidad_one=$(echo ${salida_json} | jq ".data.list[]" | wc -l)
    let s=20*${cantidad_one}/100
    echo "cantidad de pelis: $s"
    
    datos=""
    until [[ $nn -eq $s ]]; do
        
        file_code=$(echo ${salida_json} | jq -r ".data.list[$nn].file_code")
        file_name=$(echo ${salida_json} | jq -r ".data.list[$nn].file_name")

        salida_json2=$(curl "https://uptobox.com/api/link/info?fileCodes=${file_code}")
        file_size=$(echo ${salida_json2} | jq -r ".data.list[0].file_size")


        let peso=${file_size}/1000000
        [[ $peso -ge 2000 ]] && echo "NOMBRE: $file_name, PESO: ${peso}MB, ENLACE: https://uptobox.com/${file_code}" >> 2000.txt
        datos="${datos} NOMBRE: $file_name, PESO: ${peso}MB, ENLACE: https://uptobox.com/${file_code}\n";
        echo -e "${datos}" >> todos.txt
        ((nn ++)); ((salir ++))
    done
    datost="${datost} Fila #${i}\n ${datos}\n"
    nn=0
    salir=1
    let i=$i+10
done
echo -e "${datost}"