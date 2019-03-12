#!/bin/bash
###############################################################################
###############################################################################
####                                                                       ####
#### Copyright (C) 2019  wuseman <wuseman@nr1.nu> - All Rights Reserved    ####
#### Created: 12/12/2018                                                   ####
####                                                                       ####
#### A notice to all nerds.                                                ####
#### If you will copy developers real work it will not make you a hacker.  ####
#### Resepect all developers, we doing this because it's fun!              ####
####                                                                       ####
###############################################################################
###############################################################################
################################ SOURCE CODE ##################################
###############################################################################
###################### EMAGNET WAS FOUNDED BY WUSEMAN #########################
###############################################################################
###############################################################################
####                                                                      #####
#### EMAGNET SOURCE CODE BEGINS HERE FEEL FREE TO USE AND EDIT THE SOURCE #####
####   OF EMAGNET AS YOU WISH ASLONG AS ORIGIN AUTHOR WILL BE MENTIONED   #####
####                                                                      #####
###############################################################################
#################################################################### 2o18 #####
###############################################################################

if [[ $EUID -gt "0" ]]; then printf "Root privileges is required for this tool..\n"; exit 0; fi

cp .emagnetconf/emagnet.conf.bak .emagnetconf/emagnet.conf

CONF=".emagnetconf/emagnet.conf "
SCRIPT="$(pwd)/emagnet"
LYNX="/usr/bin/lynx"
ELINKS="/usr/bin/elinks"
source $CONF
DISTRO=$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }' | cut -d= -f2)


banner() {
cat << "EOF"
     _                      _______                      _
  _dMMMb._              .adOOOOOOOOOba.              _,dMMMb_
 dP'  ~YMMb            dOOOOOOOOOOOOOOOb            aMMP~  `Yb
 V      ~"Mb          dOOOOOOOOOOOOOOOOOb          dM"~      V
          `Mb.       dOOOOOOOOOOOOOOOOOOOb       ,dM'
           `YMb._   |OOOOOOOOOOOOOOOOOOOOO|   _,dMP'
      __     `YMMM| OP'~"YOOOOOOOOOOOP"~`YO |MMMP'     __
    ,dMMMb.     ~~' OO     `YOOOOOP'     OO `~~     ,dMMMb.
 _,dP~  `YMba_      OOb      `OOO'      dOO      _aMMP'  ~Yb._
             `YMMMM\`OOOo     OOO     oOOO'/MMMMP'
     ,aa.     `~YMMb `OOOb._,dOOOb._,dOOO'dMMP~'       ,aa.
   ,dMYYMba._         `OOOOOOOOOOOOOOOOO'          _,adMYYMb.
  ,MP'   `YMMba._      OOOOOOOOOOOOOOOOO       _,adMMP'   `YM.
  MP'        ~YMMMba._ YOOOOPVVVVVYOOOOP  _,adMMMMP~       `YM
  YMb           ~YMMMM\`OOOOI`````IOOOOO'/MMMMP~           dMP
   `Mb.           `YMMMb`OOOI,,,,,IOOOO'dMMMP'           ,dM'
     `'                  `OObNNNNNdOO'                   `'
                           `~OOOOO~'

EOF
}


requirements() {
echo ""
printf "+====================================================================+\n"
printf "#                                                                    #\n"
printf "#     Checking if required packages for emagnet is installed         #\n"
printf "#                                                                    #\n"

DISTRO=$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }' | cut -d= -f2)

if [[ $DISTRO = "ubuntu" ]]; then
NETCAT="/bin/nc"
else
NETCAT="/usr/bin/nc"
fi
LYNX="/usr/bin/lynx"
WGET="/usr/bin/wget"
CURL="/usr/bin/curl"
SCREEN="/usr/bin/screen"
PARALLEL="/usr/bin/parallel"

