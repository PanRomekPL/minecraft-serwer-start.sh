

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
            $SCREEN_PATH -dmS minecraft -d -m $JAVA_PATH $JVM_OPTIONS -jar $SERVER_JAR nogui 2>&1 | tee -a "$LOG_FILE"


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
            if screen -list | grep -q "minecraft"; then

            $SCREEN_PATH -rd minecraft -p 0 -X stuff "say SERWER ZOSTANIE WYŁĄCZONY ZA 10 SEKUND."'\\15'
            $SLEEP_PATH 10
            $SCREEN_PATH -rd minecraft -p 0 -X stuff "say Zapisywanie mapy...."\\15

        echo "Rozpoczęto Zapisywanie mapy."    
        log "Rozpoczęto Zapisywanie mapy."

            $SCREEN_PATH -rd minecraft -p 0 -X stuff "save-all^M"\\15

        echo "Zakończono Zapisywanie mapy."
        log "Zakończono Zapisywanie mapy."

            $SLEEP_PATH 5

        echo "Rozpoczęto zatrzymanie serwera Minecraft."
        log "Rozpoczęto zatrzymanie serwera Minecraft."

            $SCREEN_PATH -rd minecraft -p 0 -X stuff "stop^M"\\15
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
            $SCREEN_PATH -rd minecraft -X stuff "say SERWER ZOSTANIE ZRESETOWANY ZA x SEKUND."\\15
            $SLEEP_PATH 10
            $SCREEN_PATH -rd minecraft -X stuff "say Zapisywanie mapy...."\\15

        echo "Rozpoczęto Zapisywanie mapy."    
        log "Rozpoczęto Zapisywanie mapy."

            $SCREEN_PATH -rd minecraft -X stuff "save-all^M"\\15

        echo "Zakończono Zapisywanie mapy."
        log "Zakończono Zapisywanie mapy."

            $SLEEP_PATH 5

        echo "Rozpoczęto zatrzymanie serwera Minecraft."
        log "Rozpoczęto zatrzymanie serwera Minecraft."

            $SCREEN_PATH -rd minecraft -X stuff "stop^M"\\15

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

            $SCREEN_PATH -rd minecraft -X stuff "reload^M"

        echo "Zakończono przeładowanie serwera (reload)."
        log "Zakończono przeładowanie serwera (reload)."
}

# Funkcja do połączenia się z konsolą serwera Minecraft
connect_server() {
        echo "Połączono do konsoli."
        log "Połączono do konsoli."

            $SCREEN_PATH -rd minecraft 
            
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
