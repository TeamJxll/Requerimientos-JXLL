function banertor {
    sleep 0.5
    clear

    echo -e "\e[31m ===================================\e[0m"
    echo -e "\e[36m    ___     ___    ___ ___       ___          "
    echo -e "\e[36m   |\  \   |\  \  /  /|\  \     |\  \         "
    echo -e "\e[36m   \ \  \  \ \  \/  / | \  \    \ \  \        "
    echo -e "\e[36m __ \ \  \  \ \    / / \ \  \    \ \  \       "
    echo -e "\e[36m|\  \\_\   \  /     \/   \ \  \____\ \  \____  "
    echo -e "\e[36m\ \________\/  /\   \    \ \_______\ \______\ " 
    echo -e "\e[36m  \________|__|/ \|__|    \_______/ \_______/   "
    echo -e "\e[36m                                              "
    echo -e "\e[31m ===================================\e[0m"
    echo -e "\e[36m[\e[0m""\e[1;31m1\e[0m""\e[36m]\e[0m" "\e[32mInstalar todos los paquetes de Termux"
    echo -e "\e[36m[\e[0m""\e[1;31m2\e[0m""\e[36m]\e[0m" "\e[32mInstalar banners para termux"
    echo -e "\e[36m[\e[0m""\e[1;31m3\e[0m""\e[36m]\e[0m" "\e[32mInstalar Efecto Matrix "
    echo -e "\e[36m[\e[0m""\e[1;31m4\e[0m""\e[36m]\e[0m" "\e[32mSalir " 
}

# Menú interactivo
while true; do
    banertor
    echo -ne "> Escoje Una Opcion: "
    read -r Opcion_Incog

    # Verifica la opción seleccionada
    if [ "$Opcion_Incog" == "1" ] || [ "$Opcion_Incog" == "2" ] || [ "$Opcion_Incog" == "3" ] || [ "$Opcion_Incog" == "4" ]; then
        break
    fi

    echo -e "\e[31mIncognito no reconoce esa opción :? "
    sleep 1.5
done

case $Opcion_Incog in
    1)
echo -e "\e[1;34m Iniciando la descarga de los paquetes . . . . Puede Demorar "
pkg update -y &> /dev/null
echo -e "\e[1;34m Empezando..."

# Longitud total de la barra de carga
total=20

for i in {5..100..5}; do
    # Calcula cuántos caracteres de barra de progreso mostrar
    progress=$((i * total / 100))
    bar=$(printf "%-${total}s" "#" | sed "s/ /#/g" | cut -c1-$progress)

    # Muestra la barra de carga
    echo -ne "\r\e[1;34m Instalando ..... $i% [${bar// /#}]"

    case $i in
        5) pkg install ruby -y &> /dev/null ;;
        10) git pull &> /dev/null ;;
        15) pkg update -y &> /dev/null ;;
        20) pkg upgrade -y &> /dev/null ;;
        23) pkg install python -y &> /dev/null ;;
        28) pkg install git -y &> /dev/null ;;
        29) pkg install nano -y &> /dev/null ;;
        30) pip install openssl -y &> /dev/null ;;
        32) pkg install openssl -y &> /dev/null ;;
        35) pkg install openssh -y &> /dev/null ;;
        40) termux-setup-storage -y &> /dev/null ;;
        45) pip install requests -y &> /dev/null ;;
        50) pkg install tor -y &> /dev/null ;;
        55) pkg install curl -y &> /dev/null ;;
        58) pip install curl -y &> /dev/null ;;
        60) pip install tor -y &> /dev/null ;;
        65) pip2 install mechanize -y &> /dev/null ;;
        66) pkg install git php curl openssh grep -y &> /dev/null ;;
        67) pip install stem -y &> /dev/null ;;
        78) pip install mechanize -y &> /dev/null ;;
        80) pip2 install mechanize -y &> /dev/null ;;
        82) pip install php -y &> /dev/null ;;
        85) pip install tor -y &> /dev/null ;;
        87) pip3 install requests -y &> /dev/null ;;
        93) pip3 install clint -y &> /dev/null ;;
        95) pip3 install coloramas -y &> /dev/null ;;
        98) pkg install w3m -y &> /dev/null ;;
        99) pkg install wget -y &> /dev/null ;;
        100) pkg install w3m -y &> /dev/null ;;
    esac
done

# Mensaje final de la instalación de los paquetes
echo -e "\e[36m Finalizando la Instalación de paquetes ...."

# Mostrar el banner y el menú nuevamente
banertor

        ;;
        2)
