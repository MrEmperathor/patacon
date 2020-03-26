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