checkwget() {
echo "+====================================================================+"
if [[ -x  $WGET ]]; then
    echo -e "# Detected wget...................................................[\e[1;32mOK\e[0m]"
else
    echo -e "# Detected wget...............................................[\e[1;31mFAILED\e[0m]" >> packages
    echo -e "# Detected wget...............................................[\e[1;31mFAILED\e[0m]"
fi
}

checkcurl() {
if [[ -x  $CURL ]]; then
    echo -e "# Detected curl...................................................[\e[1;32mOK\e[0m]"
else
    echo -e "# Detected curl...............................................[\e[1;31mFAILED\e[0m]" >> packages
    echo -e "# Detected curl...............................................[\e[1;31mFAILED\e[0m]"
fi
}

checkscreen() {
if [[ -x  $SCREEN ]]; then
    echo -e "# Detected screen.................................................[\e[1;32mOK\e[0m]"
else
    echo -e "# Detected screen.............................................[\e[1;31mFAILED\e[0m]" >> packages
    echo -e "# Detected screen.............................................[\e[1;31mFAILED\e[0m]"
fi
}

checkparallel() {
if [[ -x  $PARALLEL ]]; then
    echo -e "# Detected parallel...............................................[\e[1;32mOK\e[0m]"
else
if [[ $DISTRO = "gentoo" ]]; then
    echo -e "# Detected sys-process/parallel...........................................[\e[1;31mFAILED\e[0m]" >> packages
    echo -e "# Detected parallel...........................................[\e[1;31mFAILED\e[0m]"
else
    echo -e "# Detected parallel...........................................[\e[1;31mFAILED\e[0m]"
    echo -e "# Detected parallel...........................................[\e[1;31mFAILED\e[0m]" >> packages
fi
fi
}

checknetcat() {
if [[ -x  $NETCAT ]]; then
    echo -e "# Detected netcat.................................................[\e[1;32mOK\e[0m]"
    echo -e "+====================================================================+\n"
if [[ ! -f packages ]]; then
echo -e "Looks fine, moving on\n"
idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0
fi

else
    echo -e "# Detected netcat.............................................[\e[1;31mFAILED\e[0m]" >> packages
    echo -e "# Detected netcat.............................................[\e[1;31mFAILED\e[0m]"
echo -e "+====================================================================+\n"

fi
}

checkwget; checkcurl; checkscreen;checkparallel;checknetcat

if [[ -f packages ]]; then
missed="$(cat packages|grep -i failed|awk '{print $3}'|cut -d. -f1|sed 's/ /,/g'|xargs|sed 's/ /, /g')"
missed2="$(cat packages|grep -i failed|awk '{print $3}'|cut -d. -f1)"
rm packages &> /dev/null
printf "$missed is required for emagnet\n"
read -p "Do you want to install the missed packages: (y/n): " missedpackages
echo ""
if [[ ! $missedpackages = "y" ]]; then
  echo -e "\nCan't continue until these packages has been installed, aborted...\n";exit 0
else
case $missedpackages in 
   y) if [[ $DISTRO = "gentoo" ]]; then emerge --ask  $missed2;echo ""
      elif [[ $DISTRO = "sabayon" ]]; then emerge --ask $missed2;echo ""
      elif [[ $DISTRO = "ubuntu" ]]; then apt-get install $missed2 -y; echo ""
      elif [[ $DISTRO = "debian" ]]; then apt-get install $missed2; echo ""
      elif [[ $DISTRO = "mint" ]]; then apt-get install $missed2; echo ""
      else
      echo "Emagnet is not supported for $DISTRO, please install $missed manually.";
      exit 0; fi ;;
   N) echo "Can't continue until these packages has been installed, aborted..."; exit 0 ;;
   \?) echo "Please enter a proper answer y=yes N=no" ;;
esac
fi
else
idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0

