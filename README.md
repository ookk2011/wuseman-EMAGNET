## <p align="center">![Screenshot](https://nr1.nu/emagnet/previews/emagnet_oldmovi.gif)

## <p align="center"> _"I'll will find you, it's just a matter of time"_
<p align="center">

<a href="https://github.com/wuseman/EMAGNET">
<img src="https://img.shields.io/github/languages/top/wuseman/emagnet.svg?color=magenta&label=Bash%2FShell"></a>

<a href="https://github.com/wuseman/EMAGNET/issues?q=is%3Aissue+is%3Aclosed">
<img src="https://img.shields.io/github/issues-closed/wuseman/emagnet.svg?color=light&label=Closed%20Issues"></a>
  
<a href="https://github.com/wuseman/EMAGNET/issues">
<img src="https://img.shields.io/github/issues-raw/wuseman/emagnet.svg?color=orange&label=Open%20Issues"></a>
 
<img src="https://img.shields.io/github/last-commit/wuseman/emagnet.svg?color=darkmagenta&label=Latest%20Commit">

<a href="https://twitter.com/wuseman1">
 <img src="https://img.shields.io/website/https/nr1.nu.svg?down_color=darkred&down_message=DOWN&label=Nr1.nu%2Femagnet&up_message=UP">
    <img src="https://img.shields.io/github/license/wuseman/emagnet.svg?color=blue&label=License"></a></a></a>
</a>
</p>

![BBC: 'Pastebin: Running the site where hackers publicise their attacks'](https://www.bbc.com/news/technology-17524822) - Emagnet is your best friend for get the leaks ;-)

| Current Version    |  Released      | Status                            | Tested On                          |
| :----------------- | :------------- | :-------------------------------- | :----------------------------------|
| `3.2`              |  2019-07-20    | Beta                              | Linux                               |
| `3.1`              |  2019-07-14    | Stable                            | Linux - Windows - MacoSX - Android   |



Emagnet is a very powerful tool for it's purpose wich is to capture email addresses and passwords from leaked databases uploaded on pastebin. It's almost impossible to find leaked passwords when they are out of list on pastebin.com. Either they have been deleted by pastebin's techs or the uploads is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect. 

#### For previews how it looks before you getting started, see ![here](https://github.com/wuseman/EMAGNET/wiki/Previews)

### Get Started On Linux/MacOSX

    git clone https://github.com/wuseman/emagnet
    cd emagnet
    chmod +x emagnet*
    bash ./emagnet-setup.sh
    bash emagnet --help

* Normal mode without brute forcing:

      ./emagnet --emagnet

### NEWS!

* Brute force ipv4 addresses has been added after a request, this is a very very powerful ssh bruteforcer that will use parallel to bruteforce, you will portscan over 7000 targets in <60 seconds thanks to GNU/Parallel and you will *only* attack targets that having port 22 open, all this will be done within minutes.

*  _Don't break the law!_ - Emagnet has been developed for a legal purpose.

![Screenshot](https://nr1.nu//emagnet/previews/emagnet-3.2.gif)

      ./emagnet --bruteforce ssh


###  Get Started On Windows 10

Please visit my installation [wiki](https://github.com/wuseman/EMAGNET/wiki/Installation) for more info (includes a video)

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

