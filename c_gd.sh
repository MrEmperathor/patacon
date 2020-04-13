#!/bin/bash -ex
clear
NAMER=`echo $(($RANDOM))`
CONFIG="/usr/local/bin/config.ini"


function menu()
{
    VAL=${1}
    function subMenuFree()
    {
        echo "TIPO DE CUENTA:"
        echo "/-------------------/"
        echo "CUENTA NORMAL (1)"
        echo "UNIDAD DE EQUIPO (2)"
        read -p "INGRESE UNA OPCION [1-2]: " TIPO_DDRIVE;
        echo "/-------------------/"
        read -p "NOMBRE UNICO SIN ESPACIO: " SERVIDOR;
        echo "/-------------------/"
        read -p "ID CARPETA: " ID_CARPETA;
        echo "/-------------------/"

        if [[ $TIPO_DDRIVE -eq 1 ]];then
            rclone config create ${SERVIDOR} drive root_folder_id ${ID_CARPETA} scope drive config_is_local false 
        elif [[ $TIPO_DDRIVE -eq 2 ]];then
            rclone config create ${SERVIDOR} drive team_drive ${ID_CARPETA} scope drive config_is_local false 
        fi
    }
    function subMenuVip()
    {
        echo "/-------------------/"
        read -p "NOMBRE UNICO SIN ESAPCIO: " SERVIDOR;
        echo "/-------------------/"
        read -p "ID CARPETA: " ID_CARPETA;
        echo "/-------------------/"

        rclone config create ${SERVIDOR} drive root_folder_id ${ID_CARPETA} scope drive config_is_local false 
    }
    function editarCuenta()
    {   
        echo "${DRIVE3} (1)"
        echo "${DRIVE2} (2)"
        read SERVIDOR_A_EDITAR

        [[ $SERVIDOR_A_EDITAR -eq 1 ]] && SERVIDOR=${DRIVE3}
        [[ $SERVIDOR_A_EDITAR -eq 2 ]] && SERVIDOR=${DRIVE2}

        echo "/-------------------/"
        read -p "ID CARPETA: " ID_CARPETA;
        echo "/-------------------/"

        rconfig=$(cat ${HOME}/.config/rclone/rclone.conf | awk "/${SERVIDOR}/,/^$/")
        echo "id a cambiar"
        echo "$rconfig" | grep -i team_drive | cut -d" " -f3
        read
        [[ $rconfig =~ "team_drive" ]] && ID_CARPETA_TEAM=$(echo "$rconfig" | grep -i team_drive | cut -d" " -f3)
        [[ $rconfig =~ "root_folder_id" ]] && ID_CARPETA_TEAM=$(echo "$rconfig "| grep -i root_folder_id | cut -d" " -f3)

        sed -i "s/${ID_CARPETA_TEAM}/${ID_CARPETA}/gi" ${HOME}/.config/rclone/rclone.conf

        # rclone config update punida root_folder_id 1FlNEf5aiN_MUiA3nD83W-lBrBIup2rtZ scope drive config_refresh_token false


        # rclone config create ${SERVIDOR} drive root_folder_id ${ID_CARPETA} scope drive config_is_local false 
    }
    case $VAL in
        1) subMenuFree
        ;;
        2) subMenuVip
        ;;
        3) editarCuenta
        ;;
        *) echo default
        ;;
    esac
    
}
echo "CUENTA FREE (1)"
echo "CUENTA VIP (2)"
echo "EDITAR CUENTA EXISTENTE (3)"
read VALIDAR

menu $VALIDAR
# SERVIDOR="prueba"
[[ $VALIDAR -eq 1 ]] && sed -i "s/DRIVE3=\"${DRIVE3}\"/DRIVE3=\"${SERVIDOR}\"/g" $CONFIG
[[ $VALIDAR -eq 2 ]] && sed -i "s/DRIVE2=\"${DRIVE2}\"/DRIVE2=\"${SERVIDOR}\"/g" $CONFIG
source $CONFIG
read

# DRIVE3="drive3"
# sed -i "s/DRIVE3=\"drive3\"/DRIVE3=\"PRUEBA\"/g" ss.sh