fi
idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0
}
wip() {
echo "+====================================================================+"
echo "#                                                                    #" 
echo "#  Set your private ip here because we do not want to risk to get a  #"
echo "#     permanent ip ban on pastebin with our real ip of course.       #"
echo "#                                                                    #"
echo "#   You can set something like 127.0.0.1 to trick emagnet for not    #" 
echo "#   being asked for another ip-address then your own..............   #"
echo "#                                                                    #" 
echo "+====================================================================+"

if [[ -f /etc/emagnet.conf ]]; then
printf "emagnet.conf seems already has been configured are you\n"
read -p "really sure you want to overwrite /etc/emagnet.conf (y/n): " yupiamsure
 if [[ $yupiamsure = "n" ]]; then
    printf "\naborted\n\n"
    exit
fi
cp /etc/emagnet.conf /etc/emagnet.conf.bak
rm /etc/emagnet.conf
printf "\nCreated a backup file: /etc/emagnet.conf.bak\n\n"
fi
if [[ -d "/usr/local/bin" ]]; then
cp ./emagnet /usr/local/bin &> /dev/null
fi

myip="$(curl -s https://nr1.nu/i/)"
read -p "Is $myip your private IP-Address (yes/no): " realip
case "$realip" in
  YES)
      sed -i '26d' $CONF
      sed -i '26 i MYIP=' $CONF
      sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConfig file has been updated with your IP set to: $myip\n\n"
      ;;
  y)
      sed -i '26d' $CONF
      sed -i '26 i MYIP=' $CONF 
      sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConfig file has been updated with your IP set to: $myip\n\n"
      ;;
  yes)
      sed -i '26d' $CONF
      sed -i '26 i MYIP=' $CONF 
      sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConfig file has been updated with your IP set to: $myip\n\n"
      ;;

   *) read -p "Enter your current real IP-Adress: " currentip
      sed -i "s/MYIP=/MYIP=$currentip/g" $CONF
      printf "\nConfig file has been updated with your IP set to: $currentip\n\n"
      ;;
esac
}

settime() {
while true; do
echo "+====================================================================+"
echo "#                                                                    #"
echo "#      By updating emagnet in 10 seconds or less you will get       #"
echo "#   banned unless you setup your own script that is able to change   #"
echo "#             your ip after X downloads on pastebin                  #"
echo "#                                                                    #"
echo "#         I HIGHLY RECOMMEND TO SET AN INTERVAL OF ~80s              #"
echo "#          IF YOU WANNA RUN EMAGNET 24/7 THEN SET +120s              #"
echo "#                                                                    #"
echo "+====================================================================+"
read -p "Set time in seconds for how often you want to download
new uploads from pastebin (Default: 10 Seconds): " o

if [[ $o -lt "9" ]]; then
if [[ -z $o ]]; then
#wwww          printf "\nBy updating emagnet in 10s or less you will get ip-banned\nunless you setup your own script that is able to control\nthe refresh time X times before changing IP..\n\n"
read -p "Are you REALLY sure you want to set 10 seconds (YES/no): " rlysure
else
#          printf "\nBy updating emagnet in 10s or less you will get ip-banned\nunless you setup your own script that is able to control\nthe refresh time X times before changing IP..\n\n"
read -p "Are you REALLY sure you want to set $o seconds (YES/no): " rlysure
fi
 case $rlysure in
   YES)
        sed -i '19d' $CONF
        sed -i "19 i TIME=$o" $CONF
        printf "\n\e[1;31mYou has been warned, expect a ban within ~2minutes!\n\e[0m"
        printf "\nConfig file has updated the refresh time to $o seconds\n\n"
#        printf "%70s\n\n" | tr ' ' '='
        printf "Successfully generated /etc/emagnet.conf, have fun!\n\n"
        printf "Execute \e[1;32m./emagnet.sh -f\e[0m to grab some passwords:-)\e[0m\n\n"
        cp .emagnetconf/emagnet.conf  /etc/; break ;;

    *)  printf "\nSet a number between 10 and 3600 is recommended..\n\n"; continue ;;
 esac
