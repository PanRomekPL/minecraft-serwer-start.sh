
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Automatyczna aktualizacja skryptu startowego serwera Minecraft
AUTO_UPDATE=true
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Maksymalny rozmiar pamięci dla serwera (dostosuj do dostępnej pamięci na serwerze)
    #Wersja GB
MAX_MEMORY="6G"
    #Wersja MB
#MAX_MEMORY="1024M"

# Minimalny rozmiar pamięci dla serwera (zalecane około 1/2 wartości MAX_MEMORY)
    #Wersja GB
MIN_MEMORY="3G"
    #Wersja MB
#MIN_MEMORY="1024M"
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ścieżka do pliku serwera Minecraft
SERVER_JAR="spigot.jar"

# Katalog zawierający pliki serwera Minecraft
SERVER_DIR="/home/romek/mc"

# Katalog dla kopii zapasowych dzienników zdarzeń serwera [logi]
LOGS_DIR="/home/romek/kopia/log"

# Katalog dla kopii zapasowych
BACKUP_DIR="/home/romek/kopia/"

# Logi dziennika działań pliku startowego
LOG_FILE="$SERVER_DIR/logs/minecraft_script/minecraft_script_log_$DATE2.log"
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Ustawienia garbage collectora G1 (opcje optymalne dla nowszych wersji Javy) - ponizej 12GB Ramu 
JVM_OPTIONS="-server -Xmx$MAX_MEMORY -Xms$MIN_MEMORY --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20"

# Ustawienia garbage collectora G1 (opcje optymalne dla nowszych wersji Javy) - powyzej 12GB Ramu 
#JVM_OPTIONS="-server -Xmx$MAX_MEMORY -Xms$MIN_MEMORY --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15"
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
