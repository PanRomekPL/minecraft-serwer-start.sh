

# ██████ ██   ██ ███████  ██████ ██   ██     ██     ██       ██████   ██████  ██ 
#██      ██   ██ ██      ██      ██  ██      ██     ██      ██    ██ ██       ██ 
#██      ███████ █████   ██      █████       ██     ██      ██    ██ ██   ███ ██ 
#██      ██   ██ ██      ██      ██  ██      ██     ██      ██    ██ ██    ██ ██ 
# ██████ ██   ██ ███████  ██████ ██   ██     ██     ███████  ██████   ██████  ██ 


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Funkcja do logów dziennika działań pliku startowego
log() {
    mkdir -p "$(dirname "$LOG_FILE")"
    echo "$(date +"%d-%m-%Y %H:%M:%S") - $1" >> "$LOG_FILE"
}

# Funkcja do sprawdzania istnienia programów i pokazanie ich lokalizacji 
check_program_existence() {
    command -v "$1" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${Green}Program $1 - jest zainstalowany.${NC}"
        command -v "$1"
        log "Program $1  - jest zainstalowany."
    else
        echo -e "${RED} Program $1 - nie jest zainstalowany.${NC}"
        log "Program $1 - nie jest zainstalowany."
    fi
}

# Funkcja sprawdzająca istnienie katalogu
check_directory_existence() {
    if [ -d "$1" ]; then
        echo -e "${Green}Katalog $1 - istnieje.${NC}"
        log "Katalog $1 - istnieje."
    else
        echo -e "${RED} Katalog $1 - nie istnieje.${NC}"
        log "Katalog $1 - nie istnieje."
    fi
}

# Funkcja sprawdzająca istnienie pliku
check_file_existence() {
    if [ -f "$1" ]; then
        echo -e "${Green}Plik $1 - istnieje.${NC}"
        log "Plik $1 - istnieje."
    else
        echo -e "${RED} Plik $1 - nie istnieje.${NC}"
        log "Plik $1 - nie istnieje."
    fi
}


# Funkcja do sprawdzania istnienia programów
check_programs() {
    echo
    echo Sprawdzanie programów
    check_program_existence "$JAVA_PATH"
    echo
    check_program_existence "$SCREEN_PATH"
    echo
    check_program_existence "$SLEEP_PATH"
    echo
    check_program_existence "$TREE_PATH"
    echo
    check_program_existence "$SUDO_PATH"
    echo
    check_program_existence "$WGET_PATH"
    echo
}

# Funkcja do sprawdzania istnienia katalogów
check_directories() {
    echo
    echo Sprawdzanie katalogów 
    echo
    echo "Zalecane"
        check_directory_existence "$SERVER_DIR"
        echo
        check_directory_existence "$(dirname "$LOG_FILE")"
        echo
        echo "Opcjonalne"
        check_directory_existence "$LOGS_DIR"
        echo
        check_directory_existence "$BACKUP_DIR"
    echo
}

# Funkcja do sprawdzania istnienia plików
check_files() {
    echo
    echo Sprawdzanie plików
        check_file_existence "$SERVER_JAR"
    echo
}

monitor_logs() {
    if pgrep -u $USER -f $SERVER_JAR > /dev/null ; then
        echo ------------------------------------------------------------------------
        su - $USER -c "tail -n 20 $SERVER_DIR/logs/latest.log"
        echo ------------------------------------------------------------------------
        echo -e "$SERVER_JAR ${Green}jest uruchomiony na użytkowniku ${NC}$USER."
        log "$SERVER_JAR jest uruchomiony na użytkowniku $USER."
        echo ------------------------------------------------------------------------
   else
      echo ------------------------------------------------------------------------
      echo -e "$SERVER_JAR ${RED}nie jest uruchomiony${NC}."
      log "$SERVER_JAR nie jest uruchomiony."
      echo ------------------------------------------------------------------------
   fi
}


check_ram(){
    echo "Konfiguracja limitów pamięci:"
        log "Konfiguracja limitów pamięci:"
    echo
    echo -e "  ${Blue}Minimalny rozmiar pamięci serwera (Xms): ${On_IBlue}$MIN_MEMORY${NC}."
        log  "Minimalny rozmiar pamięci serwera (Xms): $MIN_MEMORY."
    echo -e "  ${Green}Maksymalny rozmiar pamięci (Xmx): ${On_IGreen}$MAX_MEMORY${NC}."
        log "Maksymalny rozmiar pamięci (Xmx): $MAX_MEMORY."
    echo ------------------------------------------------------------------------

}

check_eula() {
    # Ścieżka do pliku eula.txt
    eula_file="$SERVER_DIR/eula.txt"

    # Sprawdź, czy plik eula.txt istnieje
    if [ -f "$eula_file" ]; then
        # Sprawdź zawartość pliku eula.txt
        eula_accepted=$(grep -oi 'eula=\(true\|false\)' "$eula_file")

        if [[ "$eula_accepted" =~ [Tt]rue ]]; then
            # EULA zaakceptowana
            echo ------------------------------------------------------------------------
            echo -e "eula.txt ${Green}jest zaakceptowana${NC}."
            log "eula.txt jest zaakceptowana."
            echo ------------------------------------------------------------------------
            # Tutaj możesz dodać odpowiednie działania

        elif [[ "$eula_accepted" =~ [Ff]alse ]]; then
            # EULA odrzucona
            echo ------------------------------------------------------------------------
            echo -e "eula.txt ${RED}nie została zaakceptowana${NC}."
            log "eula.txt nie została zaakceptowana."
            echo ------------------------------------------------------------------------
            # Tutaj możesz dodać odpowiednie działania

        else
            # Brak dopasowania
            echo ------------------------------------------------------------------------
            echo -e "${Yellow}Nie można rozpoznać stanu${NC} eula.txt."
            log "Nie można rozpoznać stanu eula.txt."
            echo ------------------------------------------------------------------------

        fi
    else
        echo ------------------------------------------------------------------------
        echo -e "${RED}Plik${NC} eula.txt ${RED}nie istnieje${NC}."
        log "Plik eula.txt nie istnieje."
        echo ------------------------------------------------------------------------
    fi
}

