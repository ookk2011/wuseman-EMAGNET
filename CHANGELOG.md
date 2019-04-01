### CHANGELOG FOR EMAGNET

##### Version 1.6.3

-    In this version the big changes has been in emagnet-setup.sh
-    Removed script path from config file since we have merged everything into one script now
-    Changed echo to printf in emagnet-setup were we printing if depends has been found or not
-    Emagnet setup script has been improved alot, much better descriptions and changed layout to a more clean look
-    Emagnet -f have been added as a new feature wich will fetch all latest uploads on pastebin.com without downloading
-    If you want to download the files you have choosed to fetch earlier then you just run emagnet -d for download them
-    If you want to grab email addresses and password to be sorted by below new feature then just run emagnet -e and just wait until emagnet will fetch new uploads as usual    
-    Changed DEFAULT refresh time to 60 seconds since pastebin have changed time limit how often you are allowed to visit pastebin until they will set a ban for 1600 seconds
-    Changed wait time for 1600 seconds, this is for everyone who sets a time intervall of 59 seconds or less (set a time of 60 secons or more to avoid bans)

##### Version 1.6.2 

-    Emagnet mirror has been removed
-    Emagnet clone any users git repositories has been removed
-    Emagnet up or down feature has been removed
-    Added a new feature for check stats of downloaded files and also how many email-addresses and passwords you have been found
-    Added emagnet archive feature, move all files to archive dir and merge all logs
-    Added a notice message if the time is set to 60 seconds or less and if your real ip is used
-    Fxed so all desc boxes are at the same length when running emagnet-setup
-    Edited so we grab our IP from nr1.nu properly since they rebuilt the page, no more sed is required
-    Small fixes

##### Version 1.6.1

-    ./emagnet-f.sh has been removed
-    Fixed the issue when a user choosed elinks as prefered browser it deleted wrong lines so emagnet got broken. Now you can run emagnet on Android(termux) again.
-    Bugfixes
-    Added better support when we getting banned by pastebin.com
-    Fixed the password issue i thought was fixed in last version, now everything will be sorted as it should be
-    Fixed so emagnet.log wont log both X emails and X passwords, if there is 0 passwords found and 2 email addresses then we just will add in wich files email addresses was found
-    Fixed typos

##### Version 1.6.0

-    After few days emagnet have download over 10 000+ files so now emagnet using day directories for keep things sorted
-    Emagnet is now supported on ANDROID via termux app.
-    Emagnet now got full support for elinks2, if you got both lynx and elinks2 installed you will be asked for wich browser you prefer, elinks is required if you run emagnet on any android device via termux.
-    Merged everything into emagnet (emagnet-f.sh) will call emagnet if you run emagnet -f
-    Parallel has been added to this version for ALOT faster downloads, it is required to have parallel installed. You will be asked to install parallel if you miss the package.̣
-    Fixed a small bug that did so files never moved from .temp path if there was an email found so it repeated that X mail addresses had been found.
-    Haveibeenpwned checker has been removed since it's useless cause we got banned all the time via emagnet
-    Debug mode has been removed.
-    Run emagnet in hidden mode has been removed, this will be re-added in next version.
-    Emagnet has been ALOT more stabilized from this version, no more random crashes.
-    Emagnet KILL has been added, if there is an ghost that running just run emagnet -k
-    Emagnet pastebin uploader from command line has been improved alot, now use emagnet -n $(command) OR command | emagnet -n for upload stdout to nr1.nu
-    IDLETIME and PARALLEL threads has been added to emagnet.conf
-    Improved source code alot, much more easier to follow how things have been setup from now.
-    Added comments to all functions so it's easier for people who want to improve/edit/reconfigure emagnet
-    Small layout changes.
-    Changed question emagnet used if you got banned and wanted to read the message for idle in 1200 seconds instead and then we start again, you can leave emagnet running 24/7 now it will handle everything perfect, you can change idle time if you want in /etc/emagnet.conf but remember pastebin use 20 minutes until they remove the temp ban if you wasn't PERMANENT banned (you must have been abusing pastebin VERY much for get permanent banned)

##### Version 1.5.1

-    Added idle time setting to conf file, this setting is for how long you want to stay idle if emagnet have noticed a ip ban from pastebin
-    Since we get millions of uploads then our path will be extremely big so now i have fixed that we gonna use daily folders instead
-    Emagnet will grab passwords from default now aswell
-    emagnet-setup has added descriptions for every setting
-    updated storage dirs so we can store dirs with dated dirs

##### Version 1.5

-   Some small fixes has been solved with setup script
-   emagnet-wbruter has been added as a new feature, consider this as a beta since this is still under active development

##### Version 1.4

-   I decided to split everything into small scripts instead since it's alot easier to troubleshoot if something goes wrong, you wont notice any difference at all, run 'emagnet' to execute them, 
    there is no  reason to run any of the scripts from .scripts dir, listing the new ones only:
    .scripts/emagnet-backup.sh
    .scripts/emagnet-banner.sh
    .scripts/emagnet-clone.sh
    .scripts/emagnet-f.sh
    .scripts/emagnet-help.sh
    .scripts/emagnet-hidden.sh
    .scripts/emagnet-main.sh
    .scripts/emagnet-mirror.sh
    .scirpts/emagnet-ping.sh
    .scripts/emagnet-requirements.sh
    .scripts/emagnet-spider.sh

-   Added .scripts/emagnet-ping.sh - Enter a dns and emagnet will check via downforjustyou website if host is up
    and for ipv4 number ip addressed emagnet gonna use '/bin/ping' instead for get a valid result very very fast if the ip-address is up or down.
-   It's now possible to use emagnet for upload from stdout from commandline, example usage: 'dmesg | emagnet -n'. Host does NOT store any ip number or other data about users at all.
-   Silent mode, download all urls and store them in background, you can go cook a cup of coffe instead! 
-   Small fixes
-   Mirror any website and download everything that is possible from the website(try mirror facebook, (EXTREMELY MUCH DATA =))
-   Gather all urls from a webpage, this is meant to be a web crawler.
-   It's now possible to clone all repos from any user on github.

##### Version 1.3

-   Emagnet will notice if you getting ip-banned from pastebin and then emagnet will stop and after X minutes emagnet will continue.
-   Small fixes
-   .scripts/emagnet-f.sh is a loop script, there i no reason for touch this, run emagnet -f to execute it.
-   Now execute setup.sh to setup everything before you will run emagnet. There is no requirements for edit 
    /etc/emagnet.conf anymore, just run emagnet-setup.sh and then you will be able to run emagnet.
-   Debug mode has been enable, use debug mode with arg: -d 

##### Version: 1.2

-   Fixed so we wont keep any duplicate.
-   Set your paths in /etc/emagnet.conf. There is no need for change stuff in 'emagnet' anymore.
-   Now emagnet store all files from pastebin so you can go through them later if you wanna find something offline without any stress..
-   More efficient logging to keep things sorted, all uploaded files that includes email addresses will be stored in it's own folder so it's easy to find passwords and mail addresses.
-   Added getopts, from now you must use -o, -h or -f to run emagnet.
-   Help section was added.
-   Paths need to be properly set in /etc/magnet.conf otherwise emagnet wont run (no more files in emagnet folder ;))
-   If pastebin has banned the current IP beccause you was an idiot and was trying to fetch uploads every <10s then emagnet will stop (just change ip)
-   Mirror any site and download all files that is possible from a website

