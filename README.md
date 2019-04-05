![Screenshot](https://nr1.nu/emagnet/pictures/emagnet-maskot.png)

## _"I'll will find you, it's just a matter of time"_

Emagnet is a very powerful tool for it's purpose wich is to capture email addresses and especially leaked databases uploaded on pastebin since it's almost impossible to find them when they are out of latest top 10 list on https://pastebin.com. Either they have been deleted by pastebin's techs or the upload is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect.

##### Got some questions from some peps with low or no linux experience at all and they wanted know how to sort things into a human readable format so I decided to show an example instead of answer the questions one by one and since probably someone else want to know.

##### In this example I will search for the latest leaked spotify accounts, hopefully your account has NOT been leaked. The files I am searching through has been downloaded via emagnet between 2019-04-01 > 2019-04-04 _only_ so this is a nice proof how many accounts that is getting leaked in three days(remember this is spotify leaks only), hopefully people that have been saying say something like "NOBODY CAN GET MY LOGIN DETAILS, WHY WOULD SOMEONE WANT TO LEAK MY ACCOUNT?"

##### 1) First of all, search for all files that contains the word _SPOTIFY_ (This is an awesome mix with find + parallel + grep to speed up things since we like when things going fast):
   
    find /opt/emagnet/archive/ -type f | parallel -k -j150% -n 1000 -m grep -H -in 'spotify' {}

##### 2) You have probably already figured out that it will be a big mess when I _searching_ for 'spotify' only... So, then I gonna grep all '_MAIL ADDRESSES_' + _'SPOTIFY'_ instead:
    
    grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*"

##### 3) I want all details sorted line by line instead of having alot of spaces here and there so we gonna use \S for this:
    
    grep '\S' 

##### 4) I do not care about the filenames anymore since all we want right now is to gather the 'MAIL ADDRESSES' + 'PASSWORDS':
    
    cut -d: -f2,3

##### 5) The guys that leaks all data on pastebin has different forms to separate things, so let us skip all forms that includes 'mail|;/password'/ and instead aim on mail:passwords since that is sitll the most used form, this can easily be filtered later if we want too but to keep this as simple as possible let us start with this form only: 

    awk -F'|' '{print$1}'|cut -d/ -f1

##### 6) Now I want to keep the list sorted also since it will be easier to find the accounts we looking for without some advanced commands for all ppl that have no knowledge about CLI commands so it will be easy to go through the list from a to z:

    sort -r

##### 7) Of course I do not want duplicates since some ppl leaking same credenticals for some accounts twice in different lists:

    awk -F, '!seen[$1]++'

##### 8) If you want all accounts & password in a separate file you can use >> in bash to write data into files. If you want separate the details with , instead of : or whatever character you want to use if you want to import a list into your own sql/mysql database you can use sed for this purpose:

    commands here from above | _sed 's/:/,/g'_ > leaked-spotify-accounts-20190401_to_20190405.txt 

##### All above commands in a one-liner, try to copy paste it when you have fetched some accounts. Change spotify whatever you wanna find, gmail, paypal, facebook, twitter etc etc etc etc..

    find /opt/emagnet/archive/ -type f | parallel -k -j150% -n 1000 -m grep -H -in 'spotify' {} | grep -rEiEio "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:...*"|grep '\S' | cut -d: -f2,3|awk -F'|' '{print$1}'|cut -d/ -f1|sort -r|less|awk -F, '!seen[$1]++' > leaked-spotify-accounts-20190401_to_20190405.txt 
    
 ### VIDEO EXAMPLE OF ABOVE COMMANDS one by one:
 
 ![Screenshot](_video/spotify-leaks.gif)


### GET STARTED

##### You can copy and paste below code in your shell 

    git clone https://github.com/wuseman/EMAGNET
    cd EMAGNET;bash ./emagnet-setup.sh;bash emagnet -e
    
### EMAGNET WIKI

- [ABOUT](https://github.com/wuseman/EMAGNET/wiki/ABOUT) - 
_How everything started._

- [FAQ](https://github.com/wuseman/EMAGNET/wiki/FAQ) - 
_How to grab your visa card if it has been leaked. Also get answers why we not using TOR._

- [TIPS & TRICKS](https://github.com/wuseman/EMAGNET/wiki) - 
_How To Find your facebook credenticals, if it has been leaked._

### REQUIREMENTS

- _Parallel_ - Find more info about _parallel_ [here.](https://www.gnu.org/software/parallel/)
- _Wget_     - Find more info about _wget_ [here.](https://www.gnu.org/software/wget/)
- _Curl_    - Find more info about _curl_ [here.](https://github.com/curl/curl)
- _Lynx_     - Find more info about _lynx_ [here.](https://lynx.browser.org/)
- _Elinks_   - Find more info about _elinks_ [here.](http://elinks.or.cz/)

### CONTACT 

  If you have problems, questions, ideas or suggestions please contact me: wuseman@nr1.nu

_If you are one of these who dislikes emagnet and believes the program has been founded for a bad reason then I am not interested in taking part of your opinions, keep them
for yourself! Read the history about emagnet [here](https://github.com/wuseman/EMAGNET/wiki/About) - Haters gonna hate_

### NOTICE

_wuseman cannot be held as responsible for users actions regardless of what damage a user can achieve with the information/data emagnet might collect for any user(s). All users that  gathering information or data via emagnet is 100% responsible for their own actions, emagnet has been developed for a legal purpose._

#### END!
