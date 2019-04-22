#!/bin/bash
################################################################################
################################################################################
####                                                                       #####
#### A notice to all nerds.                                                #####
#### If you will copy developers real work it will not make you a hacker.  #####
#### Resepect all developers, we doing this because it's fun!              #####
####                                                                       #####
################################################################################
################################ SOURCE CODE ###################################
################################################################################
###################### EMAGNET WAS FOUNDED BY WUSEMAN ##########################
################################################################################
####                                                                       #####
####   Emagnet - Tool for find leaked databases, email-addresses, passwords#####
####   credit cards, paypal accounts, darknet urls and much much more      #####
####   from uploaded files on pastebin.                                    #####
####                                                                       #####
####  Copyright (C) 2018-2019, wuseman                                     #####
####                                                                       #####
####  This program is free software; you can redistribute it and/or modify #####
####  it under the terms of the GNU General Public License as published by #####
####  the Free Software Foundation; either version 2 of the License, or    #####
####  (at your option) any later version.                                  #####
####                                                                       #####
####  This program is distributed in the hope that it will be useful,      #####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of       #####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #####
####  GNU General Public License for more details.                         #####
####                                                                       #####
####  You must obey the GNU General Public License. If you will modify     #####
####  emagnet file(s), you may extend this exception to your version       #####
####  of the file(s), but you are not obligated to do so.  If you do not   #####
####  wish to do so, delete this exception statement from your version.    #####
####  If you delete this exception statement from all source files in the  #####
####  program, then also delete it here.                                   #####
####                                                                       #####
####  Contact:                                                             #####
####          IRC: Freenode @ wuseman                                      #####
####          Mail: wuseman <wuseman@nr1.nu>                               #####
####                                                                       #####
################################################################################
######## The Nr1 tool for find latest leaked databases online @ 2o18 ###########
################################################################################

if [[ $EUID -gt "0" ]]; then printf "Root privileges is required for this tool..\n"; exit 0; fi
cp .emagnetconf/emagnet.conf.bak .emagnetconf/emagnet.conf
CONF=".emagnetconf/emagnet.conf ";SCRIPT="$(pwd)/emagnet"
LYNX="/usr/bin/lynx";ELINKS="/usr/bin/elinks";source $CONF
DISTRO=$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }' | cut -d= -f2)

