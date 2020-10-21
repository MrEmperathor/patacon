format_suport=("flv" "avi" "rmvb" "mkv" "mp4" "wmv" "mpeg" "mpg" "mov" "divx" "3gp" "xvid" "asf" "rm" "dat" "m4v" "f4v" "webm" "ogv" "rar" "zip")
includeRuta='/var/www/html/panel/inc/include/';
ruta_Home=$(pwd)
BLANCOF='\033[47m'; RED='\033[0;31m'; REDCLARO='\033[1;31m'; AZUL='\033[0;34m'; AZULCLARO='\033[1;34m'; VERDE='\033[0;32m'; VERDECLARO='\033[1;32m'; CYAN='\033[0;36m'; CYANCLARO='\033[1;36m'; PURPURA='\033[0;35m'; PURPURAC='\033[1;35m'; CAFE='\033[1;37m'; AMARILLO='\033[1;33m'; NC='\033[0m'; RFembed="/var/www/html/panel/inc/include/fembed.php"; RNetu="/var/www/html/panel/inc/include/netu1.php"; SFembed="/var/www/html/panel/inc/include/fembed/./fembed_final.php"; SNetu="/var/www/html/panel/inc/include/./netu1.php"; Rvery="/var/www/html/panel/inc/include/./very.php"; SJetload="/var/www/html/panel/inc/include/./jetload.php"; Uptoboxx="/var/www/html/panel/inc/include/./uptobox.php"; Sgoun="/var/www/html/panel/inc/include/./gounlimited.php"; Sclicknupload="/var/www/html/panel/inc/include/./clicknupload.php"; Sdropapk="/var/www/html/panel/inc/include/./dropapk.php"; Sprostream="/var/www/html/panel/inc/include/./prostream.php"; Supstream="/var/www/html/panel/inc/include/./upstream.php"; Smystream="/var/www/html/panel/inc/include/./mystream.php"; SSHORT="/var/www/html/panel/inc/include/./short.php"; SOUO="/var/www/html/panel/inc/include/./ouo.php"; CONFIG="/usr/local/bin/config.ini"; CONFIGGLOBAL="/var/www/html/panel/inc/config.php"; barraAzul="\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"; ruta_drive=$(pwd)
descargarDeFolderGoogleDrive ()
{
    ruta_json=/var/local
    name_folder_gd="${ruta_json}/name_carpeta_google.db"


    if [[ "$@" ]]; then
        id_enlace=$1
        nameFolder=$2
        
        if [[ $nameFolder ]]; then
            rclone lsjson midrivefull:/"${nameFolder}" > "${ruta_json}/${nameFolder}.json"
            echo $nameFolder > "${name_folder_gd}"
        else
            nameFolder=$(cat "${name_folder_gd}")
        fi

    else
        echo "!!ESPESIFIQUE UN ARGUMENTO.."
        exit
    fi

        jsonn="${ruta_json}/${nameFolder}.json"
        Name=$( cat "$jsonn" | grep -i "${id_enlace}" | jq -r '.Name' 2>/dev/null)
        echo "$Name"
        rclone copy midrivefull:/"${nameFolder}/${Name}" . -P
}
function ComprobarRuta()
{
    local name="${1}"
    local salida="${2}"
    local vipt="/var/local/vipt.txt"
    local freet="/var/local/freet.txt"
    local teamt="/var/local/teamt.txt"
    local devolver_ruta=$(pwd)

    [[ $name ]] && local ruta=$(cat $vipt | grep "${name}" | head -n 1) && remote="vip_kolitas_todas"
    [[ ! $ruta ]] && local ruta=$(cat $freet | grep "${name}" | head -n 1) && remote="free_nike90al_todas"
    [[ ! $ruta ]] && local ruta=$(cat $teamt | grep "${name}" | head -n 1) && remote="team_vip_todas" && team_r=true
    
    echo $ruta;
    if [[ ${ruta::1} == ' ' ]];then
        local rta=$(echo $ruta | cut -d' ' -f2-);
    elif [[ $team_r ]];then
        local rta=$(echo $ruta);
    else
        local rta=$(echo $ruta | cut -d' ' -f2-);
    fi


    rclone copy -P ${remote}:/"${rta}" Result
    cd Result; mv * ${devolver_ruta}; cd "${devolver_ruta}"; rm -rf Result

    eval $salida="'$rta'"



    #  local id=${1}
    # local salida=${2}
    # local ruta=4(pwd)

    
    # cd /root/.Mydrive && local idu=$(drive pub -id "$id");
    # [[ ${idu} ~= 'Error 404' ]] && cd /root/.Mydrive && local idu=$(drive pub -id "$id");

}

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
                # $script "$file" 2>/dev/null
                link=${myresult}
                echo "intentado forzar subida $dato. INTENTO # $nm"
                ((nm++))
                sleep 5
                [[ $nm -gt 10 ]] && sleep 30;
                [[ $nm -eq 50 ]] && exit;
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
    local scriptDB="/usr/local/bin/php/./actualizarEnlacesDB.php"
    case $script in
        "hqq.to") script=${SNetu}
        ;;
        "jetload") script=${SJetload}
        ;;
        "uptobox") script=${Uptoboxx}
        ;;
        "gounlimited") script=${Sgoun}
        ;;
        "mega") script=subida_mega
        ;;
        "mystream") script=${$Smystream}
        ;;
        "fembed") script=${SFembed}
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
    echo "Subiendo a $dato"
    comprobarEstadoNetu "$file" "$link" "$dato" "$script" linkSalida
    [[ $dato == "mega" ]] && Acort $linkSalida $SSHORT link_acortado_short "short.pe" && echo "Enlace acortado: $link_acortado_short" && $scriptDB $ID_DB_PELI $link_acortado_short "short.pe" 2>/dev/null
    [[ $dato == "gdfree" ]] && Acort $linkSalida $SOUO link_acortado_ouo "ouo.io" && echo "Enlace acortado: $link_acortado_ouo" && $scriptDB $ID_DB_PELI $link_acortado_ouo "ouo.io" 2>/dev/null

    [[ $linkSalida ]] && echo "Subido y actualizado correctamente --> $dato: $linkSalida"
    [[ $linkSalida ]] && $scriptDB $ID_DB_PELI $linkSalida $dato 2>/dev/null


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