find_all_minecraft_servers() {
    local jar_files=()
    local search_phrase=""  # Wyszukiwana fraza

    # Tworzenie wyrażenia regularnego do wyszukiwania różnych rodzajów serwerów Minecraft
    local server_pattern="\(FTBServer\|craftbukkit\|spigot\|paper\|forge\|minecraft_server\)"

    # Utworzenie pełnego wyrażenia regularnego z podanym katalogiem i wzorcem serwera
    local regex_pattern=".*/\\($server_pattern\\).*jar"

    # Słownik mapujący typy silników na kolory
    declare -A server_colors
    server_colors=(
        ["FTBServer"]="${Yellow}"
        ["craftbukkit"]="${Blue}"
        ["spigot"]="${Green}"
        ["paper"]="${Cyan}"
        ["forge"]="${RED}"
        ["minecraft_server"]="${Purple}"
    )

    # Przeszukaj podany katalog i zapisz znalezione pliki .jar do tablicy jar_files
    echo -e "Automatyczne szukanie silnika serwera"
    echo -e "(${Yellow}FTBServer${NC}|${Blue}craftbukkit${NC}|${Purple}spigot${NC}|${Cyan}paper${NC}|${RED}forge${NC}|${Green}minecraft_server${NC})"
    echo "Znalezione silniki serwera Minecraft:"
    while IFS= read -r -d $'\0' file; do
        jar_files+=("$file")
    done < <(find "$SERVER_DIR" -type f -iregex "$regex_pattern" -print0)

    # Wyświetl znalezione pliki .jar z odpowiednimi wcięciami, uwzględnij wyszukiwaną frazę i kolory
    if [ ${#jar_files[@]} -eq 0 ]; then
        echo "Nie znaleziono serwerów Minecraft."
    else
        for ((i=0; i<${#jar_files[@]}; i++)); do
            jar_file="${jar_files[i]}"
            # Sprawdź, czy fraza występuje w dowolnej części ścieżki pliku
            if [[ "$jar_file" == *"$search_phrase"* ]]; then
                # Uzyskaj typ serwera z nazwy pliku (jeśli nie znajdzie, użyj "unknown")
                server_type=$(basename "$jar_file" | sed -n 's/.*\(\(FTBServer\|craftbukkit\|spigot\|paper\|forge\|minecraft_server\)\).jar/\1/p')
                # Uzyskaj ścieżkę katalogu nadrzędnego i plik
                directory=$(dirname "$jar_file")
                filename=$(basename "$jar_file")
                # Ustaw domyślny kolor (biały) i sprawdź, czy istnieje kolor dla danego typu serwera
                color="${On_IRed}Error brak koloru${NC} ${White}"
                if [[ -v server_colors[$server_type] ]]; then
                    color="${server_colors[$server_type]}"
                fi
                # Wyświetl nazwę pliku z odpowiednimi wcięciami przed ścieżką katalogu
                echo
                echo -e "${color}$filename${NC}"
                echo "   $directory/"
                echo
            fi
        done
    fi
}













search_for_files() {
    shift  # Usunięcie pierwszego argumentu (katalogu)
    local extensions=("jar" "txt" "cfg")
    local colors=("1;31" "32" "33")  # Kolory ANSI dla każdego formatu

    # Inicjalizacja tablicy do przechowywania pasujących plików
    local matching_files=()

    for ((i=0; i<${#extensions[@]}; i++)); do
        extension="${extensions[i]}"
        color="${colors[i]}"

        # Logowanie informacji o rozpoczęciu przeszukiwania plików
        local log_message="Rozpoczęto przeszukiwanie .$extension w katalogu $SERVER_DIR."
        log "$log_message"

        echo -e "\e[${color}mPliki .$extension w katalogu $SERVER_DIR:\e[0m"
        local regex_pattern=".*/[^/]*\\.$extension"
        while IFS= read -r -d $'\0' file; do
            matching_files+=("$file")  # Dodaj pasujący plik do tablicy
            echo -e "\e[${color}m$file\e[0m"
            echo
        done < <(find "$SERVER_DIR" -type f -iregex "$regex_pattern" -print0)
        echo

        # Logowanie informacji o zakończeniu przeszukiwania plików
        local log_message="Zakończono przeszukiwanie .$extension w katalogu $SERVER_DIR."
        log "$log_message"
    done

    # Sprawdź, czy podany katalog istnieje
    if [ ! -d "$SERVER_DIR" ]; then
        echo "Podany katalog nie istnieje: $SERVER_DIR"
        return 1
    fi

    # Wyświetl znalezione pliki
    if [ ${#matching_files[@]} -eq 0 ]; then
        echo "Nie znaleziono plików o podanych rozszerzeniach w katalogu $SERVER_DIR."
    else
        echo "Znalezione pliki o podanych rozszerzeniach w katalogu $SERVER_DIR:"
        for matching_file in "${matching_files[@]}"; do
            echo "$matching_file"
        done
    fi

    echo -------------------------------------------------------------------------------------------
    echo "Mapa katalogu serwera Minecraft."
    log "Mapa katalogu serwera Minecraft."
    $TREE_PATH $SERVER_DIR

    # Logowanie informacji o zakończeniu przeszukiwania katalogu serwera Minecraft
    log "Zakończono przeszukiwanie katalogu serwera Minecraft."
}


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