# Función para instalar dependencias
instalar_dependencias() {
    RED='\e[31m'
    GREEN='\e[32m'
    CYAN='\e[36m'
    NC='\e[0m'

    echo -e "${CYAN}Comprobando dependencias...${NC}"

    # Verificar si estamos en Termux
    if command -v pkg &> /dev/null; then
        gestor_paquete="pkg"
    elif command -v apt &> /dev/null; then
        gestor_paquete="apt"
    else
        echo -e "${RED}No se encontró un gestor de paquetes compatible (pkg/apt). Instale 'jp2a' o 'imagemagick' manualmente.${NC}"
        exit 1
    fi

    # Verificar si jp2a está instalado, si no, instalarlo
    if ! command -v jp2a &> /dev/null; then
        echo -e "${RED}No se encontró 'jp2a'. Instalando...${NC}"
        $gestor_paquete install jp2a -y
    fi

    # Verificar si ImageMagick está instalado, si no, instalarlo
    if ! command -v convert &> /dev/null; then
        echo -e "${RED}No se encontró 'convert'. Instalando ImageMagick...${NC}"
        $gestor_paquete install imagemagick -y
    fi

    echo -e "${GREEN}Dependencias instaladas correctamente.${NC}"
}

# Función para convertir imagen a ASCII
convertir_ascii() {
    RED='\e[31m'
    CYAN='\e[36m'
    GREEN='\e[32m'
    NC='\e[0m'

    echo -e "${CYAN}Ingrese la URL de la imagen: ${NC}"
    read URL

    IMG_NAME="imagen_temp.jpg"
    ASCII_FILE="$HOME/.termux_banner"

    echo -e "${GREEN}Descargando imagen...${NC}"
    curl -s -o $IMG_NAME "$URL"

    # Verificar si la imagen se descargó correctamente
    if [ ! -f "$IMG_NAME" ]; then
        echo -e "${RED}Error al descargar la imagen.${NC}"
        exit 1
    fi

    # Verificar si jp2a está instalado
    if command -v jp2a &> /dev/null; then
        echo -e "${GREEN}Convirtiendo imagen a ASCII con jp2a...${NC}"
        jp2a --width=50 "$IMG_NAME" > "$ASCII_FILE"
    # Si no está instalado, verificar si ImageMagick está disponible
    elif command -v convert &> /dev/null; then
        echo -e "${GREEN}Convirtiendo imagen con ImageMagick...${NC}"
        convert "$IMG_NAME" -resize 100x100! txt:- | awk 'NR>1 {print $0}' > "$ASCII_FILE"
    else
        # Si ninguno de los comandos está instalado, mostrar un error
        echo -e "${RED}Error: No se encontró 'jp2a' ni 'convert'. Instale uno de ellos.${NC}"
        exit 1
    fi

    # Verificar si ya se ha configurado el banner en .bashrc
    if ! grep -q "cat $ASCII_FILE" ~/.bashrc; then
        echo -e "${GREEN}Configurando banner en Termux...${NC}"
        echo "clear" >> ~/.bashrc
        echo "cat $ASCII_FILE" >> ~/.bashrc
    fi

    echo -e "${GREEN}¡Banner configurado! Reinicia Termux para ver los cambios.${NC}"

    # Eliminar la imagen temporal después de usarla
    rm -f "$IMG_NAME"
}

# Menú interactivo
while true; do
    echo -e "${CYAN}==================================${NC}"
    echo -e "${CYAN}      CONFIGURAR BANNER ASCII    ${NC}"
    echo -e "${CYAN}==================================${NC}"
    echo -e "${CYAN}[${NC}${RED}1${NC}${CYAN}]${NC} ${GREEN}Convertir imagen desde URL y configurar banner${NC}"
    echo -e "${CYAN}[${NC}${RED}2${NC}${CYAN}]${NC} ${GREEN}Salir${NC}"
    echo -ne "${CYAN}>>> ${NC}"
    read opcion

    # Instalar dependencias automáticamente antes de continuar
    instalar_dependencias

    case $opcion in
        1) convertir_ascii ;;  # Llamar a la función para convertir la imagen
        2) echo -e "${RED}Saliendo...${NC}"; exit ;;  # Salir del script
        *) echo -e "${RED}Opción inválida.${NC}" ;;  # Opción no válida
    esac
done

            ;;
        3)
            echo -e "\e[32m Instalando Cmatrix"
            pkg install cmatrix
            cmatrix
            ;;
        4)
            echo -e "\e[1;35m Incógnito se despide :) "
            exit
            ;;
        *)
            echo -e "\e[31mOpción no válida.\e[0m"
            ;;
    esac

