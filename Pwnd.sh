#!bin/bash
echo
echo "Pwnd.sh Script para vulnerar sistemas."
echo
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
host_finder(){
    echo "Introduzca la subred que va a escanear:" 
    read ip
    echo "Buscando equipos en la subred:$ip..." 
    nmap -sn $ip > /tmp/host_results
    echo
    echo "Se han encontrado los siguientes equipos:"
    cat /tmp/host_results | grep open
    rm /tmp/host_results
}

exploit_scanner(){
    echo "Introduzca el equipo que va a escanear:" 
    read ip
    echo "Buscando puertos abiertos en la IP:$ip2..." 
    nmap -sV -Pn --script=vuln $ip2 > /tmp/vuln_results
    echo
    echo "Se han encontrado los puertos siguientes puertos abiertos:"
    cat /tmp/vuln_results | grep open
    rm /tmp/vuln_results
}

exploit_finder(){
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

exploit_runner(){

}

