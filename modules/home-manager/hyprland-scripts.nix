{ pkgs, ... }:
{
  home.packages = with pkgs; [

    (pkgs.writeShellScriptBin "dontkillsteam.sh"
      ''
    if [[ $(hyprctl activewindow -j | jq -r ".class") == "Steam" ]]; then
        xdotool windowunmap $(xdotool getactivewindow)
    else
        hyprctl dispatch killactive ""
    fi
  '')

    (pkgs.writeShellScriptBin "sysmonlaunch.sh"
      ''
  #!/usr/bin/env sh

    # Define the list of commands to check in order of preference
    commands_to_check=("htop" "btop" "top")

    # Determine the terminal emulator to use
    term=$(cat $HOME/.config/hypr/keybindings.conf | grep ^'$term' | cut -d '=' -f2)

    # Try to execute the first available command in the specified terminal emulator
    for command in "''${commands_to_check[@]}"; do
        if command -v "$command" &> /dev/null; then
            $term -e "$command"
            break  # Exit the loop if the command executed successfully
        fi
    done
  '')

    (pkgs.writeShellScriptBin "rofilaunch.sh"
      ''
    #!/usr/bin/env sh

    ScrDir=`dirname "$(realpath "$0")"`
    source $ScrDir/globalcontrol.sh
    roconf="$HOME/.config/rofi/config.rasi"


    # rofi action

    case $1 in
        d)  r_mode="drun" ;;
        w)  r_mode="window" ;;
        f)  r_mode="filebrowser" ;;
        h)  echo -e "rofilaunch.sh [action]\nwhere action,"
            echo "d :  drun mode"
            echo "w :  window mode"
            echo "f :  filebrowser mode,"
            exit 0 ;;
        *)  r_mode="drun" ;;
    esac


    # read hypr theme border

    wind_border=$(( hypr_border * 3 ))
    elem_border=`[ $hypr_border -eq 0 ] && echo "10" || echo $(( hypr_border * 2 ))`
    r_override="window {border: ''${hypr_width}px; border-radius: ''${wind_border}px;} element {border-radius: ''${elem_border}px;}"


    # read hypr font size

    fnt_override=`gsettings get org.gnome.desktop.interface font-name | awk '{gsub(/'\''''''/,""); print $NF}'`
    fnt_override="configuration {font: \"JetBrainsMono Nerd Font ''${fnt_override}\";}"


    # read hypr theme icon

    icon_override=`gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g"`
    icon_override="configuration {icon-theme: \"''${icon_override}\";}"


    # launch rofi

    rofi -show $r_mode -theme-str "''${fnt_override}" -theme-str "''${r_override}" -theme-str "''${icon_override}" -config "''${roconf}"
    '')

    (pkgs.writeShellScriptBin "volumecontrol.sh"
      ''
    #!/usr/bin/env sh

    ScrDir=$(dirname "$(realpath "$0")")
    source "$ScrDir/globalcontrol.sh"


    # define functions
    print_error()
    {
    cat << "EOF"
        ./volumecontrol.sh -[device] <action>
        ...valid device are...
            i -- [i]nput decive
            o -- [o]utput device
        ...valid actions are...
            i -- <i>ncrease volume [+5]
            d -- <d>ecrease volume [-5]
            m -- <m>ute [x]
    EOF
    }

    notify_vol()
    {
        vol=$(pamixer $srce --get-volume | cat)
        angle="$(( (($vol+2)/5) * 5 ))"
        ico="''${icodir}/vol-''${angle}.svg"
        bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
        notify-send "$vol$bar" "$nsink" -i $ico -r 91190 -t 800
    }

    notify_mute()
    {
        mute=$(pamixer $srce --get-mute | cat)
        if [ "$mute" == "true" ] ; then
            notify-send "muted" "$nsink" -i ''${icodir}/muted-''${dvce}.svg -r 91190 -t 800
        else
            notify-send "unmuted" "$nsink" -i ''${icodir}/unmuted-''${dvce}.svg -r 91190 -t 800
        fi
    }


    # set device source

    while getopts io SetSrc
    do
        case $SetSrc in
        i) nsink=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
            srce="--default-source"
            dvce="mic" ;;
        o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
            srce=""
            dvce="speaker" ;;
        esac
    done

    if [ $OPTIND -eq 1 ] ; then
        print_error
    fi


    # set device action

    shift $((OPTIND -1))
    step="''${2:-5}"
    icodir="$HOME/.config/dunst/icons/vol"

    case $1 in
        i) pamixer $srce -i ''${step}
            notify_vol ;;
        d) pamixer $srce -d ''${step}
            notify_vol ;;
        m) pamixer $srce -t
            notify_mute ;;
        *) print_error ;;
    esac
    '')

    (pkgs.writeShellScriptBin "brightnesscontrol.sh"
      ''
    #!/usr/bin/env sh

    ScrDir=`dirname "$(realpath "$0")"`
    source $ScrDir/globalcontrol.sh

    print_error()
    {
    cat << "EOF"
        ./brightnesscontrol.sh <action>
        ...valid actions are...
            i -- <i>ncrease brightness [+5%]
            d -- <d>ecrease brightness [-5%]
    EOF
    }

    send_notification()
    {
        brightness=`brightnessctl info | grep -oP "(?<=\()\d+(?=%)" | cat`
        brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')
        angle="$(((($brightness + 2) / 5) * 5))"
        ico="$HOME/.config/dunst/icons/vol/vol-''${angle}.svg"
        bar=$(seq -s "." $(($brightness / 15)) | sed 's/[0-9]//g')
        notify-send -i $ico -a "$brightness$bar" "$brightinfo" -r 91190 -t 800
        }

    get_brightness()
    {
        brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
    }

    case $1 in
    i)  # increase the backlight by 5%
        brightnessctl set +5%
        send_notification ;;
    d)  # decrease the backlight by 5%
        if [[ $(get_brightness) -lt 5 ]] ; then
            # avoid 0% brightness
            brightnessctl set 1%
        else
            # decrease the backlight by 5%
            brightnessctl set 5%-
        fi
        send_notification ;;
    *)  # print error
        print_error ;;
    esac
    '')

    (pkgs.writeShellScriptBin "screenshot.sh"
      ''
#!/usr/bin/env sh

if [ -z "$XDG_PICTURES_DIR" ] ; then
    XDG_PICTURES_DIR="$HOME/Pictures"
fi

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
swpy_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/swappy"
save_dir="''${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir
mkdir -p $swpy_dir
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" > $swpy_dir/config

function print_error
{
cat << "EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p : print all screens
        s : snip current screen
        sf : snip current screen (frozen)
        m : print focused monitor
EOF
}

case $1 in
p)  # print all outputs
    grimblast copysave screen $temp_screenshot && swappy -f $temp_screenshot ;;