cd /var/git/EMAGNET/


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
echo -e "\n\n\033[1mDEPENDENCIES SETUP:\033[0m\n\033[1m----------------------\033[0m"
DISTRO=$(cat /etc/*release | head -n 1 | awk '{ print tolower($1) }' | cut -d= -f2)

# Since ubuntu have named netcat on it's own way
if [[ $DISTRO = "ubuntu" ]]; then
     NETCAT="/bin/netcat";
else
     NETCAT="/usr/bin/nc"
fi

LYNX="/usr/bin/lynx"
WGET="/usr/bin/wget"
CURL="/usr/bin/curl"
SCREEN="/usr/bin/screen"
PARALLEL="/usr/bin/parallel"

checkwget() {
if [[ -x  $WGET ]]; then
    printf "\nDetected WGET"; printf "%46s[\e[1;32mOK\e[0m]\n"|tr ' ' '.'
else
    printf "\nDetected wget %46s[\e[1;32mNO\e[0m]\n"|tr ' ' '.' >> packages
    printf "\nDetected WGET"; printf "%46s[\e[1;31mNO\e[0m]\n"|tr ' ' '.'
fi
}

checkcurl() {
if [[ -x  $CURL ]]; then
    printf "Detected CURL"; printf "%46s[\e[1;32mOK\e[0m]\n"|tr ' ' '.'
else
    printf "Detected curl"; printf "%46s[\e[1;31mNO\e[0m]\n"|tr ' ' '.' >> packages
    printf "Detected CURL"; printf " %46s[\e[1;31mNO\e[0m]\n"|tr ' ' '.'
fi
}

checkscreen() {
if [[ -x  $SCREEN ]]; then
    printf "Detected SCREEN"; printf "%44s[\e[1;32mOK\e[0m]\n"|tr ' ' '.'
else
    printf "Detected screen %44s[\e[1;31mNO\e[0m]\n" |tr ' ' '.' >> packages
    printf "Detected SCREEN"; printf "%44s[\e[1;31mNO\e[0m]\n"|tr ' ' '.'
fi
}

checkparallel() {
if [[ -x  $PARALLEL ]]; then
    printf "Detected PARALLEL"; printf "%42s[\e[1;32mOK\e[0m]\n"|tr ' ' '.'
else
 if [[ $DISTRO = "gentoo" ]]; then
    printf "Detected sys-process/parallel";printf "%48s[\e[1;31mNO\e[0m]\n"|tr ' ' '.' >> packages
 else
    printf "Detected PARALLEL"; printf "%42s[\e[1;31mNO\e[0m]\n"|tr ' ' '.'
    printf "Detected parallel"; printf "%42s[\e[1;31mNO\e[0m]\n"|tr ' ' '.' >> packages
 fi
fi
}

checknetcat() {
if [[ -x  $NETCAT ]]; then
     printf "Detected NETCAT"; printf "%44s[\e[1;32mOK\e[0m]\n"|tr ' ' '.'
 if [[ ! -f packages ]]; then
     printf "\nAll dependencies has been found, moving on\n"
     idletime;idletime;wip;emagnethome;wgettimer;settime
     exit 1
 fi
 else
     printf "Detected NETCAT"; printf "%44s[\e[1;31mNO\e[0m]\n"|tr ' ' '.'
     printf "Detected netcat %44s[\e[1;31mNO\e[0m]\n"|tr ' ' '.' >> packages
fi
}

checkwget; checkcurl; checkscreen;checkparallel;checknetcat

if [[ -f packages ]]; then
missed="$(awk -F. '{print $2}' packages|sed 's/ /,/g'|xargs|sed 's/ /, /g')"
missed2="$(cat packages|awk -F. '{print $2}' packages)"
missed3="$(cat packages|awk -F. '{print $2}' packages|tr ' ' '\n'|wc -l)"
if [[ $missed3 = "2" ]]; then
    missed="$(awk -F. '{print $2}' packages|xargs|sed 's/ /\ \& /g')"
    printf "\nYou must have \e[1;37m$missed\e[0m installed before emagnet can run\n\n"
    printf "Do you want to install the missed packages: (y/n): "; read missedpackages
    echo ""
    rm packages &> /dev/null
else
    printf "\nYou must have \e[1;37m$missed\e[0m installed before emagnet can run\n\n"
    printf "Do you want to install the missed packages: (y/n): ";
    read missedpackages
    echo ""
    rm packages &> /dev/null
fi

if [[ ! $missedpackages = "y" ]]; then
      echo -e "Setup can't continue until these packages has been installed, aborted...\n";exit 0;else
 case $missedpackages in
   y|yes|YES)
        if [[ $DISTRO = "gentoo" ]]; then emerge --ask  $missed2;echo ""
      elif [[ $DISTRO = "sabayon" ]]; then emerge --ask $missed2;echo ""
      elif [[ $DISTRO = "ubuntu" ]]; then apt-get install $missed2 -y; echo ""
      elif [[ $DISTRO = "debian" ]]; then apt-get install $missed2; echo ""
      elif [[ $DISTRO = "mint" ]]; then apt-get install $missed2; echo "";else
        echo "Emagnet is not supported for $DISTRO, please install $missed manually.";exit 0
        fi
        ;;

   "*") echo "Can't continue until these packages has been installed, aborted..."; exit 0 ;;
   \?)  echo "Please enter a proper answer y=yes N=no"
 esac
       fi
else
       idletime;idletime;wip;emagnethome;wgettimer;settime
       exit 0
fi
       idletime;idletime;wip;emagnethome;wgettimer;settime
       exit 0
}

wip() {
echo -e "\n\n\033[1mIP-ADDRESS SETUP:\033[0m\n\033[1m----------------------\033[0m
Set your private ip here if you don't wanna take the risk to get
your 'private' ip number banned on www.pastebin.com for around
a time limit of ~1200-1600 seconds. Remember this will happends if
you will set time limit to 59 seconds or less in next option.

If this is something you don't care about then please just hit
enter and set your ip to 0.0.0.0. If you wont do this and time
has been set to <59s emagnet will warn you about about this every
time you executing emagnet.

This setting exist so all users is aware that pastebin will ban
your ip if you will visit the page too often.
"
if [[ -f /etc/emagnet.conf ]]; then
    printf "It seems emagnet.conf has already been configured are you\n"
    read -p "really sure you want to overwrite /etc/emagnet.conf (y/n): " yupiamsure
 if [[ $yupiamsure = "n" ]]; then
    printf "\naborted\n\n"
    exit
fi
    cp /etc/emagnet.conf /etc/emagnet.conf.bak
    rm /etc/emagnet.conf
    printf "\n\e[1mCreated a backup file for you: /etc/emagnet.conf.bak\n\n\e[0m"
fi

if [[ -d "/usr/local/bin" ]]; then cp ./emagnet /usr/local/bin &> /dev/null;fi

myip="$(curl -s https://nr1.nu/i/)"
printf "Is \e[1;1m$myip\e[0m your private IP-Address (yes/no): "; read realip
case "$realip" in
  YES)
      sed -i '26d' $CONF;sed -i '26 i MYIP=' $CONF;sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConcfig file has been updated, your IP has been set to: \e[1;1m$myip\e[0m\n"
      ;;
  y)
      sed -i '26d' $CONF;sed -i '26 i MYIP=' $CONF;sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConfig file has been updated, your IP has been set to: \e[1;1m$myip\e[0m\n"
      ;;
  yes)
      sed -i '26d' $CONF;sed -i '26 i MYIP=' $CONF;sed -i "s/MYIP=/MYIP=$myip/g" $CONF
      printf "\nConfig file has been updated, your IP has been set to: \e[1;1m$myip\e[0m\n"
      ;;

   *) read -p "Enter your current real IP-Adress: " currentip;sed -i "s/MYIP=/MYIP=$currentip/g" $CONF
      printf "\nConfig file has been updated, your IP has been set to: \e[1;1m$myip\e[0m\n"
      ;;
esac
}

settime() {
while true; do echo -e "\n\n\033[1mTIME SETUP:\033[0m\n\033[1m----------------------\033[0m
By updating emagnet in 59 seconds or less you will get ip banned
by pastebin after ~1200 seconds, if you choose to set emagnet to refresh
in 59 seconds or less anyway then \e[1;1mdo\e[0m not leave emagnet running
in background by quiet mode(option -S) cause this will not result in more
files to be downloaded because you will be banned in 1200 seconds wich means
a loss of 150 uploaded files instead because  1200seconds-3600seconds = ~150 uploads

If you want to run emagnet in background without being banned and
capture files 24/7 then you MUST set emagnet to run every >59 seconds
to stay safe from get a temporary ip ban.

Whatever, no matter what time you will choose to set here emagnet
will take care of the situation. If you will be banned from pastebin
emagnet will sleep for 1200 seconds and then it will startover again.

\e[1;1mIT IS RECOMMENDED TO SET 59 SECONDS OR MORE AT LEAST\e[0m
"
read -p "Set refresh time in seconds for how often emagnet should download new files from pastebin
Time: (Default: 60 Seconds): " o

if [[ $o -lt "59" ]]; then
if [[ -z $o ]]; then
        sed -i '19d' $CONF
        sed -i "19 i TIME=60" $CONF
        printf "\nConfig file has updated the refresh time to 60 seconds\n"
        echo -e "\n\n\033[1mSETUP FINISHED:\033[0m\n\033[1m----------------------\033[0m"
        printf "Successfully generated /etc/emagnet.conf, have fun!\n\n"
        printf "\nNow you're all set - Have phun - \e[1;1m'bash emagnet -e' \e[1;1m:-)\e[0m\n\n"
        cp .emagnetconf/emagnet.conf  /etc/
        exit 1
else
#          printf "\nBy updating emagnet in 59 seconds or less you will get ip-banned\nunless you setup your own script that is able to control\nthe refresh time X times before changing IP..\n\n"
read -p "Are you REALLY sure you want to set $o seconds (YES/no): " rlysure
fi
 case $rlysure in
   YES)
        sed -i '19d' $CONF
        sed -i "19 i TIME=$o" $CONF
        printf "\nConfig file has updated the refresh time to $o seconds\n"
        printf "\n\e[1;31mYou have been warned, expect a ban within ~300 seconds!\n\e[0m"
        echo -e "\n\n\033[1mSETUP FINISHED:\033[0m\n\033[1m----------------------\033[0m"
        printf "Successfully generated /etc/emagnet.conf, have fun!\n\n"
        printf "\nNow you're all set - Have phun - \e[1;1m'bash emagnet -e' \e[1;1m:-)\e[0m\n\n"
        cp .emagnetconf/emagnet.conf  /etc/; break ;;

    *)  printf "\nSet a number between 10 and 3600 is recommended..\n\n"; continue ;;
 esac
fi
    sed -i "19d" $CONF
    sed -i "19i TIME=$o" $CONF
    printf "\nRefresh time has been set to: $o seconds..\n\n"
    echo -e "\n\n\033[1mSETUP FINISHED:\033[0m\n\033[1m----------------------\033[0m"
    printf "Successfully created /etc/emagnet.conf\n"
    printf "\nNow you're all set - Have phun - \e[1;1m'bash emagnet -e' \e[1;1m:-)\e[0m\n\n"
    cp .emagnetconf/emagnet.conf  /etc/
  exit
done
}

wgettimer() {
echo -e "\n\n\033[1mPROCESSOR SETUP:\033[0m\n\033[1m----------------------\033[0m
This setting will increase the speed you will download files from
pastebin dramatically, this wont affect how fast you will get banned
"
printf "Your\e[1;1m$(cat /proc/cpuinfo|grep 'model name'| awk -F: '{print $2}'|uniq)\e[0m processor has \e[1;1m$(nproc)\e[0m threads\n"
printf "Do you want emagnet to use all \e[1;1m$(nproc)\e[0m threads when downloading: (y/N): "; read threads
if [[ $threads = "y" ]]; then
    sed -i '72d' $CONF;sed -i "72 i THREADS=" $CONF;sed -i "s/THREADS=/THREADS=$(nproc)/g" $CONF;
    printf "\nConfig file has been updated, cpu threads has been set to \e[1;1m$(nproc)\e[0m thread(s)\n";else
    read -p "How many threads do you want to use (Ex: 2): " threadstouse
    sed -i '72d' $CONF;sed -i "72 i THREADS=" $CONF;sed -i "s/THREADS=/THREADS=$threadstouse/g" $CONF
    printf "\nConfig file has been updated, cpu threads has been set to \e[1;1m$threadstouse\e[0m thread(s).\n"
fi
}

emagnethome() {
echo -e "\n\n\033[1mPATH SETUP:\033[0m\n\033[1m----------------------\033[0m"

printf "Please specify in wich folder you to store all downloaded files from pastebin\n"
read -p "Path (Default: /opt/emagnet): " ehomedir
if [[ $ehomedir = "" ]]; then
  mkdir -p "\/opt\/root"
  sed -i '42d' $CONF;sed -i "42 i EMAGNET=\/opt\/\/emagnet" $CONF
  printf "\nConfig file has been updated, using \e[1;1m/opt/emagnet\e[0m as emagnets homedir. \n";else
  eehomedir="$(echo $ehomedir | sed 's/\/\///g')";sed -i '42d' $CONF;sed -i "42 i EMAGNET=$ehomedir" $CONF
  printf "\nConfig file has been updated, home dir has been set to: \e[1;1m$eehomedir/emagnet\e[0m\n"
fi
}

choosebrowser() {
if [[ -f $LYNX && -f $ELINKS ]]; then
echo -e "\n\n\033[1mBROWSER SETUP:\033[0m\n\033[1m----------------------\033[0m
Choose wich browser you prefer to use when emagnet will visit
pastebin.com for the latest uploads urls on site. If you don't
know which one you prefer it doesn't matter, just choose one.
"
    printf "It seems you have both lynx and elinks2 installed, you must choose one\n"; read -p "Option: (lynx/elinks): " browsertouse
if [[ $browsertouse = "lynx" ]]; then
    sed -i "530d" $SCRIPT
    sed -i "530i lynx -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet" $SCRIPT
    sed -i "618d" $SCRIPT
    sed -i '618i lynx -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT
    sed -i "830d" $SCRIPT
    sed -i '830i lynx -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT
    printf "\nConfig file has been updated, lynx will be used for downloading files\n"
    else
    sed -i "530d" $SCRIPT
    sed -i "530i elinks -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet" $SCRIPT
    printf "\nConfig file has been updated, elinks will be used for downloading files\n"
    fi
    elif [[ -f $LYNX && ! -f $ELINKS ]]; then
    sed -i "530d" $SCRIPT
    sed -i "530i lynx -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet " $SCRIPT
    elif [[ ! -f $LYNX && -f $ELINKS ]]; then
    sed -i "530d" $SCRIPT
    sed -i "530i elinks -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet" $SCRIPT 
    sed -i "618d" $SCRIPT
    sed -i '618i elinks -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT
    sed -i "830d" $SCRIPT
    sed -i '830i lynx -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT
    else
    echo -e "\n\n\033[1mBROWSER SETUP:\033[0m\n\033[1m----------------------\033[0m
Choose wich browser you prefer to use when emagnet will visit
pastebin.com for the latest uploads urls on site. If you don't
know which one you prefer it doesn't matter, just choose one.
Emagnet require lynx or elinks to be installed, you must choose one"

read -p "Prefered browser to install: (lynx/elinks): " browsertouse2
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
      sed -i "530d" $SCRIPT;sed -i "530i elinks -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet" $SCRIPT
      sed -i "621d" $SCRIPT;sed -i '621i elinks -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT; 
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
       sed -i "530d" $SCRIPT
       sed -i "530d" $SCRIPT
       sed -i "530i lynx -dump \$PASTEBIN|grep https|cut -c 7-|sed 's/com/com\\\/raw/g'|awk 'length(\$0)>32 && length(\$0)<35\'|grep -v 'messages\\\|settings\\\|languages\\\|archive\\\|facebook\\\|scraping' > /tmp/.emagnet" $SCRIPT
       sed -i "530d" $SCRIPT;
       sed -i "618d" $SCRIPT
       sed -i '618i lynx -dump $PASTEBIN > /tmp/.emagnet' $SCRIPT
       printf "\nConfig file has been updated, lynx will be used when downloading files from pastebin" $SCRIPT ;;
   N) exit 0 ;;
   \?) echo "Please enter a proper answer y=yes N=no" ;;
 esac
fi
}

idletime() {
  sed -i "78d" $CONF;sed -i "78i IDLETIME=1200" $CONF
}

clear;banner;choosebrowser;requirements;idletime;idletime;wip;emagnethome;wgettimer;settime;
