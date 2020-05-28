function SubidaDriveFreeVip()
{
    local file=${1}
    local __enlace_salida=${2}
    local CUENTA=${3}

    rclone copy "${file}" -P ${CUENTA}:/
    link=$(rclone link ${CUENTA}:/"${file}")
    ERRLINK=$?
    if [[ $ERRLINK != 0 ]]; then
        until [[ $ERRLINK = 0 ]]; do
            msg -verd "Volviendo a intentar"
            link=$(rclone link ${CUENTA}:/"${file}")
            ERRLINK=$?
            sleep 3
        done
    fi
    [[ $link ]] && eval $__enlace_salida="'$link'"
}
function Acort()
{
    local link_r=${1}
    local script=${2}
    local _embase=${3}
    local buscar_pat=${4}
    local link=""

    until [[ $link_s =~ $buscar_pat ]]; do
        link_s=$($script $link_r)
    done
    [[ $link_s ]] && eval $_embase="'$link_s'"
}

function QuitarPermisos()
{
    local link=${1}
    ID=$(echo $link | awk -F "=" '{printf $2}')
    volerXd=$(pwd)
    cd $RCOPY2 && drive pub -id "$ID"; drive unpub -id "$ID"; cd $volerXd
}
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

    if [[ -f $file ]];then
        if [[ $dato == "mega" ]];then
            local file=".megallin.txt"
            until [[ $link =~ "$dato" ]]; do
                $script "$file" link 
                echo "intentado forzar subida $dato. INTENTO # $nm"
                ((nm++))
                sleep 5
                [[ $nm -gt 10 ]] && sleep 30;
            done
        elif [[ $dato == "gdfree" || $dato == "gdvip" ]];then
            local cuenta=${DRIVE3}
            local dato_a_encontrar="drive.google.com"
            local vipfree=true
            [[ $dato == "gdvip" ]] && local vip=true && local cuenta=${DRIVE2} && local vipfree=false
            
            
            until [[ $link =~ "$dato_a_encontrar" ]]; do
                $script "$file" link $cuenta
                echo "intentado forzar subida $dato. INTENTO # $nm"
                ((nm++))
                sleep 5
                [[ $nm -gt 10 ]] && sleep 30;
            done
            [[ $vipfree == true ]] && id_link=$(echo $link | awk -F "=" '{printf $2}') && link="https://drive.google.com/uc?id=${id_link}&export=download"
            [[ $vip ]] && QuitarPermisos $link
        else
            until [[ $link =~ "$dato" ]]; do
                myresult=$($script "$file" 2>/dev/null)
                link=${myresult}
                echo "intentado forzar subida $dato. INTENTO # $nm"
                ((nm++))
                sleep 5
                [[ $nm -gt 10 ]] && sleep 30;
            done
        fi
        eval $__salida="'$link'"
    else
        echo "La pelicula no existe!"
    fi
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

# SERVIDORES

function ServidorAll()
{
    local file="${1}"
    local link="${2}"
    local dato="${3}"
    local script=${4}
    local ID_DB_PELI=${5}
    local scriptDB="/usr/local/bin/php/funtions/./actualizarEnlacesDB.php"
    case $script in
        "hqq.tv") script=${SNetu}
        ;;
        "jetload") script=${SJetload}
        ;;
        "uptobox") script=${Uptoboxx}
        ;;
        "gounlimited") script=${Sgoun}
        ;;
        "mega") script=subida_mega
        ;;
        "gdfree"|"gdvip") script=SubidaDriveFreeVip
        ;;
        *) echo default
        ;;
    esac
    # echo "file: $file"
    # echo "link: $link"
    # echo "dato: $dato"
    # echo "script: $script"
    # echo "ID_DB_PELI: $ID_DB_PELI"
    # read -p "LISTOOOO"
    # Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT" https://short.pe/ccakQ
    comprobarEstadoNetu "$file" "$link" "$dato" "$script" linkSalida
    [[ $dato == "mega" ]] && Acort $linkSalida $SSHORT link_acortado_short "short.pe" && echo "Enlace acortado: $link_acortado_short" && $scriptDB $ID_DB_PELI $link_acortado_short
    [[ $dato == "gdfree" ]] && Acort $linkSalida $SOUO link_acortado_ouo "ouo.io" && echo "Enlace acortado: $link_acortado_ouo" && $scriptDB $ID_DB_PELI $link_acortado_ouo

    [[ $linkSalida ]] && echo "Subido y actualizado correctamente --> $dato: $linkSalida"
    [[ $linkSalida ]] && $scriptDB $ID_DB_PELI $linkSalida


}

function contiene() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}
