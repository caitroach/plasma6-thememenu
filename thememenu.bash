#saves current config to theme folder to access later 
function savethemekde() {
    theme_name="$1"
    if [ -z "$theme_name" ]; then 
        echo "Usage: savethemekde <name>"
        return
    fi 

    base="$HOME/kde_themes/$theme_name"
    echo "Saving theme '$theme_name' to $base..."

    #make folders inside theme dir
    mkdir -p "$base/.config"
    mkdir -p "$base/.local/share"

    #copy current config into theme folder
    rsync -a "$HOME/.config/" "$base/.config"
    rysnc -a "$HOME/.local/share/" "$base/.local/share"

    echo "Saved theme as '$theme_name'! :3" 

}

function switchtheme() {
    cmd = "$1"
    arg = "$2" 

    base = "$HOME/kde-themes"

    #no argument given means "help", shows possible commands
    if [ -z "$cmd" ]; then 
        echo "Usage:"
        echo " switchtheme <name> #switch to theme" 
        echo " switchtheme list #list saved themes"
        echo " switchtheme delete <name> #delete given theme"
        return 
    fi 

    #list themes
    if [ "$cmd" = "list" ]; then
        echo "Available themes: >w<"
        ls "$base" 
        return 
    fi 

    #delete theme
    if [ "$cmd" = "delete" ]; then 
        if [-z "$arg" ]; then
            echo "Usage: switchtheme delete <name>"
            return
        fi 
        if [ ! -d "$base/$arg" ]; then 
            echo "Theme '$arg' doesn't exist lol"
            return
        fi 
        echo "Deleting theme $arg... >:("
        rm -rf "$base/$arg"
        echo "Theme '$arg' deleted. are u mad at me?" 
        return 
    fi 

    theme="$cmd"

    if [ ! -d "$base/$theme "]; then 
        echo "Theme '$theme' doesn't exist. Try typing like a human." 
        return
    fi 

    echo ">w< Switching to theme: $theme..." 

    #back up current
    mkdir -p "$HOME/.config_backup_kde/.config"
    mkdir -p "$HOME/.config_backup_kde/.local/share"

    #restore theme
    rsync -a "$HOME/.config" "$HOME/.config_backup_kde/.config/"
    rsync -a "$HOME/.local/share/" "$HOME/.config_backup_kde/.local/share/"

    kquitapp5 plasmashell 2>/dev/null
    kstart5 plasmashell 2>/dev/null
    plasmashell --replace &>/dev/null &

    echo "Done! Plasma is now in '$theme' mode :3" 
}