s)  # drag to manually snip an area / click on a window to print it
    grimblast copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
sf)  # frozen screen, drag to manually snip an area / click on a window to print it
    grimblast --freeze copysave area $temp_screenshot && swappy -f $temp_screenshot ;;
m)  # print focused monitor
    grimblast copysave output $temp_screenshot && swappy -f $temp_screenshot ;;
*)  # invalid option
    print_error ;;
esac

rm "$temp_screenshot"

if [ -f "$save_dir/$save_file" ] ; then
    notify-send -a "saved in $save_dir" -i "$save_dir/$save_file" -r 91190 -t 2200
fi
'')

    (pkgs.writeShellScriptBin "gamemode.sh"
      ''
#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | sed -n '2p' | awk '{print $2}')
if [ $HYPRGAMEMODE = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
    exit
fi
hyprctl reload
'')

    (pkgs.writeShellScriptBin "swwwallpaper.sh"
      ''
#!/usr/bin/env sh

# define functions

Wall_Update()
{
    if [ ! -d "''${cacheDir}/''${curTheme}" ] ; then
        mkdir -p "''${cacheDir}/''${curTheme}"
    fi

    local x_wall="$1"
    local x_update="''${x_wall/$HOME/"~"}"
    cacheImg=$(basename "$x_wall")
    $ScrDir/swwwallbash.sh "$x_wall" &

    if [ ! -f "''${cacheDir}/''${curTheme}/''${cacheImg}" ] ; then
        convert -strip "$x_wall" -thumbnail 500x500^ -gravity center -extent 500x500 "''${cacheDir}/''${curTheme}/''${cacheImg}" &
    fi

    if [ ! -f "''${cacheDir}/''${curTheme}/''${cacheImg}.rofi" ] ; then
        convert -strip -resize 2000 -gravity center -extent 2000 -quality 90 "$x_wall" "''${cacheDir}/''${curTheme}/''${cacheImg}.rofi" &
    fi

    if [ ! -f "''${cacheDir}/''${curTheme}/''${cacheImg}.blur" ] ; then
        convert -strip -scale 10% -blur 0x3 -resize 100% "$x_wall" "''${cacheDir}/''${curTheme}/''${cacheImg}.blur" &
    fi

    wait
    awk -F '|' -v thm="''${curTheme}" -v wal="''${x_update}" '{OFS=FS} {if($2==thm)$NF=wal;print$0}' "''${ThemeCtl}" > "''${ScrDir}/tmp" && mv "''${ScrDir}/tmp" "''${ThemeCtl}"
    ln -fs "''${x_wall}" "''${wallSet}"
    ln -fs "''${cacheDir}/''${curTheme}/''${cacheImg}.rofi" "''${wallRfi}"
    ln -fs "''${cacheDir}/''${curTheme}/''${cacheImg}.blur" "''${wallBlr}"
}

Wall_Change()
{
    local x_switch=$1

    for (( i=0 ; i<''${#Wallist[@]} ; i++ ))
    do
        if [ "''${Wallist[i]}" == "''${fullPath}" ] ; then

            if [ $x_switch == 'n' ] ; then
                nextIndex=$(( (i + 1) % ''${#Wallist[@]} ))
            elif [ $x_switch == 'p' ] ; then
                nextIndex=$(( i - 1 ))
            fi

            Wall_Update "''${Wallist[nextIndex]}"
            break
        fi
    done
                }

Wall_Set()
{
    if [ -z $xtrans ] ; then
        xtrans="grow"
    fi

    swww img "$wallSet" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type "$xtrans" \
    --transition-duration 0.7 \
    --transition-fps 60 \
    --invert-y \
    --transition-pos "$( hyprctl cursorpos )"
}


# set variables

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
wallSet="''${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.set"
wallBlr="''${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.blur"
wallRfi="''${XDG_CONFIG_HOME:-$HOME/.config}/swww/wall.rofi"
ctlLine=$(grep '^1|' ''${ThemeCtl})

if [ `echo $ctlLine | wc -l` -ne "1" ] ; then
    echo "ERROR : ''${ThemeCtl} Unable to fetch theme..."
    exit 1
fi

curTheme=$(echo "$ctlLine" | awk -F '|' '{print $2}')
fullPath=$(echo "$ctlLine" | awk -F '|' '{print $NF}' | sed "s+~+$HOME+")
wallName=$(basename "$fullPath")
wallPath=$(dirname "$fullPath")
mapfile -d \'\' Wallist < <(find ''${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)

if [ ! -f "$fullPath" ] ; then
    if [ -d "''${XDG_CONFIG_HOME:-$HOME/.config}/swww/$curTheme" ] ; then
        wallPath="''${XDG_CONFIG_HOME:-$HOME/.config}/swww/$curTheme"
        mapfile -d \'\' Wallist < <(find ''${wallPath} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z)
        fullPath="''${Wallist[0]}"
    else
        echo "ERROR: wallpaper $fullPath not found..."
        exit 1
    fi
fi


# evaluate options

while getopts "nps" option ; do
    case $option in
    n ) # set next wallpaper
        xtrans="grow"
        Wall_Change n ;;
    p ) # set previous wallpaper
        xtrans="outer"
        Wall_Change p ;;
    s ) # set input wallpaper
        shift $((OPTIND -1))
        if [ -f "$1" ] ; then
            Wall_Update "$1"
        fi ;;
    * ) # invalid option
        echo "n : set next wall"
        echo "p : set previous wall"
        echo "s : set input wallpaper"
        exit 1 ;;
    esac
done


# check swww daemon and set wall

swww query
if [ $? -eq 1 ] ; then
    swww init
fi

Wall_Set
    '')

    (pkgs.writeShellScriptBin "wbarconfgen.sh"
      ''
#!/usr/bin/env sh


# read control file and initialize variables

ScrDir=`dirname "$(realpath "$0")"`
waybar_dir="''${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
modules_dir="$waybar_dir/modules"
conf_file="$waybar_dir/config.jsonc"
conf_ctl="$waybar_dir/config.ctl"

readarray -t read_ctl < $conf_ctl
num_files="''${#read_ctl[@]}"
switch=0


# update control file to set next/prev mode

if [ $num_files -gt 1 ]
then
    for (( i=0 ; i<$num_files ; i++ ))
    do
        flag=`echo "''${read_ctl[i]}" | cut -d '|' -f 1`
        if [ $flag -eq 1 ] && [ "$1" == "n" ] ; then
            nextIndex=$(( (i + 1) % $num_files ))
            switch=1
            break;

        elif [ $flag -eq 1 ] && [ "$1" == "p" ] ; then
            nextIndex=$(( i - 1 ))
            switch=1
            break;
        fi
    done
fi

if [ $switch -eq 1 ] ; then
    update_ctl="''${read_ctl[nextIndex]}"
    export reload_flag=1
    sed -i "s/^1/0/g" $conf_ctl
    awk -F '|' -v cmp="$update_ctl" '{OFS=FS} {if($0==cmp) $1=1; print$0}' $conf_ctl > $waybar_dir/tmp && mv $waybar_dir/tmp $conf_ctl
fi


# overwrite config from header module

export set_sysname=`hostnamectl hostname`
export w_position=`grep '^1|' $conf_ctl | cut -d '|' -f 3`

export w_height=`grep '^1|' $conf_ctl | cut -d '|' -f 2`
if [ -z $w_height ] ; then
    y_monres=`cat /sys/class/drm/*/modes | head -1 | cut -d 'x' -f 2`
    export w_height=$(( y_monres*2/100 ))
fi

export i_size=$(( w_height*6/10 ))
if [ $i_size -lt 12 ] ; then
    export i_size="12"
fi

export i_theme=`gsettings get org.gnome.desktop.interface icon-theme | sed "s/'//g"`
export i_task=$(( w_height*6/10 ))
if [ $i_task -lt 16 ] ; then
    export i_task="16"
fi

envsubst < $modules_dir/header.jsonc > $conf_file


# module generator function

gen_mod()
{
    local pos=$1
    local col=$2
    local mod=""

    mod=`grep '^1|' $conf_ctl | cut -d '|' -f ''${col}`
    mod="''${mod//(/"custom/l_end"}"
    mod="''${mod//)/"custom/r_end"}"
    mod="''${mod//[/"custom/sl_end"}"
    mod="''${mod//]/"custom/sr_end"}"
    mod="''${mod//\{/"custom/rl_end"}"
    mod="''${mod//\}/"custom/rr_end"}"
    mod="''${mod// /"\",\""}"

    echo -e "\t\"modules-''${pos}\": [\"custom/padd\",\"''${mod}\",\"custom/padd\"]," >> $conf_file
    write_mod=`echo $write_mod $mod`
}


# write positions for modules

echo -e "\n\n// positions generated based on config.ctl //\n" >> $conf_file
gen_mod left 4
gen_mod center 5
gen_mod right 6


# copy modules/*.jsonc to the config

echo -e "\n\n// sourced from modules based on config.ctl //\n" >> $conf_file
echo "$write_mod" | sed 's/","/\n/g ; s/ /\n/g' | awk -F '/' '{print $NF}' | awk -F '#' '{print $1}' | awk '!x[$0]++' | while read mod_cpy
do

#    case ''${w_position}-$(grep -E '"modules-left":|"modules-center":|"modules-right":' $conf_file | grep "$mod_cpy" | tail -1 | cut -d '"' -f 2 | cut -d '-' -f 2) in
#        top-left) export mod_pos=1;;
#        top-right) export mod_pos=2;;
#        bottom-right) export mod_pos=3;;
#        bottom-left) export mod_pos=4;;
#    esac

    if [ -f $modules_dir/$mod_cpy.jsonc ] ; then
        envsubst < $modules_dir/$mod_cpy.jsonc >> $conf_file
    fi
done

cat $modules_dir/footer.jsonc >> $conf_file


# generate style and restart waybar

$ScrDir/wbarstylegen.sh
    '')

    (pkgs.writeShellScriptBin "wallbashtoggle.sh"
      ''
#!/usr/bin/env sh

# set variables
ScrDir=`dirname "$(realpath "$0")"`
DcoDir="''${XDG_CONFIG_HOME:-$HOME/.config}/hypr/wallbash"
TgtScr=$ScrDir/globalcontrol.sh
source $ScrDir/globalcontrol.sh

# switch WallDcol variable
if [ $EnableWallDcol -eq 1 ] ; then
    sed -i "/^EnableWallDcol/c\EnableWallDcol=0" $TgtScr
    notif=" Wallbash disabled..."
else
    sed -i "/^EnableWallDcol/c\EnableWallDcol=1" $TgtScr
    notif=" Wallbash enabled..."
fi

# reset the colors
grep -m 1 '.' $DcoDir/*.dcol | awk -F '|' '{print $2}' | while read wallbash
do
    if [ ! -z "$wallbash" ] ; then
        eval "''${wallbash}"
    fi
done

notify-send  -a "$notif" -i "$HOME/.config/dunst/icons/hyprdots.png" -r 91190 -t 2200
    '')

    (pkgs.writeShellScriptBin "themeselect.sh"
      ''
#!/usr/bin/env sh

# set variables
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
RofiConf="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themeselect.rasi"


# scale for monitor x res
x_monres=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
x_monres=$(( x_monres * 17 / monitor_scale ))


# set rofi override
elem_border=$(( hypr_border * 5 ))
icon_border=$(( elem_border - 5 ))
r_override="element{border-radius:''${elem_border}px;} element-icon{border-radius:''${icon_border}px;size:''${x_monres}px;}"


# launch rofi menu
ThemeSel=$( cat "$ThemeCtl" | while read line
do
    thm=`echo $line | cut -d '|' -f 2`
    wal=`echo $line | awk -F '/' '{print $NF}'`
    echo -en "$thm\x00icon\x1f$cacheDir/''${thm}/''${wal}\n"
done | rofi -dmenu -theme-str "''${r_override}" -config $RofiConf -select "''${gtkTheme}")


# apply theme
if [ ! -z $ThemeSel ] ; then
    "''${ScrDir}/themeswitch.sh" -s $ThemeSel
    notify-send  -a " ''${ThemeSel}" -i "$HOME/.config/dunst/icons/hyprdots.png" -r 91190 -t 2200
fi
    '')

    (pkgs.writeShellScriptBin "rofiselect.sh"
      ''
#!/usr/bin/env sh

# set variables
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
RofiConf="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themeselect.rasi"
RofiStyle="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/styles"
RofiAssets="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/assets"
Rofilaunch="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/config.rasi"


# scale for monitor x res
x_monres=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
x_monres=$(( x_monres * 18 / monitor_scale ))


# set rofi override
elem_border=$(( hypr_border * 5 ))
icon_border=$(( elem_border - 5 ))
r_override="listview{columns:4;} element{orientation:vertical;border-radius:''${elem_border}px;} element-icon{border-radius:''${icon_border}px;size:''${x_monres}px;} element-text{enabled:false;}"


# launch rofi menu
RofiSel=$( ls ''${RofiStyle}/style_*.rasi | awk -F '/' '{print $NF}' | cut -d '.' -f 1 | while read rstyle
do
    echo -en "$rstyle\x00icon\x1f''${RofiAssets}/''${rstyle}.png\n"
done | rofi -dmenu -theme-str "''${r_override}" -config $RofiConf)


# apply rofi style
if [ ! -z $RofiSel ] ; then
    cp "''${RofiStyle}/''${RofiSel}.rasi" "''${Rofilaunch}"
    notify-send  -a " ''${RofiSel} applied..." -i "$RofiAssets/$RofiSel.png" -r 91190 -t 2200
fi
    '')

    (pkgs.writeShellScriptBin "swwwallselect.sh"
      ''
#!/usr/bin/env sh

# set variables
ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
RofiConf="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themeselect.rasi"

ctlLine=`grep '^1|' "$ThemeCtl"`
if [ `echo $ctlLine | wc -l` -ne "1" ] ; then
    echo "ERROR : $ThemeCtl Unable to fetch theme..."
    exit 1
fi

fullPath=$(echo "$ctlLine" | awk -F '|' '{print $NF}' | sed "s+~+$HOME+")
wallPath=$(dirname "$fullPath")
if [ ! -d "''${wallPath}" ] && [ -d "''${XDG_CONFIG_HOME:-$HOME/.config}/swww/''${gtkTheme}" ] && [ ! -z "''${gtkTheme}" ] ; then
    wallPath="''${XDG_CONFIG_HOME:-$HOME/.config}/swww/''${gtkTheme}"
fi


# scale for monitor x res
x_monres=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
x_monres=$(( x_monres * 17 / monitor_scale ))


# set rofi override
elem_border=$(( hypr_border * 3 ))
r_override="element{border-radius:''${elem_border}px;} listview{columns:6;spacing:100px;} element{padding:0px;orientation:vertical;} element-icon{size:''${x_monres}px;border-radius:0px;} element-text{padding:20px;}"


# launch rofi menu
currentWall=`basename $fullPath`
RofiSel=$( find "''${wallPath}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort | while read rfile
do
    echo -en "$rfile\x00icon\x1f''${cacheDir}/''${gtkTheme}/''${rfile}\n"
done | rofi -dmenu -theme-str "''${r_override}" -config "''${RofiConf}" -select "''${currentWall}")


# apply wallpaper
if [ ! -z "''${RofiSel}" ] ; then
    "''${ScrDir}/swwwallpaper.sh" -s "''${wallPath}/''${RofiSel}"
    notify-send  -a " ''${RofiSel}" -i "''${cacheDir}/''${gtkTheme}/''${RofiSel}" -r 91190 -t 2200
fi
    '')

    (pkgs.writeShellScriptBin "cliphist.sh"
      ''
#!/usr/bin/env sh

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
roconf="$HOME/.config/rofi/clipboard.rasi"


# set position
x_offset=-15   #* Cursor spawn position on clipboard
y_offset=210   #* To point the Cursor to the 1st and 2nd latest word
#!base on $HOME/.config/rofi/clipboard.rasi
clip_h=$(cat "''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/clipboard.rasi" | awk '/window {/,/}/'  | awk '/height:/ {print $2}' | awk -F "%" '{print $1}')
clip_w=$(cat "''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/clipboard.rasi" | awk '/window {/,/}/'  | awk '/width:/ {print $2}' | awk -F "%" '{print $1}')
#clip_h=55 #! Modify limits for size of the Clipboard
#clip_w=20 #! This values are transformed per cent(100)
#? Monitor resolution , scale and rotation
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
#? Rotated monitor?
monitor_rot=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .transform')
if [ "$monitor_rot" == "1" ] || [ "$monitor_rot" == "3" ]; then  # if rotated 270 deg
 tempmon=$x_mon
    x_mon=$y_mon
    y_mon=$tempmon
#! For rotated monitors
fi
#? Scaled monitor Size
monitor_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
x_mon=$((x_mon * 100 / monitor_scale ))
y_mon=$((y_mon * 100 / monitor_scale))
#? monitor position
x_pos=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .x')
y_pos=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .y')
#? cursor position
x_cur=$(hyprctl -j cursorpos | jq '.x')
y_cur=$(hyprctl -j cursorpos | jq '.y')
# Ignore position
 x_cur=$(( x_cur - x_pos))
 y_cur=$(( y_cur - y_pos))
#Limiting
# Multiply before dividing to avoid losing precision due to integer division
clip_w=$(( x_mon*clip_w/100 ))
clip_h=$(( y_mon*clip_h/100 ))
max_x=$((x_mon - clip_w - 5 )) #offset of 5 for gaps
max_y=$((y_mon - clip_h - 15 )) #offset of 15 for gaps
x_cur=$((x_cur - x_offset))
y_cur=$((y_cur - y_offset))
#
x_cur=$(( x_cur < min_x ? min_x : ( x_cur > max_x ? max_x :  x_cur)))
y_cur=$(( y_cur < min_y ? min_y : ( y_cur > max_y ? max_y :  y_cur)))

pos="window {location: north west; x-offset: ''${x_cur}px; y-offset: ''${y_cur}px;}" #! I just Used the old pos function
#pos="window {location: $y_rofi $x_rofi; $x_offset $y_offset}"

# read hypr theme border

wind_border=$(( hypr_border * 3/2 ))
elem_border=`[ $hypr_border -eq 0 ] && echo "5" || echo $hypr_border`
r_override="window {border: ''${hypr_width}px; border-radius: ''${wind_border}px;} entry {border-radius: ''${elem_border}px;} element {border-radius: ''${elem_border}px;}"


# read hypr font size

fnt_override=`gsettings get org.gnome.desktop.interface monospace-font-name | awk '{gsub(/'\'\'\'/,""); print $NF}'`
fnt_override="configuration {font: \"JetBrainsMono Nerd Font ''${fnt_override}\";}"


# clipboard action

case $1 in
    c)  cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Copy...\";} ''${pos} ''${r_override}" -theme-str "''${fnt_override}" -config $roconf | cliphist decode | wl-copy
        ;;
    d)  cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Delete...\";} ''${pos} ''${r_override}" -theme-str "''${fnt_override}" -config $roconf | cliphist delete
        ;;
    w)  if [ `echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear Clipboard History?\";} ''${pos} ''${r_override}" -theme-str "''${fnt_override}" -config $roconf` == "Yes" ] ; then
            cliphist wipe
        fi
        ;;
    *)  echo -e "cliphist.sh [action]"
        echo "c :  cliphist list and copy selected"
        echo "d :  cliphist list and delete selected"
        echo "w :  cliphist wipe database"
        exit 1
        ;;
esac
    '')

    (pkgs.writeShellScriptBin "keyboardswitch.sh"
      ''
#!/usr/bin/env sh

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh

hyprctl devices -j | jq -r '.keyboards[].name' | while read keyName
do
    hyprctl switchxkblayout "$keyName" next
done

layMain=$(hyprctl -j devices | jq '.keyboards' | jq '.[] | select (.main == true)' | awk -F '"' '{if ($2=="active_keymap") print $4}')
notify-send "Switch language" -i $HOME/.config/dunst/icons/keyboard.svg -a "$layMain" -r 91190 -t 800
    '')

  ];
}
