#!/bin/bash

source moduły/version.txt
source moduły/data.sh
source moduły/config.sh
source moduły/colors.sh
source moduły/apps.sh
source moduły/test.sh

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
echo -e ${BWhite}Aktualna wersja skryptu: $SCRIPT_VERSION${NC}
}


check_ram(){
    echo "Konfiguracja limitów pamięci:"
        log "Konfiguracja limitów pamięci:"
    echo
    echo -e "  ${Blue}Minimalny rozmiar pamięci serwera (Xms): ${UBlue}$MIN_MEMORY${NC}."
        log  "Minimalny rozmiar pamięci serwera (Xms): $MIN_MEMORY."
    echo -e "  ${Green}Maksymalny rozmiar pamięci (Xmx): ${UGreen}$MAX_MEMORY${NC}."
        log "Maksymalny rozmiar pamięci (Xmx): $MAX_MEMORY."
    echo ------------------------------------------------------------------------

}

check_colors(){
    # Testuj kolory
echo "
Sprawdzanie kolorów"
    log "Sprawdzanie kolorów"
echo -e "Brak koloru ${NC} Tekst przywrócony do domyślnego koloru."
echo -e "${RED}Czerwony tekst.${NC}"
echo -e "${LightRed}Jasnoczerwony tekst.${NC}"
echo -e "${Yellow}Żółty tekst.${NC}"
echo -e "${Green}Zielony tekst.${NC}"
echo -e "${Blue}Niebieski tekst.${NC}"
echo -e "${Purple}Fioletowy tekst.${NC}"
echo -e "${Cyan}Cyjan tekst.${NC}"
echo -e "${White}Biały tekst.${NC}"
echo -e "${BBlack}Czarny tekst (Pogrubiony).${NC}"
echo -e "${BWhite}Biały tekst (Pogrubiony).${NC}"
echo -e "${BIRed}Czerwony tekst (Pogrubiony).${NC}"
echo -e "${BIGreen}Zielony tekst (Pogrubiony).${NC}"
echo -e "${BIYellow}Żółty tekst (Pogrubiony).${NC}"
echo -e "${BIBlue}Niebieski tekst (Pogrubiony).${NC}"
echo -e "${BIPurple}Fioletowy tekst (Pogrubiony).${NC}"
echo -e "${BICyan}Cyjan tekst (Pogrubiony).${NC}"
echo -e "${On_IBlack}Czarny tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IRed}Czerwony tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IGreen}Zielony tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IYellow}Żółty tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IBlue}Niebieski tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IPurple}Fioletowy tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_ICyan}Cyjan tekst na tle o wysokiej intensywności.${NC}"
echo -e "${On_IWhite}Biały tekst na tle o wysokiej intensywności.${NC}"
echo -e "${UBlack}Podkreślony czarny tekst.${NC}"
echo -e "${URed}Podkreślony czerwony tekst.${NC}"
echo -e "${UGreen}Podkreślony zielony tekst.${NC}"
echo -e "${UYellow}Podkreślony żółty tekst.${NC}"
echo -e "${UBlue}Podkreślony niebieski tekst.${NC}"
echo -e "${UPurple}Podkreślony fioletowy tekst.${NC}"
echo -e "${UCyan}Podkreślony cyjan tekst.${NC}"
echo -e "${UWhite}Podkreślony biały tekst.${NC}"
echo -e "${IBlack}Tekst o wysokiej intensywności czarny.${NC}"
echo -e "${IRed}Tekst o wysokiej intensywności czerwony.${NC}"
echo -e "${IGreen}Tekst o wysokiej intensywności zielony.${NC}"
echo -e "${IYellow}Tekst o wysokiej intensywności żółty.${NC}"
echo -e "${IBlue}Tekst o wysokiej intensywności niebieski.${NC}"
echo -e "${IPurple}Tekst o wysokiej intensywności fioletowy.${NC}"
echo -e "${ICyan}Tekst o wysokiej intensywności cyjan.${NC}"
echo -e "${IWhite}Tekst o wysokiej intensywności biały.${NC}"
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
    local regex_pattern=".*/\\(${server_pattern^^}\\|${server_pattern,,}\\).*jar"

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
                server_type=$(basename "$jar_file" | sed -n 's/.*\(\(${server_pattern^^}\|${server_pattern,,}\)\).jar/\1/p')
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


#██████   █████   ██████ ██   ██ ██    ██ ██████  
#██   ██ ██   ██ ██      ██  ██  ██    ██ ██   ██ 
#██████  ███████ ██      █████   ██    ██ ██████  
#██   ██ ██   ██ ██      ██  ██  ██    ██ ██      
#██████  ██   ██  ██████ ██   ██  ██████  ██ 


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Funkcja zapisująca dziennik zdarzeń do pliku
save_logs() {
        echo "Rozpoczęto kopiowanie najnowszego logu (latest.log)."
        log "Rozpoczęto kopiowanie najnowszego logu (latest.log)."

        
            # Tworzenie katalogu dla dzienników zdarzeń bieżącego dnia
            mkdir -p "$LOGS_DIR/$DATE2"

            # Kopiowanie wszystkich plików dzienników zdarzeń z bieżącego dnia
            find "$SERVER_DIR/logs" -name "*.log.gz" -newermt "$DATE3" -exec cp {} "$LOGS_DIR/$DATE2/" \;
            find "$SERVER_DIR/logs/minecraft_script/" -name "*.log" -newermt "$DATE3" -exec cp {} "$LOGS_DIR/$DATE2/" \;
            find "$SERVER_DIR/crash-reports" -name "*.txt" -newermt "$DATE3" -exec cp {} "$LOGS_DIR/$DATE2/" \;
            cp "$SERVER_DIR/logs/latest.log" "$LOGS_DIR/$DATE2/latest_$DATE2.log"


        echo "Zakończono kopiowanie najnowszego logu (latest.log)." 
        log "Zakończono kopiowanie najnowszego logu (latest.log)."
}


# Automatyczne usuwanie starszych dziennik zdarzeń
cleanup_logs() {
        echo "Rozpoczęto usuwanie starszych dzienników zdarzeń (logów) starsze niż 7 dni."
        log "Rozpoczęto usuwanie starszych dzienników zdarzeń (logów) starsze niż 7 dni."


            find "$SERVER_DIR/logs/minecraft_script/" -name "$DATE2" -mtime +7 -exec rm {} \;
            find "$SERVER_DIR/logs/" -name "$DATE2" -mtime +7 -exec rm {} \;
            find "$SERVER_DIR/crash-reports/" -name "$DATE5" -mtime +7 -exec rm {} \;



        echo "Zakończono usuwanie starszych dzienników zdarzeń (logów) starsze niż 7 dni."
        log "Zakończono usuwanie starszych dzienników zdarzeń (logów) starsze niż 7 dni."
}

# Automatyczne usuwanie starszych kopii zapasowych dziennik zdarzeń
cleanup_backup_logs() {
        echo "Rozpoczęto usuwanie starszych kopii zapasowych dziennik zdarzeń."
        log "Rozpoczęto usuwanie starszych kopii zapasowych dziennik zdarzeń."


            find "$LOGS_DIR" -name "$DATE2" -mtime +14 -exec rm {} \;


        echo "Zakończono usuwanie starszych kopii zapasowych dziennik zdarzeń."
        log "Zakończono usuwanie starszych kopii zapasowych dziennik zdarzeń."
}

# Funkcja tworząca kopię zapasową całego katalogu serwera
backup_directory() {
        echo "Rozpoczęto tworząca kopię zapasową całego katalogu serwera."
        log "Rozpoczęto tworząca kopię zapasową całego katalogu serwera."


            tar -czvf "$BACKUP_DIR/directory_$DATE.tar.gz" -C "$SERVER_DIR" .


        echo "Zakończono tworząca kopię zapasową całego katalogu serwera."
        log "Zakończono tworząca kopię zapasową całego katalogu serwera."
}

# Automatyczne usuwanie starszych kopii zapasowych katalogu serwera
backup_cleanup_directory() {
        echo "Rozpoczęto usuwanie starszych kopii zapasowych."
        log "Rozpoczęto usuwanie starszych kopii zapasowych."


            find "$BACKUP_DIR" -name "directory_*.tar.gz" -mtime +7 -exec rm {} \;
       
        
        echo "Zakończono usuwanie starszych kopii zapasowych."
        log "Zakończono usuwanie starszych kopii zapasowych."
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#███████ ██    ██ ███████ ████████ ███████ ███    ███      ██████ ████████ ██      
#██       ██  ██  ██         ██    ██      ████  ████     ██         ██    ██      
#███████   ████   ███████    ██    █████   ██ ████ ██     ██         ██    ██      
#     ██    ██         ██    ██    ██      ██  ██  ██     ██         ██    ██      
#███████    ██    ███████    ██    ███████ ██      ██      ██████    ██    ███████  


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Domyślna funkcja uruchamiająca serwer Minecraft
start_default_server() {
        #log "Rozpoczęto uruchamianie serwera Minecraft."


            cd "$SERVER_DIR"
            $SCREEN_PATH -S $SCREEN_SESSION_NAME -d -m $JAVA_PATH $JVM_OPTIONS -jar $SERVER_JAR nogui


    # Sprawdź, czy proces uruchamiania serwera faktycznie wystartował
    if [ $? -eq 0 ]; then
            log "Serwer Minecraft został pomyślnie uruchomiony."
    else
        log "Wystąpił nieoczekiwany błąd podczas uruchamiania serwera."
    fi
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#██████   ██████  ██████  ███████ ████████  █████  ██     ██  ██████  ██     ██ ███████     ███████ ██    ██ ███    ██ ██   ██  ██████      ██ ███████ 
#██   ██ ██    ██ ██   ██ ██         ██    ██   ██ ██     ██ ██    ██ ██     ██ ██          ██      ██    ██ ████   ██ ██  ██  ██           ██ ██      
#██████  ██    ██ ██   ██ ███████    ██    ███████ ██  █  ██ ██    ██ ██  █  ██ █████       █████   ██    ██ ██ ██  ██ █████   ██           ██ █████   
#██      ██    ██ ██   ██      ██    ██    ██   ██ ██ ███ ██ ██    ██ ██ ███ ██ ██          ██      ██    ██ ██  ██ ██ ██  ██  ██      ██   ██ ██      
#██       ██████  ██████  ███████    ██    ██   ██  ███ ███   ██████   ███ ███  ███████     ██       ██████  ██   ████ ██   ██  ██████  █████  ███████ 


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Funkcja uruchamiająca serwer Minecraft
start_server() {
        echo "Rozpoczęto uruchamianie serwera Minecraft."
        log "Rozpoczęto uruchamianie serwera Minecraft."


            cd "$SERVER_DIR"
            $SCREEN_PATH -dmS $SCREEN_SESSION_NAME -d -m $JAVA_PATH $JVM_OPTIONS -jar $SERVER_JAR nogui 2>&1 | tee -a "$LOG_FILE"


    # Sprawdź, czy proces uruchamiania serwera faktycznie wystartował
    if [ $? -eq 0 ]; then
            echo "Serwer Minecraft został pomyślnie uruchomiony."
            log "Serwer Minecraft został pomyślnie uruchomiony."
    else
        echo "Wystąpił nieoczekiwany błąd podczas uruchamiania serwera."
        log "Wystąpił nieoczekiwany błąd podczas uruchamiania serwera."
    fi
}

# Funkcja zatrzymująca serwer Minecraft
stop_server() {
        echo "Rozpoczęto zatrzymanie serwera Minecraft"
        log "Rozpoczęto zatrzymanie serwera Minecraft."

            # Sprawdź, czy sesja screena istnieje, a serwer działa
            if screen -list | grep -q "$SCREEN_SESSION_NAME"; then

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -p 0 -X stuff "say SERWER ZOSTANIE WYŁĄCZONY ZA 10 SEKUND."'\\15'
            $SLEEP_PATH 10
            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -p 0 -X stuff "say Zapisywanie mapy...."\\15

        echo "Rozpoczęto Zapisywanie mapy."    
        log "Rozpoczęto Zapisywanie mapy."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -p 0 -X stuff "save-all^M"\\15

        echo "Zakończono Zapisywanie mapy."
        log "Zakończono Zapisywanie mapy."

            $SLEEP_PATH 5

        echo "Rozpoczęto zatrzymanie serwera Minecraft."
        log "Rozpoczęto zatrzymanie serwera Minecraft."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -p 0 -X stuff "stop^M"\\15
            $SLEEP_PATH 10

        echo "Zakończono zatrzymanie serwera Minecraft."
        log "Zakończono zatrzymanie serwera Minecraft."
    else
        echo "Sesja screena Minecraft nie istnieje lub serwer nie działa."
        log "Sesja screena Minecraft nie istnieje lub serwer nie działa."
    fi

}

# Funkcja restartująca serwer Minecraft
restart_server() {
            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -X stuff "say SERWER ZOSTANIE ZRESETOWANY ZA x SEKUND."\\15
            $SLEEP_PATH 10
            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -X stuff "say Zapisywanie mapy...."\\15

        echo "Rozpoczęto Zapisywanie mapy."    
        log "Rozpoczęto Zapisywanie mapy."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -X stuff "save-all^M"\\15

        echo "Zakończono Zapisywanie mapy."
        log "Zakończono Zapisywanie mapy."

            $SLEEP_PATH 5

        echo "Rozpoczęto zatrzymanie serwera Minecraft."
        log "Rozpoczęto zatrzymanie serwera Minecraft."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -X stuff "stop^M"\\15

        echo "Zakończono zatrzymanie serwera Minecraft."
        log "Zakończono zatrzymanie serwera Minecraft."

            $SLEEP_PATH 10
            start_server
}
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#███████  █████   █████  ██     ██  █████  ███    ██ ███████  ██████  ██     ██  █████  ███    ██ ███████     ███████ ██    ██ ███    ██ ██   ██  ██████      ██ ███████ 
#   ███  ██   ██ ██   ██ ██     ██ ██   ██ ████   ██ ██      ██    ██ ██     ██ ██   ██ ████   ██ ██          ██      ██    ██ ████   ██ ██  ██  ██           ██ ██      
#  ███   ███████ ███████ ██  █  ██ ███████ ██ ██  ██ ███████ ██    ██ ██  █  ██ ███████ ██ ██  ██ █████       █████   ██    ██ ██ ██  ██ █████   ██           ██ █████   
# ███    ██   ██ ██   ██ ██ ███ ██ ██   ██ ██  ██ ██      ██ ██    ██ ██ ███ ██ ██   ██ ██  ██ ██ ██          ██      ██    ██ ██  ██ ██ ██  ██  ██      ██   ██ ██      
#███████ ██   ██ ██   ██  ███ ███  ██   ██ ██   ████ ███████  ██████   ███ ███  ██   ██ ██   ████ ███████     ██       ██████  ██   ████ ██   ██  ██████  █████  ███████ 


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Funkcja przeładowująca serwer Minecraft
reload_server() {
        echo "Rozpoczęto przeładowanei serwera (reload)."
        log "Rozpoczęto przeładowanei serwera (reload)."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME -X stuff "reload^M"

        echo "Zakończono przeładowanie serwera (reload)."
        log "Zakończono przeładowanie serwera (reload)."
}

# Funkcja do połączenia się z konsolą serwera Minecraft
connect_server() {
        echo "Połączono do konsoli."
        log "Połączono do konsoli."

            $SCREEN_PATH -rd $SCREEN_SESSION_NAME 
            
        echo "Rozłączono od konsoli."
        log "Rozłączono od konsoli."
}

# Funkcja pyta użytkownika o zatwierdzenie lub odrzucenie EULI
eula_server() {
    echo "Witaj w serwerze Minecraft. Przed rozpoczęciem gry musisz zaakceptować EULĘ (End User License Agreement) - (https://aka.ms/MinecraftEULA)."
    echo -e "Czy akceptujesz EULĘ? (${Green}tak${NC}/${RED}nie${NC}): " 
    read response
    case "$response" in
        [tT][aA][kK]|[tT])
            echo -e "${Green}Zatwierdziłeś EULĘ. Możesz teraz kontynuować.${NC}"
            log "Zatwierdziłeś EULĘ. Możesz teraz kontynuować."
            echo -e "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).\n#$DATE4\neula=True" > $SERVER_DIR/eula.txt
            ;;
        [nN][iI][eE]|[nN])
            echo -e "${RED}Odrzuciłeś EULĘ. Serwer Minecraft nie zostanie uruchomiony.${NC}"
            log "Odrzuciłeś EULĘ. Serwer Minecraft nie zostanie uruchomiony."
            echo -e "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://aka.ms/MinecraftEULA).\n#$DATE4\neula=False" > $SERVER_DIR/eula.txt
            ;;
        *)
            echo -e "Niepoprawna odpowiedź. Proszę odpowiedzieć '${Green}tak${NC}' lub '${RED}nie${NC}'."
            log "Niepoprawna odpowiedź. EULA Proszę odpowiedzieć 'tak' lub 'nie'."
            eula_server # Ponownie wywołaj funkcję, aby dostać poprawną odpowiedź
            ;;
    esac
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#███████ ██    ██ ███████ ████████ ███████ ███    ███     ██     ███████ ██   ██ ██████  ██    ██ ██████  ████████ 
#██       ██  ██  ██         ██    ██      ████  ████     ██     ██      ██  ██  ██   ██  ██  ██  ██   ██    ██    
#███████   ████   ███████    ██    █████   ██ ████ ██     ██     ███████ █████   ██████    ████   ██████     ██    
#     ██    ██         ██    ██    ██      ██  ██  ██     ██          ██ ██  ██  ██   ██    ██    ██         ██    
#███████    ██    ███████    ██    ███████ ██      ██     ██     ███████ ██   ██ ██   ██    ██    ██         ██  


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
check_update_script() {

    if $AUTO_UPDATE; then

        new_version=$(wget -qO- https://raw.githubusercontent.com/PanRomekPL/minecraft-serwer-start.sh/main/version.txt)
        if [ "$SCRIPT_VERSION" \< "$new_version" ]; then
            echo " "
            echo -e "Nowa wersja dostępna: ${Cyan}$new_version${NC}"
            echo -e "Obecna wersja: ${Cyan}$SCRIPT_VERSION${NC}"
            echo " "
            update() {
                echo -e "${On_IRed}!!!Obecna wersja skryptu zostanie usunięta w celu przeprowadzenia aktualizacji razem z wdrożonymi ustawieniami użytkownika.!!!${NC}"
                echo ------------------------------------------------------------------------------------------------------------------------------
                echo -e "${BWhite}Obecna wersja skryptu startowego zostanę skopiowana do katalogu „$SERVER_DIR/script_backup${NC}”"
                echo ------------------------------------------------------------------------------------------------------------------------------
                echo -e  "${BWhite}Czy chcesz zainstalować najnowszą wersję?${NC} (${Green}tak${NC}/${RED}nie${NC})"
                read answer
                answer=$(echo $answer | tr '[:upper:]' '[:lower:]')
                case $answer in
                    "y"|"yes"|"t"|"tak")
                        echo Tworzenie kopii zapasowej skryptu startowego serwera Minecraft.
                        mkdir -p $SERVER_DIR/script_backup
                        cp -r $SERVER_DIR/*.sh $SERVER_DIR/script_backup/
                        echo " "
                        echo "Najnowsza wersja zostanie pobrana."
                        echo "Następnie należy uruchomić skrypt ponownie."
                        echo -e "${BBlack}"
                        sleep 2

                        latest_release=$($WGET_PATH -qO- https://api.github.com/repos/PanRomekPL/minecraft-serwer-start.sh/releases/latest)
                        download_link=$(echo "$latest_release" | grep browser_download_url | grep start.sh | cut -d '"' -f 4)
                        $WGET_PATH "$download_link" -O start.sh

                        echo "${BWhite}Aktualizacja skryptu została zakończona z sukcesem${NC}"
                        exit 0
                        ;;
                    "n"|"no"|"nie")
                        echo " "
                        echo -e "${On_IRed}Najnowsza wersja nie zostanie pobrana.${NC}"
                        ;;
                        *)
                        echo
                        echo -e "${On_IYellow}Nieznane polecenie!${NC}"
                        echo
                        update
                        ;;
                esac
            }

            update
        fi
    fi
}

script_debug(){
    bash -x start.sh test
}

# Funkcja do uruchamiania ponownego całego systemu
reboot-system_server() {

            stop_server
    
        echo "Rozpoczęto uruchamianie ponowne całego systemu."
        log "Rozpoczęto uruchamianie ponowne całego systemu."

            sudo reboot
            
}

# Funkcja do uruchamiania ponownego całego systemu
shutdown-system_server() {

            stop_server
    
        echo "Rozpoczęto wyłączanie całego systemu."
        log "Rozpoczęto wyłączanie całego systemu."

            sudo shutdown now
            
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# ██████  ██████  ███████ ██    ██  ██████   █████       █████  ██████   ██████  ██    ██ ███    ███ ███████ ███    ██ ████████ ██     ██ 
#██    ██ ██   ██ ██      ██    ██ ██       ██   ██     ██   ██ ██   ██ ██       ██    ██ ████  ████ ██      ████   ██    ██    ██     ██ 
#██    ██ ██████  ███████ ██    ██ ██   ███ ███████     ███████ ██████  ██   ███ ██    ██ ██ ████ ██ █████   ██ ██  ██    ██    ██  █  ██ 
#██    ██ ██   ██      ██ ██    ██ ██    ██ ██   ██     ██   ██ ██   ██ ██    ██ ██    ██ ██  ██  ██ ██      ██  ██ ██    ██    ██ ███ ██ 
# ██████  ██████  ███████  ██████   ██████  ██   ██     ██   ██ ██   ██  ██████   ██████  ██      ██ ███████ ██   ████    ██     ███ ███  


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Obsługa argumentów
case "$1" in
    start)
        start_server
        ;;
    stop)
        stop_server
        ;;
    restart)
        echo "Rozpoczęto uruchomienie ponowne serwera Minecraft."
        log "Rozpoczęto uruchomienie ponowne serwera Minecraft."
            #stop_server
            #save_logs
            #backup_cleanup_directory
            #backup_directory
            restart_server
        echo "Zakończono uruchomienie ponowne serwera Minecraft."
        log "Zakończono uruchomienie ponowne serwera Minecraft."
        ;;
    reload)
        reload_server
        ;;
    connect)
        connect_server
        ;;
     check)
        echo "Rozpoczęto sprawdzanie wymaganych zasobów."
        log "Rozpoczęto sprawdzanie wymaganych zasobów."
            check_colors
            check_programs
            check_directories
            check_files
            check_eula
            check_ram
            find_all_minecraft_servers
            monitor_logs
        echo "Pomyślnie zakończono sprawdzanie wymaganych zasobów."
        log "Pomyślnie zakończono sprawdzanie wymaganych zasobów."
        ;;
    eula)
        eula_server
        ;;
    search_files)
        search_for_files
        ;;
    save_logs)
        save_logs
        ;;
    backup_directory)
        backup_directory
        ;;
    backup_cleanup)
        backup_cleanup_directory
        ;;
    cleanup_logs)
        cleanup_logs
        ;;
    cleanup_backup_logs)
        cleanup_backup_logs
        ;;
    update_script)
        check_update_script
        ;;
    script_debug)
        script_debug
        ;;
    reboot_system)
        reboot-system_server
        ;;
    shutdown_system)
        shutdown-system_server
        ;;
    start_default)
        start_default_server
        ;;
    test)
        test_test
        ;;
        *)
        echo -e "Użycie: ${LightRed}$0${NC} {${Yellow}start${NC}|${Yellow}stop${NC}|${Yellow}restart${NC}|...}

        Podstawowe funkcje    
            ${Yellow}start${NC} - Uruchamianie serwera minecraft 
            ${Yellow}stop${NC} - Zatrzymanie serwera minecraft
            ${Yellow}restart${NC} - Resetowanie serwera minecraft
            
         Zaawansowane funkcje    
            ${Yellow}reload${NC} - Przeładowanie serwera minecraft
            ${Yellow}connect${NC} - Połączenie do konsoli serwera minecraft
            ${Yellow}check${NC} - Sprawdzanie istnienia katalogów, plików i programów
            ${Yellow}eula${NC} - 
            ${Yellow}search_files${NC} - 
            
        Tworzenie Kopi zapasowych i logów     
            ${Yellow}save_logs${NC} - Kopiowanie ostatniego dziennika zdarzeń do innego folderu 
            ${Yellow}backup_directory${NC} - Tworząca kopię zapasową całego katalogu serwera

        Usuwanei startch Kopi zapasowych i logów      
            ${Yellow}cleanup_logs${NC} - 
            ${Yellow}backup_cleanup${NC} - Usuwanie starszych kopi niż 7 dni katalogu serwera
            ${Yellow}cleanup_backup_logs${NC} - Usuwanie starszych kopii niż 7 dni zapasowych dziennik zdarzeń
            
        System i skrypt
            ${Yellow}reboot_system${NC} - Serwer minecraft zostanie wyłączony a potem zostanie uruchomiony ponownie cały system
            ${Yellow}shutdown_system${NC} - Serwer minecraft zostanie wyłączony a potem zostanie wyłączony cały system
            ${Yellow}update_script${NC} - 
            ${Yellow}script_debug${NC} - 
            
        SystemD
            ${Yellow}start_default${NC} - 

${BWhite}Aktualna wersja skryptu: $SCRIPT_VERSION${NC}"
        exit 1
        ;;

esac
exit 0
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
