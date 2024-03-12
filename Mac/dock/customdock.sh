#!/bin/bash

#variables
DOCKUTIL_BINARY=/usr/local/bin/dockutil
sleep=/bin/sleep
currentuser=$(/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4)
classic='/Applications/Microsoft Teams.app'
new=com.microsoft.teams2
defender='/Applications/Microsoft Defender.app'
remove=/bin/rm
home=/home
macOS_version=$(sw_vers -productVersion)
monterey=12.9.9
installer=$(/usr/sbin/installer -pkg)
chrome_package="/Library/Application Support/JAMF/Waiting Room/GoogleChrome.pkg"
new_package="/Library/Application Support/JAMF/Waiting Room/MicrosoftTeams.pkg"
rdp_package="/Library/Application Support/JAMF/Waiting Room/Microsoft_Remote_Desktop_10.3.1_installer.pkg"
tv_package="/Library/Application Support/JAMF/Waiting Room/TeamViewer_Full.pkg "
target=$( -target /)

#Create a log file of this script
exec > /Users/$currentuser/docklog-intial_$(date +"%F_%H%M").txt 2>&1

#cache packages
echo Running Policy 52
/usr/local/bin/jamf policy -id 52

#Clear the Dock
echo Removing all Dock Items
$DOCKUTIL_BINARY --remove all --allhomes --no-restart

#sleep for 2 seconds
$sleep 5

#which OS is running
if [ "$(printf '%s\n' "$macOS_version" "$monterey" | sort -V | head -n 1)" = "$monterey" ]; then
    echo "System Settings is found!"
    $DOCKUTIL_BINARY --add '/System/Applications/System Settings.app' --allhomes --no-restart
else
    echo "System Preferences is found!"
    $DOCKUTIL_BINARY --add '/System/Applications/System Prefences.app' --allhomes --no-restart
fi

#check to see if MS Teams Classic is installed
if pkgutil --pkgs | grep -E -m 1 "^com\.microsoft\.teams$" > /dev/null; then
    echo "Removing Teams Classic"
    /bin/rm -rf "/Applications/Microsoft Teams classic.app" && /usr/sbin/pkgutil --forget com.microsoft.teams
else 
    echo "No Classic found"
fi

#check to see if Google Chrome is installed
if ! pkgutil --pkg-info=com.google.Chrome > /dev/null 2>&1; then
    echo "Installing Google Chrome"
    $installer $chrome_package $target
    echo "Google Chrome installed"
else 
    echo "Google Chrome already installed"
fi

#check to see if MS Teams (work or school) is installed
if ! pkgutil --pkg-info=com.microsoft.teams2 > /dev/null 2>&1; then
    echo "Installing New Teams"
    $installer $new_package $target
    echo "New Teams installed"
else 
    echo "New Teams already installed"
fi

#check to see if Remote Desktop is installed
if ! pkgutil --pkg-info=com.microsoft.rdc.macos > /dev/null 2>&1; then
    echo "Installing RDP"
    $installer $rdp_package $target
    echo "RDP installed"
else 
    echo "RDP already installed"
fi

#check to see if Team Viewer is installed
if ! pkgutil --pkg-info=com.teamviewer.teamviewer > /dev/null 2>&1; then
    echo "Installing TeamViewer"
    $installer $tv_package $target
    echo "TeamViewer installed"
else 
    echo "TeamViewer already installed"
fi

#Build the Dock
$DOCKUTIL_BINARY --add '/Applications/Self Service.app' --allhomes --no-restart
$DOCKUTIL_BINARY --add '/Applications/Google Chrome.app' --allhomes --no-restart
$DOCKUTIL_BINARY --add '/Applications/Microsoft Outlook.app' --allhomes --no-restart
$DOCKUTIL_BINARY --add '/Applications/Microsoft Teams (work or school).app' --allhomes --no-restart
$DOCKUTIL_BINARY --add '/Applications/Microsoft Remote Desktop.app' --allhomes --no-restart
$DOCKUTIL_BINARY --add '/Applications/TeamViewer.app' --allhomes --no-restart

#reload dock
/usr/bin/killall Dock