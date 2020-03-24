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
        echo "intentado forzar sida. INTENTO # $nm"
        ((nm++))
        sleep 3
    done
    eval $__salida="'$link'"
}