fi
    sed -i "19d" $CONF
    sed -i "19i TIME=$o" $CONF
    printf "\nRefresh time has been set to: $o seconds..\n\n"
#    printf "%70s\n\n" | tr ' ' '='
    printf "Successfully created /etc/emagnet.conf\n"
    printf "\nNow you're all set - Have phun - \e[1;37mbash emagnet -e \e[1;32m:-)\e[0m\n\n"
    cp .emagnetconf/emagnet.conf  /etc/
  exit
done
}


wgettimer() {
echo "+====================================================================+"
echo "#                                                                    #"
echo "#  This setting is for you to be able to choose how many threads on  #"
echo "#  your cpu you want to use while you download files from pastebin.  #"
echo "#     This speeds up the download extremely during the download.     #"
echo "#                                                                    #"
echo "+====================================================================+"

read -p "Your current cpu has $(nproc) threads, want me to set $(nproc) threads: (y/N): " threads
if [[ $threads = "y" ]]; then
  sed -i '75d' $CONF
  sed -i "75 i THREADS=" $CONF
  sed -i "s/THREADS=/THREADS=$(nproc)/g" $CONF
  printf "\nConfig file has been updated, cpu threads has been set to use $(nproc) threads\n\n"
else
  read -p "How many threads do you want to use (Eg: 2): " threadstouse
  sed -i '75d' $CONF
  sed -i "75 i THREADS=" $CONF
  sed -i "s/THREADS=/THREADS=$threadstouse/g" $CONF
  printf "\nConfig file has been updated, cpu threads has been set to $threadstouse threads. \n\n"
fi
}



emagnethome() {
echo "+====================================================================+"
echo "#                                                                    #"
echo "#                    Where to store emagnet files                    #"
echo -e "#                 Please do \e[4mnot\e[0m include emagnet path                 #"
echo "#                                                                    #"
echo "#  Ex: If you want to store the files in /tmp/emaget then type /tmp  #"
echo "#                                                                    #"
echo "+====================================================================+"

read -p "Path (Default: /opt/emagnet): " ehomedir
if [[ $ehomedir = "" ]]; then
  mkdir -p "\/opt\/root"
  sed -i '42d' $CONF
  sed -i "42 i EMAGNET=\/opt\/\/emagnet" $CONF
  printf "\nConfig file has been updated, using /opt/emagnet as emagnets homedir. \n\n"
else
  eehomedir="$(echo $ehomedir | sed 's/\/\///g')"
  sed -i '42d' $CONF
  sed -i "42 i EMAGNET=$ehomedir" $CONF
  printf "\nConfig file has been updated, home dir has been set to: $eehomedir/emagnet\n\n"
fi
}



