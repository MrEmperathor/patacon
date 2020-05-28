#!/bin/bash

log_aria=".logAria"
terminar="(OK):download completed"
error1="(ERR):error occurred."
for FILE1 in $@
do
    if [ -f $FILE1 ]; then

        for FILE2 in $(cat $FILE1)
        do
            cookiefile="/tmp/cookies-$( date +%s.%N ).txt"
            url=$( youtube-dl --cookies $cookiefile -g $FILE2 )
            NAME=$(youtube-dl -t --get-filename $FILE2)

            aria2c --load-cookies $cookiefile -k1M -x4 -c $url -o "$NAME"
            rm -f $cookiefile

        done

    else
#     format code  extension  resolution note
# 18           mp4        640x360
# 22           mp4        1280x720
# 37           mp4        1920x1080
# source       mkv        unknown    (best)
        # youtube-dl -F $FILE1
        buscarCalidad=$(youtube-dl -F $FILE1)

        if [[ "$buscarCalidad" =~ "1280x720" ]];then
            cali=22
            echo "720p DISPONIBLE!."
        elif [[ "$buscarCalidad" =~ "1920x1080" ]];then
            cali=37
            echo "1080p DISPONIBLE!."
        else
            echo "NO HAY CALIDAD DISPONIBLE!!"
            exit    
        fi
        cookiefile="/tmp/cookies-$( date +%s.%N ).txt"
        url=$( youtube-dl --cookies $cookiefile -g -f $cali $FILE1 )
        NAME=$(youtube-dl -t --get-filename $FILE1)

        # aria2c --load-cookies $cookiefile -k1M -x16 -c $url -o "$NAME" > ${log_aria} &
        # rm -f $cookiefile
        i=1
        while true
        do
            aria2c --load-cookies $cookiefile -k1M -x16 -s16 -c $url -o "$NAME" > ${log_aria} &
            jobs -l
            sleep 5
            kill %"${i}"
            echo "VUELTA # $i"
            echo "--------------"
            cat $log_aria
            
            if fgrep "$terminar" $log_aria ;then
                rm -f $cookiefile
                break
            elif fgrep "$error1" $log_aria ;then
                rm -f $cookiefile
                break
            fi
            ((i++))
        done
        
    fi
done