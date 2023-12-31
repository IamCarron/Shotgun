#!/bin/bash

echo "
⠉⠉⠉⣿⡿⠿⠛⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣻⣩⣉⠉⠉
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⣀⣀⣀⣀⣀⡀⠄⠄⠉⠉⠄⠄⠄
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠄⠄⠄⠄⢤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⠄⠄
⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠄⠉⠉⠉⣋⠉⠉⠉⠉⠉⠉⠉⠉⠙⠛⢷⡀⠄⠄
⣿⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⣾⣿⣷⣄⣀⣀⣀⣠⣄⣢⣤⣤⣾⣿⡀⠄
⣿⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣹⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⢟⢁⣠
⣿⣿⣄⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠉⣉⣉⣰⣿⣿⣿⣿⣷⣥⡀⠉⢁⡥⠈
⣿⣿⣿⢹⣇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠒⠛⠛⠋⠉⠉⠛⢻⣿⣿⣷⢀⡭⣤⠄
⣿⣿⣿⡼⣿⠷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⣠⣿⣟⢷⢾⣊⠄⠄
⠉⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⣈⣉⣭⣽⡿⠟⢉⢴⣿⡇⣺⣿⣷
⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠐⢊⣡⣴⣾⣥⣿⣿⣿
"

# Comprobar dependencias
command -v nmap >/dev/null 2>&1 || { echo >&2 "Se requiere nmap pero no está instalado. Por favor, instálalo."; exit 1; }
command -v msfconsole >/dev/null 2>&1 || { echo >&2 "Se requiere msfconsole pero no está instalado. Por favor, instálalo."; exit 1; }

host_finder() {
    echo "Introduzca la subred que va a escanear:"
    read subnet
    echo "Buscando equipos en la subred:$subnet..."
    nmap -sn $subnet > /tmp/host_results
    echo
    echo "Se han encontrado los siguientes equipos:"
    cat /tmp/host_results | grep open
    rm /tmp/host_results
}

exploit_scanner() {
    echo "Introduzca la IP del equipo que va a escanear:"
    read ip
    echo "Buscando puertos abiertos en la IP:$ip..."
    nmap -sV -Pn --script=vuln $ip > /tmp/vuln_results
    echo
    echo "Se han encontrado los siguientes puertos abiertos:"
    cat /tmp/vuln_results | grep open
    rm /tmp/vuln_results
}

exploit_finder() {
    while true; do
        echo "Indique el CVE que quiere buscar:"
        read CVE

        # Verificar si la entrada contiene la palabra CVE
        if [ -n "$(echo "$CVE" | grep "CVE")" ]; then
            echo "Buscando un exploit para la vulnerabilidad $CVE..."
            sleep 5
            echo
            echo "Resultados encontrados para la vulnerabilidad $CVE!"
            msfconsole -q -x "search $CVE; exit" | grep exploit
            break
        else
            echo "Solo se admiten vulnerabilidades en formato CVE. Inténtalo de nuevo."
        fi
    done
}

# Menú principal
while true; do
    echo "Seleccione una opción:"
    echo "1. Buscar equipos en una subred"
    echo "2. Escanear puertos abiertos en un equipo"
    echo "3. Buscar exploit para una vulnerabilidad (por CVE)"
    echo "4. Salir"

    read option

    case $option in
        1) host_finder ;;
        2) exploit_scanner ;;
        3) exploit_finder ;;
        4) exit ;;
        *) echo "Opción no válida. Inténtelo de nuevo." ;;
    esac
done
