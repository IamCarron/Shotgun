#!/bin/bash
clear
# Colores
BOLD='\033[1m'
UNDERLINE='\033[4m'
RESET='\033[0m'
CYAN='\033[96m'
GREEN='\033[92m'
YELLOW='\033[93m'
RED='\033[91m'

# ASCII Art
echo "${CYAN}${BOLD}
⠄⠄⠄⠄⠄⠄⠄⢀⣠⣶⣾⣿⣶⣦⣤⣀⠄⢀⣀⣤⣤⣤⣤⣄⠄⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⢀⣴⣿⣿⣿⡿⠿⠿⠿⠿⢿⣷⡹⣿⣿⣿⣿⣿⣿⣷⠄⠄⠄⠄⠄
⠄⠄⠄⠄⠄⣾⣿⣿⣿⣯⣵⣾⣿⣿⡶⠦⠭⢁⠩⢭⣭⣵⣶⣶⡬⣄⣀⡀⠄⠄
⠄⠄⠄⡀⠘⠻⣿⣿⣿⣿⡿⠟⠩⠶⠚⠻⠟⠳⢶⣮⢫⣥⠶⠒⠒⠒⠒⠆⠐⠒
⠄⢠⣾⢇⣿⣿⣶⣦⢠⠰⡕⢤⠆⠄⠰⢠⢠⠄⠰⢠⠠⠄⡀⠄⢊⢯⠄⡅⠂⠄
⢠⣿⣿⣿⣿⣿⣿⣿⣏⠘⢼⠬⠆⠄⢘⠨⢐⠄⢘⠈⣼⡄⠄⠄⡢⡲⠄⠂⠠⠄
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣥⣀⡁⠄⠘⠘⠘⢀⣠⣾⣿⢿⣦⣁⠙⠃⠄⠃⠐⣀
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣋⣵⣾⣿⣿⣿⣿⣦⣀⣶⣾⣿⣿⡉⠉⠉
⣿⣿⣿⣿⣿⣿⣿⠟⣫⣥⣬⣭⣛⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄
⣿⣿⣿⣿⣿⣿⣿⠸⣿⣏⣙⠿⣿⣿⣶⣦⣍⣙⠿⠿⠿⠿⠿⠿⠿⠿⣛⣩⣶⠄
⣛⣛⣛⠿⠿⣿⣿⣿⣮⣙⠿⢿⣶⣶⣭⣭⣛⣛⣛⣛⠛⠛⠻⣛⣛⣛⣛⣋⠁⢀
⣿⣿⣿⣿⣿⣶⣬⢙⡻⠿⠿⣷⣤⣝⣛⣛⣛⣛⣛⣛⣛⣛⠛⠛⣛⣛⠛⣡⣴⣿
⣛⣛⠛⠛⠛⣛⡑⡿⢻⢻⠲⢆⢹⣿⣿⣿⣿⣿⣿⠿⠿⠟⡴⢻⢋⠻⣟⠈⠿⠿
⣿⡿⡿⣿⢷⢤⠄⡔⡘⣃⢃⢰⡦⡤⡤⢤⢤⢤⠒⠞⠳⢸⠃⡆⢸⠄⠟⠸⠛⢿
⡟⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸
${RESET}"

# Comprobar dependencias
echo "${YELLOW}Comprobando dependencias...${RESET}"
sleep 2
echo "${GREEN}NMAP OK!${RESET}"
command -v nmap >/dev/null 2>&1 || { echo>&2 "${RED}Se requiere nmap pero no está instalado. Por favor, instálalo.${RESET}"; exit 1; }
sleep 2
echo "${GREEN}Metasploit OK!${RESET}"
command -v msfconsole >/dev/null 2>&1 || { echo>&2 "${RED}Se requiere msfconsole pero no está instalado. Por favor, instálalo.${RESET}"; exit 1; }
echo "${CYAN}Pwnd.sh preparado para vulnerar sistemas!${RESET}"
sleep 3

# Función para ejecutar metasploit
metasploit_runner(){
        # Ejecutar comandos de Metasploit
        for comando in "${comandos_metasploit[@]}"; do
            echo "Ejecutando: $comando"
            sudo msfconsole -q -x "$comando"
        done
}

