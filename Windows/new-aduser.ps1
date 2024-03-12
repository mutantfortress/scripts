$first= Read-host "What is the user's first name?"
$last= Read-host "What is the user's last name?"
$psswd= Read-host "Enter user's password"


# Prompt the user to choose an option
Write-Host "Where is the user located?:"
Write-Host "1. Arizona"
Write-Host "2. Texas"
Write-Host "1. California"
Write-Host "2. Florida"
Write-Host "1. Nevada"
$choice = Read-Host "Enter your choice "

# Run different parts of the script based on the user's choice
switch ($choice) {
    1 {
        # Code to execute for Option 1
        Write-Host "You chose Arizona"
        new-aduser  -Name "$first $last" -GivenName $first -Surname $last -DisplayName "$first $last" -EmailAddress <String> -AccountPassword $psswd -State Arizona -Country US -AccountExpirationDate false -PasswordNeverExpires true -Enabled true -Organization "El Mirage"
        # Place your Option 1 code here
    }
    2 {
        # Code to execute for Option 2
        Write-Host "You chose Option 2."
        # Place your Option 2 code here
    }
    default {
        Write-Host "Invalid choice. Please enter 1 or 2."
    }
}