choosebrowser() {
if [[ -f $LYNX && -f $ELINKS ]]; then
  printf  "+====================================================================+\n"
  printf  "#                                                                    #\n"
  printf  "#   Choose wich browser you prefer to use when emagnet will visit    #\n"
  printf  "#   pastebin.com for the latest uploads urls on site. If you don't   #\n"
  printf  "#   know which one you prefer it doesn't matter, just choose one.    #\n"
  printf  "#                                                                    #\n"
  printf  "+====================================================================+\n"
  printf "It seems you have both lynx and elinks2 installed, you must choose one\n"; read -p "Option: (lynx/elinks): " browsertouse
if [[ $browsertouse = "lynx" ]]; then
  sed -i "315d" $SCRIPT
  sed -i '315i lynx -dump \$PASTEBIN | sed "s/com\\\//com\\\/raw\\\//g" | grep -o http.* | sed -n "7,14p" > /tmp/.emagnet' $SCRIPT
  printf "\nConfig file has been updated, lynx will be used for downloading files\n\n"
else
  sed -i "315d" $SCRIPT
  sed -i "315i elinks -dump \$PASTEBIN| sed 's/com\\\//com\\\/raw\\\//g' | grep -o http.* | sed -n '13,20p' > \/tmp\/.emagnet" $SCRIPT
  printf "\nConfig file has been updated, elinks will be used for downloading files\n\n"
fi
elif [[ -f $LYNX && ! -f $ELINKS ]]; then
  sed -i "315d" $SCRIPT
  sed -i '315i lynx -dump \$PASTEBIN | sed "s/com\\\//com\\\/raw\\\//g" | grep -o http.* | sed -n "7,14p" > /tmp/.emagnet' $SCRIPT
elif [[ ! -f $LYNX && -f $ELINKS ]]; then
  sed -i "315d" $SCRIPT
  sed -i "315i elinks -dump \$PASTEBIN| sed 's/com\\\//com\\\/raw\\\//g' | grep -o http.* | sed -n '13,20p' > \/tmp\/.emagnet" $SCRIPT
else
  printf  "+====================================================================+\n"
  printf  "#                                                                    #\n"
  printf  "#  Choose wich browser you prefer to use when emagnet will visit     #\n"
  printf  "#  pastebin.com for the latest uploads urls on site. If you don't    #\n"
  printf  "#  know which one you prefer it doesn't matter, just choose one.     #\n"
  printf  "#                                                                    #\n"
  printf  "+====================================================================+\n"
  printf "Emagnet require lynx or elinks to be installed, you must choose one\n"; read -p "Prefered browser to install: (lynx/elinks): " browsertouse2
 case $browsertouse2 in
   elinks)
      printf "\nGoing to install $browsertouse2, setup will continue when $browsertouse2 has been installed..\n\n"
      if [[ $DISTRO = "gentoo" ]]; then emerge --ask elinks
       requirements;wip;emagnethome;wgettimer;settime; exit 0;fi
      if [[ $DISTRO = "sabayon" ]]; then emerge --ask elinks
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "ubuntu" ]]; then apt-get install elinks -qq -y;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "debian" ]]; then apt-get install elinks -qq -y;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "mint" ]]; then apt-get install elinks;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ -n $DISTRO ]]; then echo "Emagnet is not supported for $DISTRO, please install elinks manually."; exit 0; fi 
      sed -i "315d" $SCRIPT
      sed -i "315i elinks -dump \$PASTEBIN| sed 's/com\\\//com\\\/raw\\\//g' | grep -o http.* | sed -n '13,20p' > \/tmp\/.emagnet" $SCRIPT
       printf "\nConfig file has been updated, elinks will be used when downloading files from pastebin" $SCRIPT ;;
   lynx)
      printf "\nGoing to install $browsertouse2, setup will continue when $browsertouse2 has been installed..\n\n"
      if [[ $DISTRO = "gentoo" ]]; then emerge --ask lynx
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "sabayon" ]]; then emerge --ask lynx; 
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "ubuntu" ]]; then apt-get install lynx -qq -y;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "debian" ]]; then apt-get install lynx -qq -y;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ $DISTRO = "mint" ]]; then apt-get install lynx;
       requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;exit 0;fi
      if [[ -n $DISTRO ]]; then echo "Emagnet is not supported for $DISTRO, please install lynx or elinks manually."; exit 0; fi
       sed -i "315d" $SCRIPT
       sed -i '315i lynx -dump \$PASTEBIN | sed "s/com\\\//com\\\/raw\\\//g" | grep -o http.* | sed -n "7,14p" > /tmp/.emagnet' $SCRIPT
       printf "\nConfig file has been updated, lynx will be used when downloading files from pastebin" $SCRIPT ;;
   N) exit 0 ;;
   \?) echo "Please enter a proper answer y=yes N=no" ;;
 esac
fi
}

######################################################################
#### Check so emagnet's idletime, they remove ban after 20 min....####
######################################################################
idletime() {
  sed -i "81d" $CONF
  sed -i "81i IDLETIME=1200" $CONF
}

clear;banner;choosebrowser;
requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;