# Función para encontrar hosts en una subred
host_finder() {
    clear
    echo "${BOLD}${UNDERLINE}============================= Buscar Equipos en una Subred =============================${RESET}"
    echo "${CYAN}Introduzca la subred que va a escanear:${RESET}"
    read subnet
    echo "${CYAN}Buscando equipos en la subred: ${BOLD}$subnet${RESET}..."
    nmap -sn $subnet > /tmp/host_results
    echo
    echo "${CYAN}Se han encontrado los siguientes equipos:${RESET}"
    cat /tmp/host_results | grep open
    rm /tmp/host_results
    echo "${BOLD}${UNDERLINE}=========================================================================================${RESET}"
}

# Función para escanear vulnerabilidades en un host
exploit_scanner() {
    clear
    echo "${BOLD}${UNDERLINE}==================== Escanear Vulnerabilidades en un Host ====================${RESET}"
    echo "${CYAN}Introduzca la IP del equipo que va a escanear:${RESET}"
    read ip
    echo "${CYAN}Buscando vulnerabilidades abiertas en la IP: ${BOLD}$ip${RESET}..."
    nmap -sV -Pn --script=vuln $ip > /tmp/vuln_results
    echo
    echo "${CYAN}Se han encontrado las siguientes vulnerabilidades:${RESET}"
    cat /tmp/vuln_results
    rm /tmp/vuln_results
    echo "${BOLD}${UNDERLINE}==============================================================================${RESET}"
}

# Función para buscar exploits por CVE
exploit_finder() {
    clear
    echo "${BOLD}${UNDERLINE}========= Buscar Exploit por Vulnerabilidad (CVE) =========${RESET}"
    while true; do
        echo "${CYAN}Indique el CVE que quiere buscar:${RESET}"
        read CVE

        # Verificar si la entrada contiene la palabra CVE
        if [ -n "$(echo "$CVE" | grep "CVE")" ]; then
            echo "${CYAN}Buscando un exploit para la vulnerabilidad ${BOLD}$CVE${RESET}..."
            sleep 3
            clear
            echo "${CYAN}Resultados encontrados para la vulnerabilidad ${BOLD}$CVE${RESET}!"
            msfconsole -q -x "search $CVE; exit" | grep exploit
            break
        else
            echo "${RED}Solo se admiten vulnerabilidades en formato CVE. Inténtalo de nuevo.${RESET}"
        fi
    done
    echo "${BOLD}${UNDERLINE}===========================================================${RESET}"
}

exploit_runner() {
    while true; do
        clear
        echo "${BOLD}${UNDERLINE}============================ Explotar Host Vulnerable ============================${RESET}"
        echo "${CYAN}Escriba la vulnerabilidad que desea explotar usando Metasploit:${RESET}"
        read -r vuln
        echo "${CYAN}Escriba la dirección IP que va a atacar:${RESET}"
        read -r ip2
        clear
        echo "${CYAN}¡Atacando con la vulnerabilidad ${BOLD}$vuln${CYAN} al host ${BOLD}$ip2${CYAN}!${RESET}"
        
        # Ejecutar Metasploit
        msfconsole -q -x "use $vuln; set RHOSTS $ip2; run;"
        
    done

    echo "${BOLD}${UNDERLINE}=================================================================================${RESET}"
}

# Menú principal
clear
while true; do
    echo "${BOLD}${UNDERLINE}============================= Menú Principal =============================${RESET}"
    echo "${CYAN}Seleccione una opción:${RESET}"
    echo "${YELLOW}1. Buscar Equipos en una Subred${RESET}"
    echo "${YELLOW}2. Escanear Vulnerabilidades en un Host${RESET}"
    echo "${YELLOW}3. Buscar Exploit por Vulnerabilidad (CVE)${RESET}"
    echo "${YELLOW}4. Explotar Host Vulnerable${RESET}"
    echo "${YELLOW}5. Salir${RESET}"

    read opcion

    case $opcion in
        1) host_finder ;;
        2) exploit_scanner ;;
        3) exploit_finder ;;
        4) exploit_runner ;;
        5) exit ;;
        *) echo "${RED}Opción no válida. Inténtelo de nuevo.${RESET}" ;;
    esac
done