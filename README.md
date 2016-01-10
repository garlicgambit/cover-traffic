# Cover traffic

## What does it do
* Automatically create end-to-end encrypted connections to random https sites

## What can I do with it
* Run it in the background 24/7 to generate cover traffic. This might make it more difficult to establish patterns with (active) surveillance about whether you are working on your system or not.

## Project goals
* Thwart (active) surveillance by making it more difficult to correlate network traffic usage with actual system usage
* Make it easy to generate cover traffic
* Make it fairly difficult to distinguish cover traffic from normal traffic
* Make it decently secure out of the box (caveat emptor)

## Design
* A script which connects to a random https website at a random 0-60 minute interval
* Only support SSL/TLS connections with strong crypto and forward secrecy
* All web data is deleted immediately
* Currently supports more then 2.500 https sites (import of Google Chrome HSTS list)
* The Tor Browser user agent is used when downloading website data
* Works with Tor and other proxies
* Simple tools are used to minimize the attack surface

## Software
* Curl or wget is used to fetch website data
* Optional: Tor is used to create anonymous connections

## OS support
* Unix and Linux

## License
* Consider the code to be public domain. If you or your jurisdiction do not accept that then consider the code to be released under Creative Commons 0 (CC0). If you or your jurisdiction do not accept that... well then settle for the MIT license. What we mean to say is that you are free to copy, modify and relicense the code by all means. But don't hold us liable for any damages incurred by using or abusing the software.
* Code which is copied from other projects remains under the original license.

## General security notes
* For increased security it is recommended to run it with a separate locked down user account.
* For maximum security it is recommended to run it on a dedicated device.

## General privacy notes
* For increased privacy it is recommended to use a VPN or a proxy like Tor.

## Tor tips
* Some scripts support Tor out of the box. These scripts will use socksport 9050. If you already use Tor port 9050 for your normal web traffic and you want to separate that from Cover Traffic traffic then you should set the Cover Traffic scripts to use a different Tor socksport.
* Use the 'IsolateDestAddr' option with the Tor socksport for increased traffic isolation.

## How to install Cover Traffic with Tor on a Debian/Ubuntu based linux distribution
1. Install git, curl and tor (or wget if your prefer wget over curl)
    ```
    sudo apt-get update
    sudo apt-get install git curl tor
    ```
2. Clone the git repository
    ```
    git clone https://github.com/garlicgambit/cover-traffic.git
    ```

## How to use Cover Traffic over Tor
1. Run the script
    ```
    cd cover-traffic
    ./traffic.sh
    ```

2. That's it

## How to use Cover Traffic without Tor
1. Run the script
    ```
    cd cover-traffic
    ./traffic-non-tor.sh
    ```

2. That's it

## How to automatically run Cover Traffic over Tor with cron every 30 minutes on a Debian/Ubuntu based linux distribution
1. Login as the user you want to run Cover Traffic with

2. Edit the crontab of this user (If you are asked to select an editor use nano)
    ```
    crontab -e
    ```

3. Add the following line at the bottom of the crontab file (change username and location to the correct values)
    ```
    0,30 * * * * /home/<username>/cover-traffic/traffic.sh &> /dev/null
    ```

4. Save the file and exit

5. That's it

## How to automatically run Cover Traffic over Tor with cron every 30 minutes on a separate locked down user account on a Debian/Ubuntu based linux distribution
1. Create a locked down user account with the following command
    ```
    sudo useradd --create-home --shell /usr/sbin/nologin <username>
    ```

    Example with username exampleuser:
    ```
    sudo useradd --create-home --shell /usr/sbin/nologin exampleuser
    ```

2. Copy the Cover Traffic files to the new user
    ```
    sudo cp -r cover-traffic/ /home/<username>/
    ```

    Example with username exampleuser:
    ```
    sudo cp -r cover-traffic/ /home/exampleuser/
    ```

3. Set correct owner and file permissions on the folder and files
    ```
    sudo chown -R  <username>:<username> /home/<username>/cover-traffic
    sudo chmod 700 <username>:<username> /home/<username>/
    ```

    Example with username exampleuser:
    ```
    sudo chown -R  exampleuser:exampleuser /home/exampleuser/cover-traffic
    sudo chmod 700 exampleuser:exampleuser /home/<username>/
    ```

4. Open the crontab of this user
    ```
    sudo -u <username> crontab -e
    ```

    Example with username exampleuser:
    ```
    sudo -u exampleuser crontab -e
    ```

5. Add the following line at the bottom of the crontab file (change username and location to the correct values)
    ```
    0,30 * * * * /home/<username>/cover-traffic/traffic.sh &> /dev/null
    ```

    Example with username exampleuser:
    ```
    0,30 * * * * /home/exampleuser/cover-traffic/traffic.sh &> /dev/null
    ```

6. Optional: Add strict firewall rules to this user account. A detailed explanation how to do this is currently beyond the scope of this document.

7. That's it

## Warning
* This project is still in alpha phase.
* Use this project with caution, no guarantees that this will work in your situation.
* Every time your device connects to another device there is a chance of infection or compromise.
* Generating traffic at (random) intervals can also be a pattern.


## Donate to support development of our projects
Bitcoin:
14b5ztH1aCkCBxGD7ug5mmos83kuBoLwSp

Monero:
463DQj1ebHSWrsyuFTfHSTDaACx3WZtmMFMwb6QEX7asGyUBaRe2fHbhMchpZnaQ6XKXcHZLq8Vt1BRSLpbqdr283QinCRK
