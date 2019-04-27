![Screenshot](https://nr1.nu/emagnet/pictures/emagnet-maskot.png)

## _"I'll will find you, it's just a matter of time"_


| Version            |  Released      | Status                            | Tested On                          |
| :----------------- | :------------- | :-------------------------------- | :----------------------------------|
| `2.0`              |  2019-04-22    | Under active development          | Linux - Windows - MacOS - Android  |

Emagnet is a very powerful tool for it's purpose wich is to capture email addresses and passwords from leaked databases uploaded on pastebin. It's almost impossible to find leaked passwords when they are out of list on pastebin.com. Either they have been deleted by pastebin's techs or the uploads is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect.

### Brute force mode has been added in version 2.0

![Screenshot](https://nr1.nu/emagnet/pictures/ezgif-4-a9aa514e4dc4.gif)


### Get Started On Linux/MacOSX
 
    git clone https://github.com/wuseman/EMAGNET
    cd EMAGNET;bash ./emagnet-setup.sh;bash emagnet -e emagnet

* Normal mode without brute forcing: 

      emagnet -e emagnet

* Start brute force attack if there is any mail:password combinations found. If there is no mail:passwords found we just trying again as normal mode. (NOTICE: Support for GMAIL accounts only)
 
      emagnet -e bruteforce

###  Get Started On Windows 10

Please visit my installation [wiki](https://github.com/wuseman/EMAGNET/wiki/Installation) for more info (includes a video)


### Notice: 

Emagnet brute forcer is just the beginning of what's coming and is still under development , _but_ if you are not satisfied with the gmail brute forcer then you can use my simple script I have been used for a while for all kind of stuff, it can be used for anything only your imagination can stop you. It doesn't have to be more difficult than this. Hopefully you might get some ideas with my example below, good luck and have fun! 


#### Here is an example how you can call another script in another session (The tool in video can be found [here](https://github.com/D4Vinci/Cr3dOv3r.git))

![Screenshot](https://nr1.nu/f/emagnet-third-party.gif)

### Just use some regex to grep what you looking for. This is a very good start thanks to inotifywait wich is an extremely powerful tool for this purpose. 

       #!/bin/bash
       
       inotifywait -q -m -r -e create --format '%w%f' "/path/to/monitor" | while read FILES; do
       # Run-your-favorit-tool-here--read-files-by-$(cat $FILES)
       # Just an example usage for Hydra that can be used when you download uploads from pastebin: 
       hydra -C $FILES ftp://$(grep-a-ip-or-hostname-for-example)”    
       # For use my example in the video: (for hit enter when cr3d0v3r asking for password read: "manual yes") 
       cd /path/to/Cr3dOv3r;python -q emailaddress.com 
       done


### Wiki Sections:

- [About](https://github.com/wuseman/EMAGNET/wiki/ABOUT) - 
_How everything started._

- [Faq](https://github.com/wuseman/EMAGNET/wiki/FAQ) - 
_How to grab your visa card if it has been leaked. Also get answers why we not using TOR._

- [Installation](https://github.com/wuseman/EMAGNET/wiki/INSTALLATION) - 
_Video preview for how to get started on windows_

- [Tips & Tricks](https://github.com/wuseman/EMAGNET/wiki) - 
_How To Find your facebook credenticals, if it has been leaked._

### System requirements

- Bash     - Find more info about _bash_ [here](https://www.gnu.org/software/bash/)
- Parallel - Find more info about _parallel_ [here](https://www.gnu.org/software/parallel/)
- Wget     - Find more info about _wget_ [here](https://www.gnu.org/software/wget/)
- Curl     - Find more info about _curl_ [here](https://github.com/curl/curl)
- Lynx     - Find more info about _lynx_ [here](https://lynx.browser.org/)
- Elinks   - Find more info about _elinks_ [here](http://elinks.or.cz/)

## Changelog

[Versions changelog](CHANGELOG.md).


## Authors: 

* **wuseman <wuseman@nr1.nu\>** 

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE.md](LICENSE.md) file for details


### Contact

  If you have problems, questions, ideas or suggestions please contact me on the e-email under _Authors_ or you can chat with me for faster contact by visit freenode chat and type '/msg wuseman hi!' in the input bar and I will reply you ASAP I will see the message.
  
  Enter Freenode chat via your own client or use the web client by visit this ![page](https://webchat.freenode.net/)

### Haters Gonna Hate

If you are one of these who dislikes _EMAGNET_ and believe the program has been developed for a reason that would break the law then I am not interested in taking part of your opinions, keep them for _yourself_! Emagnet does **NOT** leak any data at all. _EMAGNET_ gathering data from PASTEBIN and that is the source for all files EMAGNET is downloading.

If you'r email AND password is in my video tutorials please change your password **_ASAP_** and contact PASTEBIN to request  a removal from the source. This is nothing i can be held responsible for. Pastebin contact formular can be found [here](https://pastebin.com/contact)
 
Be more careful with your private data - It's 2019, you **really** should know better how to keep your data private. 

ALL questions about this will be ignored and filtered as spam FYI. 

Feel free to read the history about emagnet [here](https://github.com/wuseman/EMAGNET/wiki/About) and how everything started about this project.

### Notice

Brute forcing any user(s) account that you do not own or have been granted permission to sign in on is **stricly** forbidden, in most countrys you will break the law so please don't use EMAGNET for any illegal purposes, emagnet has been developed for a a legal purpose to count data and statistics.

wuseman says: All my previews where a brute force attack is under controlling forms. If you have any questions about this then you are welcome to contact me.


_wuseman cannot be held as responsible for users actions regardless of what damage a user can achieve with the information/data emagnet might collect for any user(s). All users that  gathering information or data via emagnet is 100% responsible for their own actions, emagnet has been developed for a legal purpose._

####
#### Emagnet development has just started and is FAR away from complete, to be continued. 
####
