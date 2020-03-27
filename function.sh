function obtenerIdGdrive()
{
    local id
    
    id=$(php /var/www/html/panel/inc/comp/parse_url.php "${1}")
    echo "${id}"
}
function comprobarEstadoNetu(){
    local file="${1}"
    local link="${2}"
    local dato="${3}"
    local script=${4}
    local __salida=${5}
    local myresult

    local nm=1
    until [[ $link =~ "$dato" ]]; do
        myresult=$($script "$file" 2>/dev/null)
        link=${myresult}
        echo "intentado forzar subida. INTENTO # $nm"
        ((nm++))
        sleep 30
        [[ $nm -gt 10 ]] && sleep 30;
    done
    eval $__salida="'$link'"
}
respaldoDrivePelis()
{
    rclone copy "${ruta_drive}/${MiPeli}" ${RESPALDO}:/Movies
    backup_url=$(rclone link ${RESPALDO}:/Movies/"${MiPeli}")
}

function respaldoDriveSeries()
{   
    unset _namef; unset enlaces_free_backup;
    local _namef
    local RD
    local R_SERIE
    local DRIVER

    RD="${1}"; 
    R_SERIE="${2}";
    DRIVER="${RESPALDO}"
    

    rclone copy "${RD}/${R_SERIE}" -P ${DRIVER}:/"${FOLDER_SERIE}/${R_SERIE}"
    _namef=($(rclone lsf ${DRIVER}:/"${FOLDER_SERIE}/${R_SERIE}"))
    a=0
    for i in "${_namef[@]}"
    do
        enlaces_free_backup[$a]=$(rclone link ${DRIVER}:/"${FOLDER_SERIE}/${R_SERIE}/${i}")
        ((a++))
    done
}

function respaldoBackup()
{
    local ruta
    local id
    local FILENAME
    local link
    local retorno
    ruta=$(pwd)
    id=$(obtenerIdGdrive "${1}")
    retorno=${2}

    echo "el id es: ${id}"

    cd /root/.Mydrive2 && drive copy -id ${id} "${FOLDER_RESPALDO_CUENTA_ILIMITADA}";
    FILENAME=$(wget -q --show-progress -O - "https://drive.google.com/file/d/${id}/view" | sed -n -e 's!.*<title>\(.*\)\ \-\ Google\ Drive</title>.*!\1!p')
    rclone copy ${MI_CUENTA_ILIMIADA}:/"${FOLDER_RESPALDO_CUENTA_ILIMITADA}/${FILENAME}" ${RESPALDO}:/Movies/ -P
    link=$(rclone link ${RESPALDO}:/"Movies/${FILENAME}");
    link=$(echo $link | awk -F "=" '{print $2}')
    # echo ${link};
    link="https://drive.google.com/open?id=${link}"
    eval $retorno="'$link'"
    cd $ruta;
}

function agregarRespaldoBd()
{
    local link
    local admin
    local id_unico
    id_unico=${1}
    link=${2}
    admin=${3}

    echo "ruta donde se add: ${includeRuta}./serializar.php ${link}"
    backup_url=$(${includeRuta}./serializar.php "${link}")
    /usr/local/bin/php/./agregar.php "${id_unico}" "${backup_url}" "${admin}"
    
    
}