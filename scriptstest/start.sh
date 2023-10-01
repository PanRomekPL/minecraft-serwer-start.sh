#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source Colors.sh
source Date.sh
source Colors.sh
source Date.sh
source test.sh
source Check_and_log.sh
source Backup.sh
source SystemCTL.sh
source Basic_and_advanced_features.sh
source System_and_script.sh
source config.sh


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#romek@DESKTOP-ROMEK:~/mc$ command -v tree 
#/usr/bin/tree

# Lokalizacja Javy (sprawdź poprawną ścieżkę do interpretera Java na swoim systemie)
JAVA_PATH="/usr/bin/java"
# Lokalizacja screena (sprawdź poprawną ścieżkę do interpretera Screen na swoim systemie)
SCREEN_PATH="/usr/bin/screen"
# Lokalizacja sleepa (sprawdź poprawną ścieżkę do interpretera Sleep na swoim systemie)
SLEEP_PATH="/usr/bin/sleep"
# Lokalizacja Treey (sprawdź poprawną ścieżkę do interpretera Tree na swoim systemie)
TREE_PATH="/usr/bin/tree"
# Lokalizacja Sudo (sprawdź poprawną ścieżkę do interpretera sudo na swoim systemie)
SUDO_PATH="/usr/bin/sudo"
# Lokalizacja Wget (sprawdź poprawną ścieżkę do interpretera wugeta na swoim systemie)
WGET_PATH="/usr/bin/wget"
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
            
        SystemD
            ${Yellow}start_default${NC} - 

            "
        exit 1
        ;;

esac
exit 0
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
