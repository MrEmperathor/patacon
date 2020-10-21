#!/bin/bash
# clear
[[ "$@" ]] && FOLDER=$1 || exit

# ARCHIVOJSON="/var/local/accion.json"

rclone lsjson midrivefull:/"${1}" > "/var/local/${1}.json"

ARCHIVOJSON="/var/local/${1}.json"


msg()
{
    BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
    AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
    case $1 in
    -ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -pur) cor="${MAGENTA}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
    -azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -red) cor="${VERMELHO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -bla) cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -bar2) cor="${AZUL}${NEGRITO}======================================================" && echo -e "${cor}${SEMCOR}";;
    -bar) cor="${AZUL}${NEGRITO}========================================" && echo -e "${cor}${SEMCOR}";;
    esac
}
comprarSize ()
{
    local SIZE=$1
    
    let SA=$SIZE/1024/1024
    [[ $SA -ge 2000 ]] && echo "$SA" || echo "n"
}

n=1
while true; do
    json1=$(cat $ARCHIVOJSON | jq -r '.['${n}']')
    Size=$(echo $json1 | jq -r '.Size')
    NameOriginal=$(echo $json1 | jq -r '.Name'); Name=${NameOriginal^^}; Name=${Name%.*}
    msg -verm "$Name"
    PASAONO=$(comprarSize $Size)

    if [[ $PASAONO != "n" ]]; then
        msg -ama "TAMAÑO ACEPTABLE: $PASAONO MB"

        rclone copy midrivefull:/"${1}/${NameOriginal}" . -P 
        echo "subiendo..."
        de2 -n "$Name" -i "CASTELLANO" -c 1080 -K 1080 -t 475557${n}; 
    else
        msg -pur "MUY PEQUEÑO"
    fi
    
    ((n++))
    msg -azu "vuelta numero $n"
    sleep 2
    # [[ $n == 5 ]] && exit; 
done