function EliminarSubtitulos()
{ 
    local MiPeli=$1
    SIHAY=$(ffmpeg -i "$MiPeli" 2>&1 | grep -i Subtitle | wc -l)
    if [[ $SIHAY != 0 ]];then
        mkvmerge -o sin_sub.$MiPeli --no-subtitles $MiPeli; 
        [[ -e sin_sub.$MiPeli ]] && rm $MiPeli
        mv sin_sub.$MiPeli $MiPeli
        msg -ama "Subtitulos Borrados"
    else
        msg -ama "No hay subtitulos para eliminar"
    fi
}

# SERVIDORES

function plantilla() {

    local admin_db="$1"
    local backupp="$2"
    IP=$(curl https://api.ipify.org/)
    FTPLOG=.ftplogfileStrem
    FTPLOG1=.ftplogfileCherry
    LINKMANGOHTML=$(cat $FTPLOG | awk -F "URL: " '{printf $2}')
    LINKCHERRYHTML=$(cat $FTPLOG1 | awk -F "URL: " '{printf $2}')
    LINK_STREAM2_DIRECTO=$(cat .linkgd-2)
    ENLACESABIERTOS=$(cat $RUTA2/GD_$MiPeli.txt)
    URLVIP=$(urlencode "http://$IP/de/.enlaces/VIP:_$MiPeli.txt")
    URLFREE=$(urlencode "http://$IP/de/.enlaces/ZFREE:_$MiPeli.txt")
    MiPeliDecode=$(urlencode "$MiPeli")
    if [[ $opcion = 5 ]]; then
        NEWFILEN=$(echo "${NEWFILEN}_${CALIDA1}_$IDIOMA1.720")
    else
        NEWFILEN=$(echo "${NEWFILEN}_${CALIDA1}_$IDIOMA1")
    fi

    NameOrigi=$(urlencode "$NEWFILEN")
    NEWMEGALPHP1=$(urlencode "$MEGALPHP")
    FembedLink=$(cat .fembedlink)
    netuTV=$(cat .netu)
    pwd=$(pwd)

    exten=${MiPeli#*.}

    drivecri=$(echo $LGDDRIVE2PHP | awk -F "id=" '{print $2}')
    drivecri2=$(echo $LGDVIPPHP | awk -F "id=" '{print $2}')
    drivecri3=$(echo $LINK_STREAM2_DIRECTO | awk -F "id=" '{print $2}')

    array=($UrlVerystream $UrlNetu $LGDVIPPHP $LGDPHP $MEGALPHP $MEGALPHP1 $LGDPHP1 $UrlJetload $UrlFembed $UrlUotobox $UrlGounlimited  $UrlClicknupload $UrlDropapk $UrlProstream $UrlUpstream $UrlMystream)
    arraydescarga=($UrlVerystream $MEGALPHP $LGDPHP $MEGALPHP1 $LGDPHP1)

    descarga=$(/var/www/html/panel/inc/include/./file.php "${arraydescarga[@]}")
    enlaces_pre=$(/var/www/html/panel/inc/include/./serializar.php "${array[@]}")

    /var/www/html/panel/inc/xion/./agregar.php $enlaces_pre $bid "$admin_db" "${backupp}"

    rm ${ruta_Home}/*
}

function DatosGD 
{
    CGD2=$1; LINKT=$2; errorG=$3
    if [[ $errorG = 0 ]]; then
        echo -e "\n "
        echo -e "\033[1;36mSubido correctamente a\033[0m \033[1;33m$CGD2\033[0m"
        echo -e "\033[1;33mLINK\033[0m"
        LGDD=$(cat $LINKT | awk -F "=" '{printf $2}')
        cat $LINKT
        # LGDD=$(cat $LINKT | awk -F "=" '{printf $2}') ; echo "https://drive.google.com/uc?id=$LGDD&export=download"
        echo -e "\033[1;31m=====================================\033[0m"

        if [[ $CGD2 == "DRIVE FREE" ]];then
            LGDPHP="https://drive.google.com/uc?id=$LGDD&export=download"; LINK_STREAM2_DIRECTO=$(cat $LINKT)
            echo $LGDPHP > $fifoDriveFree
        fi

        if [[ $CGD2 == "GD-VIP" ]];then
            LGDVIPPHP=$(cat $LINKT)
            volerXd=$(pwd)
            cd $RCOPY2 && drive pub -id "$LGDD"; drive unpub -id "$LGDD"; cd $volerXd
            
            if [[ $COPIAGD2 == true ]];then
                cd $RCOPY2 && drive copy -id "$LGDD" "$NAMEBINDERCOPY"; sleep 2s
                drive pub ${NAMEBINDERCOPY}/"${MiPeli}"
                newlink=$(rclone link newdrive:/"$MiPeli")
                # newlink=$(drive pub FilesBackups/"$MiPeli" | awk  -F "published on" '{print $2}')
                export IDBACKUUP=$(echo $newlink | awk -F "=" '{print $2}')
                drive pub VIP/"$MiPeli"
                drive unpub -id "$LGDD"
                cd $volerXd
            fi
        fi
    else 
        echo -e "\033[1;36mVIDA TRISTE OCURRIO UN ERROR\033[0m \033[1;33m$CGD2\033[0m :("
    fi
}

function definnirFifo()
{
    puesto=$(pwd | cut -d "/" -f7)
    fifo="/tmp/fifo${puesto}very"
    [[ -e $fifo ]] && rm $fifo
    fifo1="/tmp/fifo${puesto}fembed"
    [[ -e $fifo1 ]] && rm $fifo1
    fifo2="/tmp/fifo${puesto}netu"
    [[ -e $fifo2 ]] && rm $fifo2
    fifo3="/tmp/fifo${puesto}jetload"
    [[ -e $fifo3 ]] && rm $fifo3
    fifo4="/tmp/fifo${puesto}uptobox"
    [[ -e $fifo4 ]] && rm $fifo4
    fifo5="/tmp/fifo${puesto}gounlimited"
    [[ -e $fifo5 ]] && rm $fifo5
    fifo6="/tmp/fifo${puesto}Clicknupload"
    [[ -e $fifo6 ]] && rm $fifo6
    fifo7="/tmp/fifo${puesto}Dropapk"
    [[ -e $fifo7 ]] && rm $fifo7
    fifo8="/tmp/fifo${puesto}Prostream"
    [[ -e $fifo8 ]] && rm $fifo8
    fifo9="/tmp/fifo${puesto}Upstream"
    [[ -e $fifo9 ]] && rm $fifo9
    fifo10="/tmp/fifo${puesto}Mystream"
    [[ -e $fifo10 ]] && rm $fifo10
    fifoDriveFree="/tmp/fifo${puesto}GDFREE"
    [[ -e $fifoDriveFree ]] && rm $fifoDriveFree
    fifoMega="/tmp/fifo${puesto}MEGA"
    [[ -e $fifoMega ]] && rm $fifoMega   
}

function EnlacesMostar()
{
    UrlVerystream=$(< $fifo)
    echo $UrlVerystream
    UrlFembed=$(< $fifo1)
    echo $UrlFembed
    UrlNetu=$(< $fifo2)
    echo $UrlNetu
    UrlJetload=$(< $fifo3)
    echo $UrlJetload
    UrlUotobox=$(< $fifo4)
    echo $UrlUotobox
    UrlGounlimited=$(< $fifo5)
    echo $UrlGounlimited
    UrlClicknupload=$(< $fifo6)
    echo $UrlClicknupload
    UrlDropapk=$(< $fifo7)
    echo $UrlDropapk
    UrlProstream=$(< $fifo8)
    echo $UrlProstream
    UrlUpstream=$(< $fifo9)
    echo $UrlUpstream
    UrlMystream=$(< $fifo10)
    echo $UrlMystream
    LGDPHP=$(< $fifoDriveFree)
    echo $LGDPHP
    MEGALPHP=$(< $fifoMega)
    echo $MEGALPHP
}

function MostarEnlaces()
{
    SERVIDOR=$1; LINKS=$2; ERRORS=$3

    if [[ $ERRORS -eq 0 ]]; then
        echo -e "\n "
        echo -e "\033[1;36mSubido correctamente a\033[0m \033[1;34m$SERVIDOR\033[0m"
        echo -e "$LINKS"
        echo -e "\033[1;31m=====================================\033[0m"
    else
        echo -e "\n "
        echo -e "\033[1;36mVIDA TRISTE NO SE SUBIO\033[0m \033[1;34m$SERVIDOR\033[0m :("

    fi
}

function subida_o_s_s_720() 
{
    definnirFifo
    PP=1

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMYSTREAM\033[0m"
        mystream &
        sleep 2

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mFEMBED\033[0m"
        fembed &
        sleep 2

        # echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGOUNLIMITED\033[0m" 
        # Gounlimited &
        # sleep 2

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD-VIP\033[0m"
        drive22

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD FREE\033[0m" 
        respaldoDrivePelis
        drive33
    
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMEGA\033[0m" 
        subida_mega .megallin.txt

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $LGDPHP $SOUO LGDPHP1 "OUO"
    
}

function subida_o_s_s_720p() 
{
    definnirFifo
    PP=1

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mNETU\033[0m"
        netu &
        sleep 2

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMYSTREAM\033[0m"
        mystream &
        sleep 2

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mFEMBED\033[0m"
        fembed &
        sleep 2

        # echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGOUNLIMITED\033[0m" 
        # Gounlimited &
        # sleep 2

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD-VIP\033[0m"
        drive22

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD FREE\033[0m" 
        respaldoDrivePelis
        drive33
    
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMEGA\033[0m" 
        subida_mega .megallin.txt

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"

        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $LGDPHP $SOUO LGDPHP1 "OUO"
    
}

function subida_o_s_s() 
{
    definnirFifo
    PP=1

    if [[ $ESTADOOPENLOAD == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOPENLOAD\033[0m"
        subi1 &
        sleep 2
    fi
    
    if [[ $ESTADOVERYSTREAM == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mVERYSTREAM\033[0m"
        Verystream &
        sleep 2
    fi

    if [[ $ESTADOFEMBED == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mFEMBED\033[0m"
        fembed &
        sleep 2
    fi
    
    if [[ $ESTADONETU == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mNETU\033[0m"
        netu &
        sleep 2
    fi

    if [[ $ESTADOJETLOAD == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mJETLOAD\033[0m"
        jetload &
        sleep 2
    fi
    if [[ $ESTADOUPTOBOX == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mUPTOBOX\033[0m"
        Uptobox1 &
        sleep 2
    fi

    if [[ $ESTADOGOUNLIMTED == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGOUNLIMITED\033[0m" 
        Gounlimited &
        sleep 2
    fi

    if [[ $ESTADOClicknupload == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mCLICKNUPLOAD\033[0m" 
        Clicknupload &
        sleep 2
    fi

    if [[ $ESTADODropapk == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mDROPAPK\033[0m"
        Dropapk &
        sleep 2
    fi

    if [[ $ESTADOProstream == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mPROSTREAM\033[0m"
        Prostream &
        sleep 2
    fi

    if [[ $ESTADOUpstream == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mUPSTREAM\033[0m"
        Upstream &
        sleep 2
    fi

    if [[ $ESTADOMystream == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMYSTREAM\033[0m"
        mystream &
        sleep 2
    fi

    if [[ $ESTADODRIVEVIP == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD-VIP\033[0m"
        drive22
    fi

    if [[ $ESTADODRIVEFREE == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD FREE\033[0m" 
        respaldoDrivePelis
        drive33
    fi
    if [[ $ESTADODRIVEFREE == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $LGDPHP $SOUO LGDPHP1 "OUO"
    fi
    
    if [[ $ESTADOMEGA == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMEGA\033[0m" 
        subida_mega .megallin.txt
    fi
    if [[ $ESTADOMEGA == true ]];then
        echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
        Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"
    fi

    
}

function SoloMega()
{
    definnirFifo

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMEGA\033[0m" 
    subida_mega .megallin.txt
    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
    Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"
}

function subida_mega() {
    local __LINK_RAPIDO=${2}
    for FICHERO_mega in `ls *.mp4 *.avi *.mkv *.mpg`; do
        echo $FICHERO_mega
    done 2>/dev/null

    RUTAMEGA=$(pwd); MEGARC=/root/.megarc; MEGARC2=/root/megarc2
    listamega=/var/local/listamega
    listamega1=/var/local/listamega1
    lismega=/var/local/lismega
    SUBIDO="Uploaded $FICHERO_mega"
    CUENTALIMITE="EOVERQUOTA"
    NOLINKS=$(echo "ERROR: No files specified for upload!")
    MEGALIMIT="ERATELIMIT"
    MEGALIMIT3="File already exists"
    MEGALIMIT2="Invalid upload handle"
    ERRORCUENTA="ENOENT"
    RUTA2="/var/www/html/de/.enlaces"
    TOTAL=$(megadf -h | sed -n '1p' | awk '{printf $1}')
    A=1
    #megaput $FICHERO_mega --reload -u $USR4 -p $PSW4
    CMEGA=$(cat /root/.megarc | sed -n '2p' | awk -F " " '{printf $3}')
    PMEGA=$(cat /root/.megarc | sed -n '3p' | awk -F " " '{printf $3}')
    MEGA_Links=${1}
    function LinkMegaDOWN() {

        megals -e /Root/$FICHERO_mega -u $CMEGA -p $PMEGA > $MEGA_Links ; #echo -e "\n " >> $RUTA2/GD_$MiPeli.txt
            if [[ $MEGA_Links == ".megallin.txt" ]]; then
                MEGALPHP=$(cat $MEGA_Links | awk -F " " '{printf $1}')
                [[ $__LINK_RAPIDO ]] && eval $__LINK_RAPIDO="'$MEGALPHP'"
            fi
            if [[ $MEGA_Links == ".linkmega720.txt" ]]; then
                MEGALPHP720=$(cat $MEGA_Links | awk -F " " '{printf $1}')
            fi
        
    }

    if [[ -f $FICHERO_mega ]]; then
        echo -e "\033[1;31m=================================================\033[0m"
        #megaput $FICHERO_mega 2>&1 | tee .megalog; sed '1d' .megalog > .megalog1; MEGALOG=$(cat .megalog1.txt)
        megaput $FICHERO_mega --debug=cache 2>&1 | tee $RUTAMEGA/.megalog
        LinkMegaDOWN
        ERRORM1=$?
        MEGALOG=$(grep "EOVERQUOTA" $RUTAMEGA/.megalog)

        ERRORM=$(cat .megalog | grep "Uploaded" | wc -l)
        #errormega=$?

    else
            echo -e "\033[1;31m=================================================\033[0m"
            echo "\033[1;31mNO HAY NADA PARA MEGA :V\033[0m"
    fi


        if fgrep "$CUENTALIMITE" $RUTAMEGA/.megalog ;then
        #if [[ $MEGALOG = $CUENTALIMITE ]]; then
                    MEGAESP1="Free:  0 bytes"
                    MEGAESP=$(megadf --human | sed -n '3p')
                    
                        while [[ $MEGAESP = $MEGAESP1 ]]; do
                            
                            MEGAESP=$(megadf --human | sed -n '3p')
                                while read line 
                                do
                                    
                                    echo "$line" > "$listamega$A"; CUENTAMEGA=$(cat "$listamega$A")
                                    let A++
                                    echo
                                    echo -e "\033[1;32mCUENTA LLENA...PASAREMOS A LA CUENTA $CUENTAMEGA EN UN MOMENTO!! :)\033[0m"
                                    sleep 3

                                    sed '2d' $MEGARC > $MEGARC2; sed -i "2i Username = $CUENTAMEGA" $MEGARC2; rm -rf $MEGARC; mv $MEGARC2 $MEGARC
                                    sleep 1
                                    UPDATECUENTA=$(cat $MEGARC | sed -n '2p' | awk -F " " '{printf $3}')
                                    MEGAESP=$(megadf --human | sed -n '3p')
                                        if [[ $MEGAESP != $MEGAESP1 ]]; then
                                            echo -e "\033[1;36mPERFECTO LA CUENTA \033[1;31m$UPDATECUENTA\033[0m ESTA DISPONIBLE!\033[0m"
                                            break
                                        fi

                                done < "$listamega"
                            #sed -n "$Ap" $listamega > $listamega1; CUENTAMEGA=$(cat "$listamega1")
                            sleep 3
                            CMEGA=$(cat /root/.megarc | sed -n '2p' | awk -F " " '{printf $3}')
                            PMEGA=$(cat /root/.megarc | sed -n '3p' | awk -F " " '{printf $3}')
                            megaput $FICHERO_mega --debug=cache 2>&1 | tee .megalog; MEGALOG=$(grep "EOVERQUOTA" $RUTAMEGA/.megalog)
                            LinkMegaDOWN
                            ERRORM1=$?
                            ERRORM=$(cat .megalog | grep "Uploaded" | wc -l)
                            #sed '1d' $listamega > $lismega; rm -rf $listamega; mv $lismega $listamega
                        done
        fi
    if fgrep "$MEGALIMIT" $RUTAMEGA/.megalog ;then
        until [[ $SUBIDO = $MEGASUB ]]; do
            CMEGA=$(cat /root/.megarc | sed -n '2p' | awk -F " " '{printf $3}')
            PMEGA=$(cat /root/.megarc | sed -n '3p' | awk -F " " '{printf $3}')
            megaput $FICHERO_mega --debug=cache 2>&1 | tee $RUTAMEGA/.megalog
            LinkMegaDOWN
            if fgrep "$SUBIDO" $RUTAMEGA/.megalog ;then
                    MEGASUB=${SUBIDO}
                    echo "$MEGASUB"
                    break
            elif fgrep "$MEGALIMIT3" $RUTAMEGA/.megalog ;then
                    LinkMegaDOWN
                    MEGASUB=${SUBIDO}
                    echo "$MEGASUB"
                    break
            fi
        done
    fi
    if fgrep "$MEGALIMIT2" $RUTAMEGA/.megalog ;then
        until [[ $SUBIDO = $MEGASUB ]]; do
            CMEGA=$(cat /root/.megarc | sed -n '2p' | awk -F " " '{printf $3}')
            PMEGA=$(cat /root/.megarc | sed -n '3p' | awk -F " " '{printf $3}')
            megaput $FICHERO_mega --debug=cache 2>&1 | tee $RUTAMEGA/.megalog
            LinkMegaDOWN
            if fgrep "$SUBIDO" $RUTAMEGA/.megalog ;then
                    MEGASUB=${SUBIDO}
                    echo "$MEGASUB"
                    break
            fi
        done
    fi
    [[ $MEGALIMIT3 =~ $RUTAMEGA/.megalog ]] && LinkMegaDOWN

    if fgrep "$ERRORCUENTA"  $RUTAMEGA/.megalog ;then
        sed -i '2d' /root/.megarc
        while read line 
        do
                                    
            echo "$line" > "$listamega$A"; CUENTAMEGA=$(cat "$listamega$A")
            let A++
            echo
            echo -e "\033[1;32mERROR DE CUENTA...PASAREMOS A LA CUENTA $CUENTAMEGA EN UN MOMENTO!! :)\033[0m"
            sleep 3

            #sed '2d' $MEGARC > $MEGARC2; sed -i "2i Username = $CUENTAMEGA" $MEGARC2; rm -rf $MEGARC; mv $MEGARC2 $MEGARC
            sed -i "2i\Username = $CUENTAMEGA" /root/.megarc

            sleep 1
            #UPDATECUENTA=$(cat $MEGARC | sed -n '2p' | awk -F " " '{printf $3}')
            MEGAESP=$(megadf --human | sed -n '1p' | awk '{print $1}')
            echo -e "\033[1;36mPERFECTO LA CUENTA \033[1;31m$CUENTAMEGA\033[0m ESTA DISPONIBLE!\033[0m"
                if [[ $MEGAESP = "Total:" ]]; then  
                    while true ; do
                        megaput $FICHERO_mega --debug=cache 2>&1 | tee .megalog
                        sleep 2s
                        COMPROBAR=$(megals -e "/Root/${FICHERO_mega}" | awk -F ' /' '{print $2}')
                        if [[ $COMPROBAR == "Root/$FICHERO_mega" ]]; then
                            break
                        fi
                    done
                    break
                fi
            sed -i '2d' /root/.megarc

        done < "$listamega"

    fi


    if [[ $ERRORM = 1 ]]; then
            echo -e "\n "
            echo -e "\033[1;36mSubido correctamente a\033[0m \033[1;31mMEGA\033[0m"
            echo -e "\033[1;31m=====================================\033[0m"
            echo -e "\033[1;33mLINKS DE DESCARGA MEGA\033[0m"
            # megals -e /Root/$FICHERO_mega
            echo $MEGALPHP
            echo $MEGALPHP > $fifoMega
            echo -e "\033[1;36m=================================================\033[0m"
    fi
}

function subida_o_s_s_1080() 
{
    definnirFifo
    PP=1
    
    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mNETU\033[0m"
    netu &
    sleep 2

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD-VIP\033[0m"
    drive22

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mGD FREE\033[0m" 
    respaldoDrivePelis
    drive33

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mMEGA\033[0m" 
    subida_mega .megallin.txt

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mSHORT\033[0m" 
    Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mOUO\033[0m" 
    Acortadorr $LGDPHP $SOUO LGDPHP1 "OUO"
    Acortadorr $LGDPHP1 $SOUO LGDPHP1 "OUO"
    
}

function Verystream()
{
    vvery=$($Rvery $MiPeli) 
    errorVery=$?
    echo $vvery > $fifo

    MostarEnlaces "Verystream" $vvery $errorVery
}

function fembed()
{
   ruu=$(pwd)
   datos_fembed=$($SFembed $MiPeli)
   errorFembed=$?
   id_fembed_2=$(echo $datos_fembed | awk -F 'Fembed ID: ' '{print $2}')
   id_fembed=`echo $id_fembed_2 | sed 's/ *$//g'`
   script_F="https://fembed.com/f/${id_fembed}"
   echo $script_F > $fifo1

   MostarEnlaces "Fembed" $script_F $errorFembed
}
function netu()
{
    # for MiPeli in `ls *.mp4 *.mkv *.avi *.mpg` ; do echo $MiPeli; done &>/dev/null
    # for im in `ls *.mp4 *.mkv *.avi *.mpg`; do echo $im ; done &>/dev/null
    netuTV=$($SNetu "$MiPeli" 2>/dev/null)
        errornetu=$?
       echo $netuTV > $fifo2

    MostarEnlaces "Netu" $netuTV $errornetu
}
function jetload()
{
    jl=$($SJetload "${MiPeli}")
    errorJl=$?
    echo $jl > $fifo3

    MostarEnlaces "Jetload" $jl $errorJl
}
function Uptobox1()
{
    upt=$($Uptoboxx $MiPeli 2>/dev/null)
    errorUP=$?
    echo $upt > $fifo4

    MostarEnlaces "Uptobox" $upt $errorUP
}
function Gounlimited()
{
    ruu=$(pwd)
    gouTV=$($Sgoun "$MiPeli")
    errorGu=$?

    echo $gouTV > $fifo5
    MostarEnlaces "Gounlimited" $gouTV $errorGu
}

function Clicknupload()
{
    ruu=$(pwd)
    clicTV=$($Sclicknupload "$MiPeli")
    errorGu=$?

    echo $clicTV > $fifo6
    MostarEnlaces "Clicknupload" $clicTV $errorGu
}
function Dropapk()
{
    ruu=$(pwd)
    droTV=$($Sdropapk "$MiPeli")
    errorGu=$?

    echo $droTV > $fifo7
    MostarEnlaces "Dropapk" $droTV $errorGu
}
function Prostream()
{
    ruu=$(pwd)
    proTV=$($Sprostream "$ruu" "$MiPeli")
    errorGu=$?

    echo $proTV > $fifo8
    MostarEnlaces "Prostream" $proTV $errorGu
}
function Upstream()
{
    ruu=$(pwd)
    upsTV=$($Supstream "$MiPeli")
    errorGu=$?

    echo $upsTV > $fifo9
    MostarEnlaces "Upstream" $upsTV $errorGu
}
function mystream()
{
    ruu=$(pwd)
    MYSTREAM=$($Smystream "$MiPeli" "$ruu" 2>/dev/null)
    errorMystream=$?
    echo $MYSTREAM > $fifo10

    MostarEnlaces "Mystream" $MYSTREAM $errorMystream
}
function Acortadorr()
{
    unset EnlacesO; unset __resultadovar; unset _CONTENEDOR; unset errorP
    i=1
    EnlacesO=${1}
    SCRIPTA=${2}
    __resultadovar=${3}
    name=${4}

    _CONTENEDOR=$($SCRIPTA "$EnlacesO")
 
    errorP=$?
    MostarEnlaces "$name" $_CONTENEDOR $errorP
    eval $__resultadovar="'$_CONTENEDOR'"

}


function drive_2_directo() 
{

    echo -e "\033[1;36mSUBIENDO \033[0m \033[1;33mDRIVE DIRECTO\033[0m"
    estenxion=${MiPeli##*.}
    if [[ $estenxion = mkv ]]; then
        Mi_Peli_TXT=$(echo "${MiPeli/\.mkv/\.txt}")
    elif [[ $estenxion = mp4 ]]; then
        Mi_Peli_TXT=$(echo "${MiPeli/\.mp4/\.txt}")
    elif [[ $estenxion = avi ]]; then
        Mi_Peli_TXT=$(echo "${MiPeli/\.avi/\.txt}")
    fi
    echo $Mi_Peli_TXT
    rclone copyto ${ruta_drive}/${MiPeli} stream2_D:/PELICULAS/$Mi_Peli_TXT -P
    errorG=$?
    LINK_STREAM2_DIRECTO=$(rclone link stream2_D:/PELICULAS/$Mi_Peli_TXT)
    CGD1="DRIVE-DIRECTO" ; DatosGD

}
function drive22()
{
    rclone copy "${ruta_drive}/${MiPeli}" -P "${DRIVE2}":/
    errorG=$?
    LINK_DRIVE2=".linkgdVIP"
    ProgressBar
    msg -ama "Obteniendo enlaces VIP"
    rclone link "${DRIVE2}:/${MiPeli}" > $LINK_DRIVE2
    ERRLINK=$?
    if [[ $ERRLINK != 0 ]]; then
        until [[ $ERRLINK = 0 ]]; do
            rclone link ${DRIVE2}:/${MiPeli} > $LINK_DRIVE2
            ERRLINK=$?
            sleep 3
        done
    fi
    kill $!
    CGD1="GD-VIP"; DatosGD "GD-VIP" "$LINK_DRIVE2" $errorG
}
function drive33() 
{
    rclone copy "${ruta_drive}/${MiPeli}" -P ${DRIVE3}:/
    errorG=$?
    LINK_DRIVE3=".linkgd"
    ProgressBar
    msg -ama "Obteniendo enlaces DRIVE..."
    rclone link ${DRIVE3}:/"${MiPeli}" > $LINK_DRIVE3
    ERRLINK=$?
    if [[ $ERRLINK != 0 ]]; then
        until [[ $ERRLINK = 0 ]]; do
            msg -verd "Volviendo a intentar"
            rclone link ${DRIVE3}:/"${MiPeli}" > $LINK_DRIVE3
            ERRLINK=$?
            sleep 3
        done
    fi
    kill $!
    DatosGD "DRIVE FREE" $LINK_DRIVE3 $errorG
}
function editar_sub
{
    local buscar="$1"
    local remplazar_por="$2"

    SAVEIFS=${IFS}; IFS=$(echo -en "\n\b");
    for i in `ls *.srt`
    do
        sed -i "s/${buscar}/${remplazar_por}/g" "$i"
        [[ $i ]] && SUBRAR=true
    done 2>/dev/null
    IFS=${SAVEIFS}
}
function PegarSubtitulos(){
    
    # ffmpeg -i cobra.mkv -ss 00:15:03 -t 00:00:30 -c:v copy -c:a copy nuerte60.mp4
    if [[ $EXTRASUB ]]; then
        
        echo "EXTRALLENDO SUBS"
        echo -e $barraAzul
        for f in * ; do mv "$f" "${f// /_}" ; done 2>/dev/null
        for g in * ; do mv "$g" "${g/"Copia de "/}" ; done 2>/dev/null
        for i in * ; do mv -- "${i}" "${i//['][!”#$%&’ ()*+,/:;<=>?@\^`{\|}~-']/_}" ; done 2>/dev/null
        mkdir SubPega

        for MiPelii in `ls *.mp4 *.mkv *.avi *.mpg`; do
            echo $MiPelii
            NFLUJO0=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | wc -l)

            if [[ $NFLUJO0 = 1 ]]; then
                NFLUJO=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | awk -F ":" '{print $2}'| awk -F "(" '{print $1}')
                ass=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i ass | awk '{print $4}')
                if [[ $ass ]]; then
                    ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s ass subtitulos.ass -y
                    subt="subtitulos.ass"
                else
                    ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s srt subtitulos.srt -y
                    subt="subtitulos.srt"
                fi
            elif [[ $NFLUJO0 = 2 ]]; then
                NFLUJO=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i spa | grep -i subrip | awk -F ":" '{print $2}'| awk -F "(" '{print $1}')
                NC=$(echo $NFLUJO | wc -w)
                if [[ $NC = 1 ]]; then
                    ass=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i ass | awk '{print $4}')
                    if [[ $ass ]]; then
                        ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s ass subtitulos.ass -y
                        subt="subtitulos.ass"
                    else
                        ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s srt subtitulos.srt -y
                        subt="subtitulos.srt"
                    fi
                fi
                if [[ ! $NFLUJO ]]; then
                    echo "no hay flujo"
                    NFLUJO=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -v eng | grep -i subrip | awk -F ":" '{print $2}' | awk -F "(" '{print $1}')
                    NC=$(echo $NFLUJO | wc -w)
                    if [[ $NC = 1 ]]; then
                        ass=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i ass | awk '{print $4}')
                        if [[ $ass ]]; then
                            ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s ass subtitulos.ass -y
                            subt="subtitulos.ass"
                        else
                            ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s srt subtitulos.srt -y
                            subt="subtitulos.srt"
                        fi
                    fi
                    if [[ $NC = 2 ]]; then
                        echo "NC 2"
                        NFLUJO=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -v und | grep -i subrip | awk -F ":" '{print $2}' | awk -F "(" '{print $1}')
                        NC=$(echo $NFLUJO | wc -w)
                        if [[ $NC = 1 ]]; then
                            ass=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i ass | awk '{print $4}')
                            if [[ $ass ]]; then
                                ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s ass subtitulos.ass -y
                                subt="subtitulos.ass"
                            else
                                ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s srt subtitulos.srt -y
                                subt="subtitulos.srt"
                            fi
                        else
                            NFLUJO=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -v "(forced)" | awk -F ":" '{print $2}' | awk -F "(" '{print $1}')
                            NC=$(echo $NFLUJO | wc -w)
                            echo $NC
                            if [[ $NC = 1 ]]; then
                                ass=$(ffmpeg -i $MiPelii 2>&1 | grep -i Subtitle | grep -i ass | awk '{print $4}')
                                if [[ $ass ]]; then
                                    ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s ass subtitulos.ass -y
                                    subt="subtitulos.ass"
                                else
                                    ffmpeg -i $MiPelii -map 0:$NFLUJO -codec:s srt subtitulos.srt -y
                                    subt="subtitulos.srt"
                                fi
                            fi
                        fi
                    fi
                fi
            else
                echo "no hay sub español"
            fi
            # ffmpeg -i $MiPelii -i /var/www/html/de/agua13.png -filter_complex \ "[0:v][1:v]overlay=main_w-overlay_w-1:1:enable=between(t\,30\,50),subtitles=subtitulos.srt:force_style='Fontsize=22,PrimaryColour=&H00ffff&'" -metadata title=PelisHD24.com -codec:a copy S.$MiPelii.mp4
            esubt=${subt##*.}
            if [[ $esubt = "ass" ]]; then
                ffmpeg -threads 4 -i $MiPelii -vf "ass=$subt" -c:v libx264 -crf 17 -strict -2 S.$MiPelii.mp4
                er=$?
                mv -- "S.$MiPelii.mp4" "SubPega"
                if [[ $er = 0 ]]; then
                    rm $MiPelii
                    rm $subt
                fi
            else
                # ffmpeg -threads 4 -i $MiPelii -i /var/www/html/de/agua13.png -filter_complex \
                # "subtitles=$subt:force_style='Fontsize=22,PrimaryColour=&H00ffff&'" -codec:a copy S.$MiPelii.mp4
                ffmpeg -i $MiPelii -filter_complex \
                "subtitles=$subt:force_style='Fontsize=22,PrimaryColour=&H00ffff&'" -c:v libx264 -crf 17 -strict -2 S.$MiPelii.mp4
                er=$?
                mv "S.$MiPelii.mp4" SubPega
                if [[ $er = 0 ]]; then
                    rm $MiPelii
                    rm $subt
                fi
            fi
                    
        done
        cd SubPega
    fi


    if [[ $CSUB = 1 ]]; then
        # dess download $LSUB
        EXTSUB=${LSUB##*.}
        if [[ $EXTSUB = "srt" || $EXTSUB = "vtt" ]]; then
            wget $LSUB
            echo "ETROOOOOOOO"
        elif [[ $EXTSUB = "sbv" || $EXTSUB = "ass" ]]; then
            wget $LSUB
        else
            p1=$(echo $LSUB | awk -F "~" '{print $1}')
            p2=$(echo $p1 | sed 's/\/stream\//\/embed\//g')
            mkdir subopenn && cd subopenn
            #descarga del index
            wget $p2
            Err2=$?
            if [[ $LSUB != "" ]]; then
                LiimiteGD
            fi

            for i in * ; do
                echo $i
            done

            if fgrep "openload.co" $i ; then
                echo "se encuentra"
                subopen=$(grep -i "subtitle" $i | awk -F "\"" '{print $2}')
                echo $subopen
                cd ../
                rm -rf subopenn

                #descargar del sud del index
                wget $subopen
            else
                mv $i ../
                cd ../
                rm -rf subopenn

            fi
        fi
    fi

    if [[ `ls *.srt *.ass 2>/dev/null` ]]; then
        for i in * ; do mv -- "${i}" "${i//['][!”#$%&’()*+,/:;<=>?@\^`{\|}~-']/_}" ; done 2>/dev/null
        sleep 2
        for f in * ; do mv "$f" "${f// /_}" ; done > /dev/null 2>> /root/log.txt
        for g in * ; do mv "$g" "${g/"Copia de "/}" ; done > /dev/null 2>> /root/log.txt

        for MiPelii in `ls *.mp4 *.mkv *.avi *.mpg`; do
            echo $MiPelii
        done 2>/dev/null

            for Subt in `ls *.srt *.vtt *.sbv`; do
                echo "Subtitulo"
                echo "$Subt"
                mv "$Subt" SubtPegados.srt
            done 2>/dev/null

            for Subt in `ls *.ssa *.ass`; do
                echo "Subtitulo"
                echo "$Subt"
            done 2>/dev/null
            sleep 2


            if [[ "${Subt##*.}" = "ass" || "${Subt##*.}" = "ssa" ]]; then
                mv "$Subt" SubtPegados.ass
                ffmpeg -i "$MiPelii" -vf "ass=SubtPegados.ass" -c:v libx264 -crf 17 -strict -2 S.$MiPelii
            else
            echo "8 nucleos activado"
                ffmpeg -threads 8 -i "$MiPelii" -filter_complex \ "subtitles=SubtPegados.srt:force_style='Fontsize=22,PrimaryColour=&H00ffff&'" -codec:a copy "S.$MiPelii.mp4"
            fi

        Err3=$?
        if [[ $Err3 = 0 ]]; then
            echo "Archivos Eliminados"
            rm $MiPelii
            rm SubtPegados.srt
        fi
    fi
}
function descompri() {

    for FILE in *.rar ; do NEWFILE=`echo $FILE | sed 's/ /_/g'` ; mv "$FILE" $NEWFILE ; done > /dev/null 2>> /root/log.txt
    for FILE in *.zip ; do NEWFILE=`echo $FILE | sed 's/ /_/g'` ; mv "$FILE" $NEWFILE ; done > /dev/null 2>> /root/log.txt
    for RAR in `ls *.rar *.zip`
    do
        echo $RAR
    done > /dev/null 2>> /root/log.txt

    descomprimir=${RAR##*.}
    case $descomprimir in

        *rar)
        unrar x -p$PSW6 '*.rar' -y 
        error=$?
        comprobar1
        printf "${CYANCLARO}";
        echo "FICHEROS RAR DESCOMPRIMIDOS CON EXITO!!";;
        *zip)
        unzip $RAR -y
        error=$?
        comprobar1
        printf "${CYANCLARO}";
        echo "FICHEROS ZIP DESCOMPRIMIDOS CON EXITO!!";;
    esac         
    for f in * ; do mv "$f" "${f// /_}" ; done > /dev/null 2>> /root/log.txt
    find . ! -name credentials.json ! -name drivedb -type f -exec mv {} . 2>/dev/null \;
    find . ! -name .gd -type d -exec rm -rf {} 2>/dev/null \;

    if [[ $SUBRAR ]]; then
    find . ! -name "*.mkv" ! -name "*.mp4" ! -name "*.avi" ! -name "*.mpg" ! -name "*.srt" ! -name "*.ass" -type f -exec rm -rf {} 2>/dev/null \;
    else
    find . ! -name "*.mkv" ! -name "*.mp4" ! -name "*.avi" ! -name "*.mpg" -type f -exec rm -rf {} 2>/dev/null \;
    fi
    
    Fmkv=$(ls *.mkv 2>/dev/null)
    if [[ $AUDIO = 1 ]]; then
        #if [[ -n $Fmkv ]]; then
        valor=1
        mkdir Latino
        for c in `ls *.mkv *.mp4 *.avi *.mpg` ; do 
            cc=$(mkvinfo $c | awk '/Track type: audio/,/Track type: subtitles/'| grep Language | awk '{print $4}')
            if [[ $cc = "lat" ]]; then
                echo -e "\n "
                echo -e "\033[01;36m..:el idioma es latino:..\033[0m"
                mkvmerge -o $c.LAT.mkv -a "lat" $c
            elif [[ $cc = "spa" ]]; then
                echo -e "\n "
                echo -e "\033[01;36m..:el idioma es español:..\033[0m"
                mkvmerge -o $c.LAT.mkv -a "spa" $c
            else
                echo -e "\033[01;36m..:No hay subtitulos:..\033[0m"
                mv $c Latino
            fi
            mv $c.LAT.mkv Latino
        done 2>/dev/null
        rm *
        cd Latino
    fi
}

function parse_url 
{
    datosDescarga=".datosdescarga.log"
    # extract the protocol
    proto="$(echo $1 | grep :// | sed -e's,^\(.*://\).*,\1,g')"
    # remove the protocol
    url="$(echo ${1/$proto/})"
    # extract the user (if any)
    user="$(echo $url | grep @ | cut -d@ -f1)"
    # extract the host and port
    hostport="$(echo ${url/$user@/} | cut -d/ -f1)"
    # by request host without port    
    host="$(echo $hostport | sed -e 's,:.*,,g')"
    # by request - try to extract the port
    port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
    # extract the path (if any)
    path="$(echo $url | grep / | cut -d/ -f2-)"
}