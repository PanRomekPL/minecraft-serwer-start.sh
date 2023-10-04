
#███████ ██    ██ ███████ ████████ ███████ ███    ███     ██     ███████ ██   ██ ██████  ██    ██ ██████  ████████ 
#██       ██  ██  ██         ██    ██      ████  ████     ██     ██      ██  ██  ██   ██  ██  ██  ██   ██    ██    
#███████   ████   ███████    ██    █████   ██ ████ ██     ██     ███████ █████   ██████    ████   ██████     ██    
#     ██    ██         ██    ██    ██      ██  ██  ██     ██          ██ ██  ██  ██   ██    ██    ██         ██    
#███████    ██    ███████    ██    ███████ ██      ██     ██     ███████ ██   ██ ██   ██    ██    ██         ██    


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source version.txt
#-----------------------------------------------------
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
                        cp -r $SERVER_DIR/*.sh $SERVER_DIR/script_backup_$DATE2/
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
