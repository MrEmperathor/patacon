#!/bin/bash
BLANCOF='\033[47m'; RED='\033[0;31m'; REDCLARO='\033[1;31m'; AZUL='\033[0;34m'; AZULCLARO='\033[1;34m'; VERDE='\033[0;32m'; VERDECLARO='\033[1;32m'; CYAN='\033[0;36m'; CYANCLARO='\033[1;36m'; PURPURA='\033[0;35m'; PURPURAC='\033[1;35m'; CAFE='\033[1;37m'; AMARILLO='\033[1;33m'; NC='\033[0m'; RFembed="/var/www/html/panel/inc/include/fembed.php"; RNetu="/var/www/html/panel/inc/include/netu1.php"; SFembed="/var/www/html/panel/inc/include/./fembed.php"; SNetu="/var/www/html/panel/inc/include/./netu1.php"; Rvery="/var/www/html/panel/inc/include/./very.php"; SJetload="/var/www/html/panel/inc/include/./jetload.php"; Uptoboxx="/var/www/html/panel/inc/include/./uptobox.php"; Sgoun="/var/www/html/panel/inc/include/./gounlimited.php"; Sclicknupload="/var/www/html/panel/inc/include/./clicknupload.php"; Sdropapk="/var/www/html/panel/inc/include/./dropapk.php"; Sprostream="/var/www/html/panel/inc/include/./prostream.php"; Supstream="/var/www/html/panel/inc/include/./upstream.php"; SSHORT="/var/www/html/panel/inc/include/./short.php"; SOUO="/var/www/html/panel/inc/include/./ouo.php"; CONFIG="/usr/local/bin/config.ini"; CONFIGGLOBAL="/var/www/html/panel/inc/config.php"; barraAzul="\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"; ruta_drive=$(pwd); 

IDPELI=${1}
nombresinespacio=${2}
IDIOMA2=${3}
IDDRIVE=${4}
LOG=".logSubida"
# FILENAME=$(wget -q --show-progress -O - "https://drive.google.com/file/d/${IDDRIVE}/view" | sed -n -e 's!.*<title>\(.*\)\ \-\ Google\ Drive</title>.*!\1!p')

# [[ -z $nombresinespacio ]] && nombresinespacio="${FILENAME}"
source $CONFIG
PSW6=$PASSRAR

RAR=(ls *.rar *.zip)
MiPeli=(ls *.mp4 *.zip)
RD=$(pwd)
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for MiPeli in `ls *.mp4 *.avi *.mkv *.mpg`; do echo $MiPeli; mv $MiPeli "${MiPeli//"(1080)"/"(720)"}"; done 2>/dev/null

function subida_mega() {
for FICHERO_mega in `ls *.mp4 *.avi *.mkv *.mpg`
do
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
        fi
        if [[ $MEGA_Links == ".linkmega720.txt" ]]; then
            MEGALPHP720=$(cat $MEGA_Links | awk -F " " '{printf $1}')
        fi
    
}

if [[ -f $FICHERO_mega ]]; then
    echo -e "\033[1;31m=================================================\033[0m"
    #megaput $FICHERO_mega 2>&1 | tee .megalog; sed '1d' .megalog > .megalog1; MEGALOG=$(cat .megalog1.txt)
    megaput $FICHERO_mega --debug --config /var/www/.megarc 2>&1 | tee $RUTAMEGA/.megalog
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
                                MEGAESP=$(megadf --human --config /var/www/.megarc | sed -n '3p')
                                    if [[ $MEGAESP != $MEGAESP1 ]]; then
                                        echo -e "\033[1;36mPERFECTO LA CUENTA \033[1;31m$UPDATECUENTA\033[0m ESTA DISPONIBLE!\033[0m"
                                        break
                                    fi

                            done < "$listamega"
                        #sed -n "$Ap" $listamega > $listamega1; CUENTAMEGA=$(cat "$listamega1")
                        sleep 3
                        CMEGA=$(cat /root/.megarc | sed -n '2p' | awk -F " " '{printf $3}')
                        PMEGA=$(cat /root/.megarc | sed -n '3p' | awk -F " " '{printf $3}')
                        megaput $FICHERO_mega --debug --config /var/www/.megarc 2>&1 | tee .megalog; MEGALOG=$(grep "EOVERQUOTA" $RUTAMEGA/.megalog)
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
         megaput $FICHERO_mega --debug --config /var/www/.megarc 2>&1 | tee $RUTAMEGA/.megalog
         LinkMegaDOWN
        if fgrep "$SUBIDO" $RUTAMEGA/.megalog ;then
                MEGASUB=${SUBIDO}
                echo "$MEGASUB"
                break
        elif fgrep "$MEGALIMIT3" $RUTAMEGA/.megalog ;then
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
         megaput $FICHERO_mega --debug --config /var/www/.megarc 2>&1 | tee $RUTAMEGA/.megalog
         LinkMegaDOWN
        if fgrep "$SUBIDO" $RUTAMEGA/.megalog ;then
                MEGASUB=${SUBIDO}
                echo "$MEGASUB"
                break
        fi
    done
