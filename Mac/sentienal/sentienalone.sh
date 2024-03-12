#!/bin/bash

token="ENTER TOKEN HERE"

payload="Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
waiting_room="/Library/Application Support/JAMF/Waiting Room/"
token_file="$waiting_room/com.sentinelone.registration-token"
payload_path="$waiting_room/$payload"

# Check if the waiting room directory exists
if [ ! -d "$waiting_room" ]; then
    echo "Error: The directory $waiting_room does not exist."
    exit 1
fi

# Write the token to the file
echo "$token" > "$token_file"
if [ $? -ne 0 ]; then
    echo "Error: Failed to write token to $token_file."
    exit 1
else
    echo "Token written to $token_file successfully."
fi

# Install the package
sudo /usr/sbin/installer -pkg "$payload_path" -target /
if [ $? -ne 0 ]; then
    echo "Error: Failed to install the package $payload_path."
    exit 1
else
    echo "Package $payload_path installed successfully."
fi

# Script executed without errors
exit 0
