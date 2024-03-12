# Generate password based on the current two-digit year
$Year = (Get-Date).ToString("yy")  # Get the current two-digit year
$Password = "Avanti$Year"

# Convert the password to SecureString
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Prompt user for input
$FirstName = Read-Host "Enter the user's First Name"
$LastName = Read-Host "Enter the user's Last Name"

# Generate email address based on first name and last name
$EmailAddress = "$($FirstName.ToLower()).$($LastName.ToLower())@avantiwindow.com"

# Display the generated email address
Write-Host "Generated Email Address: $EmailAddress"

# Prompt user for other input
$DisplayName = "$FirstName $LastName"

# Create new MailUser
try {
    New-MailUser -Name $DisplayName -Password $SecurePassword -UserPrincipalName $EmailAddress -FirstName $FirstName -LastName $LastName

    Write-Host "MailUser created successfully."
} catch {
    Write-Host "Error creating MailUser: $_"
}