fi      

if fgrep "$ERRORCUENTA"  $RUTAMEGA/.megalog ;then
    sed -i '2d' /var/www/.megarc
    while read line 
    do
                                
         echo "$line" > "$listamega$A"; CUENTAMEGA=$(cat "$listamega$A")
         let A++
         echo
         echo -e "\033[1;32mERROR DE CUENTA...PASAREMOS A LA CUENTA $CUENTAMEGA EN UN MOMENTO!! :)\033[0m"
         sleep 3

         #sed '2d' $MEGARC > $MEGARC2; sed -i "2i Username = $CUENTAMEGA" $MEGARC2; rm -rf $MEGARC; mv $MEGARC2 $MEGARC
         sed -i "2i\Username = $CUENTAMEGA" /var/www/.megarc

         sleep 1
         #UPDATECUENTA=$(cat $MEGARC | sed -n '2p' | awk -F " " '{printf $3}')
         MEGAESP=$(megadf --human --config /var/www/.megarc | sed -n '1p' | awk '{print $1}')
         echo -e "\033[1;36mPERFECTO LA CUENTA \033[1;31m$CUENTAMEGA\033[0m ESTA DISPONIBLE!\033[0m"
             if [[ $MEGAESP = "Total:" ]]; then  
                 while true ; do
                    megaput $FICHERO_mega --debug --config /var/www/.megarc 2>&1 | tee .megalog
                    sleep 2s
                    COMPROBAR=$(megals -e /Root/$FICHERO_mega | awk '{print $2}')
                    if [[ $COMPROBAR = "/Root/$FICHERO_mega" ]]; then
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
    fifo=".fifo${puesto}very"
    [[ -e $fifo ]] && rm $fifo
    fifo1=".fifo${puesto}fembed"
    [[ -e $fifo1 ]] && rm $fifo1
    fifoNetu=".fifo${puesto}netu"
    [[ -e $fifoNetu ]] && rm $fifoNetu
    fifoJetload=".fifo${puesto}jetload"
    [[ -e $fifoJetload ]] && rm $fifoJetload
    fifoUptobox=".fifo${puesto}uptobox"
    [[ -e $fifoUptobox ]] && rm $fifoUptobox
    fifoGounlimited=".fifo${puesto}gounlimited"
    [[ -e $fifoGounlimited ]] && rm $fifoGounlimited
    fifo6=".fifo${puesto}Clicknupload"
    [[ -e $fifo6 ]] && rm $fifo6
    fifo7=".fifo${puesto}Dropapk"
    [[ -e $fifo7 ]] && rm $fifo7
    fifo8=".fifo${puesto}Prostream"
    [[ -e $fifo8 ]] && rm $fifo8
    fifo9=".fifo${puesto}Upstream"
    [[ -e $fifo9 ]] && rm $fifo9
    fifoDriveFree=".fifo${puesto}GDFREE"
    [[ -e $fifoDriveFree ]] && rm $fifoDriveFree
    fifoMega=".fifo${puesto}MEGA"
    [[ -e $fifoMega ]] && rm $fifoMega
    [[ -e $LOG ]] && rm $LOG
}
function EnlacesMostar()
{
    UrlVerystream=$(< $fifo)
    echo $UrlVerystream
    UrlFembed=$(< $fifo1)
    echo $UrlFembed
    UrlNetu=$(< $fifoNetu)
    echo $UrlNetu
    UrlJetload=$(< $fifoJetload)
    echo $UrlJetload
    UrlUotobox=$(< $fifoUptobox)
    echo $UrlUotobox
    UrlGounlimited=$(< $fifoGounlimited)
    echo $UrlGounlimited
    UrlClicknupload=$(< $fifo6)
    echo $UrlClicknupload
    UrlDropapk=$(< $fifo7)
    echo $UrlDropapk
    UrlProstream=$(< $fifo8)
    echo $UrlProstream
    UrlUpstream=$(< $fifo9)
    echo $UrlUpstream
    LGDPHP=$(< $fifoDriveFree)
    echo $LGDPHP
    MEGALPHP=$(< $fifoMega)
    echo $MEGALPHP
}
function drive22()
{
    rclone copy "${ruta_drive}/${MiPeli}" -P "${DRIVE2}":/ --config=/var/www/.rclone/rclone.config
    errorG=$?
    LINK_DRIVE2=".linkgdVIP"
    echo "Obteniendo enlaces VIP"
    rclone link "${DRIVE2}:/${MiPeli}" --config=/var/www/.rclone/rclone.config > $LINK_DRIVE2 
    ERRLINK=$?
    if [[ $ERRLINK != 0 ]]; then
        until [[ $ERRLINK = 0 ]]; do
            rclone link ${DRIVE2}:/${MiPeli} --config=/var/www/.rclone/rclone.config > $LINK_DRIVE2
            ERRLINK=$?
            sleep 3
        done
    fi
    CGD1="GD-VIP"; DatosGD "GD-VIP" "$LINK_DRIVE2" $errorG
}
function drive33() 
{
    rclone copy "${ruta_drive}/${MiPeli}" -P ${DRIVE3}:/ --config=/var/www/.rclone/rclone.config
    errorG=$?
    LINK_DRIVE3=".linkgd"
    echo "Obteniendo enlaces DRIVE..."
    rclone link ${DRIVE3}:/"${MiPeli}" --config=/var/www/.rclone/rclone.config > $LINK_DRIVE3
    ERRLINK=$?
    if [[ $ERRLINK != 0 ]]; then
        until [[ $ERRLINK = 0 ]]; do
            echo "Volviendo a intentar"
            rclone link ${DRIVE3}:/"${MiPeli}" --config=/var/www/.rclone/rclone.config > $LINK_DRIVE3 
            ERRLINK=$?
            sleep 3
        done
    fi
    DatosGD "DRIVE FREE" $LINK_DRIVE3 $errorG
}
function Acortadorr()
{
    unset EnlacesO; unset __resultadovar; unset _CONTENEDOR; unset errorP
    i=1
    EnlacesO=${1}
    SCRIPTA=${2}
    __resultadovar1=${3}
    name=${4}

    _CONTENEDOR1=$($SCRIPTA "$EnlacesO")
 
    eval $__resultadovar1="'$_CONTENEDOR1'"

}
function Subuniversal()
{
    unset EnlacesO; unset __resultadovar; unset _CONTENEDOR; unset errorP

    MiPeli=${1}
    SCRIPTA=${2}
    __resultadovar=${3}
    name=${4}

    _CONTENEDOR=$($SCRIPTA "$MiPeli")
    echo $_CONTENEDOR > $__resultadovar
    # eval $__resultadovar="'$_CONTENEDOR'"

}
function EjecutarAcortadores()
{
    [[ $MEGALPHP ]] && Acortadorr $MEGALPHP $SSHORT MEGALPHP1 "SHORT"
    [[ $LGDPHP ]] && Acortadorr $LGDPHP $SOUO LGDPHP1 "OUO"
}

