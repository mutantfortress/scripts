#/bin/bash

currentuser=$(/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4)

sudo dseditgroup -o edit -d "$currentuser" -t user admin 
