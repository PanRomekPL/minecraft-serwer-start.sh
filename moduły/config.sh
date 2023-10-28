#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Automatyczna aktualizacja skryptu startowego serwera Minecraft
AUTO_UPDATE=true    #true lub false

#Nazwa sesji screen 
SCREEN_SESSION_NAME="minecraft"

# Ustawienia dla search_files/#search_for_files
source moduły/colors.sh
FORMATS=("jar" "txt" "cfg")
FORMAT_COLORS=("${LightRed}" "${Green}" "${Yellow}") # Kolory ANSI dla każdego formatu można to skopiować z pliku moduły/colors.sh
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Wymagane
    # Katalog zawierający pliki serwera Minecraft
SERVER_DIR="/mnt/d/Pliki/Nextcloud/GitHub/minecraft"
    # Ścieżka do pliku serwera Minecraft
SERVER_JAR="$SERVER_DIR/paper-1.20.1-172.jar"

#Opcjonalne
    # Katalog dla kopii zapasowych dzienników zdarzeń serwera [logi]
LOGS_DIR="/home/romek/kopia/log"
    # Katalog dla kopii zapasowych
BACKUP_DIR="/home/romek/kopia/"

#Zalecane
    # Logi dziennika działań pliku startowego
LOG_FILE="$SERVER_DIR/logs/minecraft_script/minecraft_script_log_$DATE2.log"
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Minimalne parametry
#JVM_OPTIONS="-Xmx$MAX_MEMORY -Xms$MIN_MEMORY"  

# Ustawienia garbage collectora G1 (opcje optymalne dla nowszych wersji Javy) - ponizej 12GB Ramu --- źródło https://flags.sh/
JVM_OPTIONS="-server -Xmx$MAX_MEMORY -Xms$MIN_MEMORY --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20"

# Ustawienia garbage collectora G1 (opcje optymalne dla nowszych wersji Javy) - powyzej 12GB Ramu --- źródło https://flags.sh/
#JVM_OPTIONS="-server -Xmx$MAX_MEMORY -Xms$MIN_MEMORY --add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15"

# 
#JVM_OPTIONS="" 
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