definnirFifo
echo "------SUBIENDO A GOOGLE DRIVE-------" > $LOG

drive33 
Subuniversal "${MiPeli}" "${SJetload}" $fifoJetload "Jetload" &
echo "------SUBIENDO A JETLOAD-------" >> $LOG
sleep 2
Subuniversal "${MiPeli}" "${Uptoboxx}" $fifoUptobox "Uptobox" &
echo "------SUBIENDO A UPTOBOX-------" >> $LOG
sleep 2
Subuniversal "${MiPeli}" "${Sgoun}" $fifoGounlimited "Gounlimited" &
echo "------SUBIENDO A GOUNLLIMITED-------" >> $LOG
echo "------SUBIENDO A MEGA-------" >> $LOG
subida_mega .megallin.txt 

EjecutarAcortadores
JOBS=$(jobs)
jobs >> $LOG
v=1
until [[ -z $JOBS ]]; do
    echo "esperando a que terminen todos los procesos #${v}" > $LOG
    jobs >> $LOG
    sleep 10
    JOBS=$(jobs)
    ((v++))
done
echo "PROCESOS TERMINADOS!!!" >> $LOG
EnlacesMostar

array=($LGDPHP $MEGALPHP $MEGALPHP1 $LGDPHP1 $UrlJetload $UrlUotobox $UrlGounlimited)
enlaces_pre=$(/var/www/html/panel/inc/include/./serializar.php "${array[@]}")
# /var/www/html/panel/inc/xion/./insertar.php $enlaces_pre $bid
/var/www/html/panel/inc/xion/./insertar720.php "$IDPELI" "$nombresinespacio" "(720)" $IDIOMA2 $enlaces_pre "admin2"
IFS=$SAVEIFS
# rm $LOG
# rm .logAria