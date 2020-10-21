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
#-                     https://uptobox.com/slk33jjko3l6
#-                     [...]
#-
#---------------------------------------------------------------------------------

#set -xv
#https://uptobox.com/api/link?file_code=ms7e7lspxg87&token=xxxxxxxxxxxxxxxxxxxxxxxxx
#https://uptobox.com/api/link?file_code=l7l96a6ceicm&token=aa97a9e6899148e6414c742df2b159ce54d8p

# file_code="l7l96a6ceicm"
# token="aa97a9e6899148e6414c742df2b159ce54d8p"
token="e9020131e0318ce8da2b1478180d271b7s4s8"
# e9020131e0318ce8da2b1478180d271b7s4s8
destination="./Download/uptobox/"

while read lienc # url
do
        file_code=$(echo $lienc | awk -F '/' '{print $4}')
        url="https://uptobox.com/api/link?file_code=$file_code&token=$token"


        direct_dl_link=$(curl $url | jq -r '.data.dlLink')
        echo "$direct_dl_link"
        wget -c -nc -P$destination $direct_dl_link
sleep 5
done < $PWD/wget.lis

#set +xv
echo ------- FIN DE LA PROCEDURE----------