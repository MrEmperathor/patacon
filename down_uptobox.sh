#!/bin/bash
#---------------------------------------------------------------------------------
#- Nom : uptobox.sh
#-
#- Auteur : D.Chevreau
#-
#- Objectif : Cette procédure permet le téléchargement correcte 
#-            des liens uptobox avec un compte premium.
#-            Les fichiers sont copiés dans le répertoire $destination
#-                 
#- Fichier en entrée : ./wget.lis
#-                     les liens y sont copiés sous la forme courante:
#-                     https://uptobox.com/ms7m3lspxg87
#-                     https://uptobox.com/l7l96a6ceicm
#-                     [...]
#-
#---------------------------------------------------------------------------------

#set -xv
#https://uptobox.com/api/link?file_code=ms7e7lspxg87&token=xxxxxxxxxxxxxxxxxxxxxxxxx
#https://uptobox.com/api/link?file_code=l7l96a6ceicm&token=aa97a9e6899148e6414c742df2b159ce54d8p
. /usr/local/bin/config.ini
# file_code="l7l96a6ceicm"
token=${TOKEN_UPT}
destination="."
lienc="${1}"

# while read lienc # url
# do
        file_code=$(echo $lienc | awk -F '/' '{print $4}')
        url="https://uptobox.com/api/link?file_code=${file_code}&token=$token"
        direct_dl_link=$(curl $url | jq -r '.data.dlLink')
        # echo "-----------------------------------------------------"
        # echo "json esperado: ${direct_dl_link}"
        # echo "-----------------------------------------------------"

        # wget -c -nc -P$destination $direct_dl_link
        # aria2c -x16 -s16 "${url}" -o "${direct_dl_link}"


        aria2c -x16 -s16 -c "${direct_dl_link}"
        # aria2c -c "${direct_dl_link}"

# sleep 5
# done < $PWD/wget.lis

#set +xv
echo ------- FIN DE LA DESCARGA----------