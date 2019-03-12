![Screenshot](https://nr1.nu/emagnet-banner.png)

## _"I'll will find you, it's just a matter of time"_

Emagnet is a very powerful tool for it's purpose wich is to capture email addresses and especially leaked databases uploaded on pastebin since it's almost impossible to find them when they are out of latest top 10 list on https://pastebin.com. Either they have been deleted by pastebin's techs or the upload is just one in the crowd. To be honest it's easier to find a needle in a haystack then find outdated uploads on pastebin with the data we want to collect.

### Frequently Asked Question

- Q: Why not just use curl to fetch the urls and use tor for change ip everytime we get a temp ban in 20minutes?

- A: Cause then we must complete a captcha and we get href="https://www.cloudflare.com/5xx-error-landing?utm_source=iuam as response. 

For everyone that wanna use curl from a non-tor ip, then you can use the oneliner below:

      curl -Ls https://pastebin.com|grep -o -E 'href="([^"#]+)"' | cut -d'"' -f2|grep archive -A10 | sed -n 2,9p|sed 's/^/http:\/\/pastebin.com\/raw\//g' 


### GET STARTED

  You can copy and paste below code in your shell 

    git clone https://github.com/wuseman/EMAGNET
    cd EMAGNET;bash ./emagnet-setup.sh;bash emagnet -e
    
 ![Screenshot](https://nr1.nu/emagnet-howto.gif)

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

**I cannot be responsible for the user's actions regardless of what damage a user can achieve with the information/data emagnet might collect for any user(s). All users who are 
using emagnet for gathering or store information/data is 100% responsible for their own actions, emagnet has been developed for a legal purpose.**

#### END!




