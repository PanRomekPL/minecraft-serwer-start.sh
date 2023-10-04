

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