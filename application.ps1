<# # Verbinden Sie sich mit Ihrem Exchange Online-Mandanten (Sie müssen Ihre Anmeldeinformationen angeben)
Connect-ExchangeOnline 
# Abrufen aller freigegebenen Postfächer
$sharedMailboxes = Get-EXOMailbox -RecipientTypeDetails SharedMailbox

# Durchlaufen Sie alle freigegebenen Postfächer
foreach ($sharedMailbox in $sharedMailboxes) {
    # Abrufen der "Senden als"-Berechtigungen für das Postfach
    $sendAsPermissions = Get-EXOPermission -Identity $sharedMailbox -ExtendedRights "SendAs"

    # Für jeden Benutzer mit "Senden als"-Berechtigung
    foreach ($permission in $sendAsPermissions) {
        $user = $permission.TrusteeName

        # Entfernen der "Senden als"-Berechtigung
        try {
            #Remove-EXOPermission -Identity $sharedMailbox -Trustee $user -ExtendedRights "SendAs" -Confirm:$false
            Write-Host "Successfully removed 'Send As' permission from user $user for mailbox $sharedMailbox."
        } catch {
            Write-Host "Error removing 'Send As' permission from user $user for mailbox $sharedMailbox. Error: $_"
        }

        # Hinzufügen der "Senden im Auftrag von"-Berechtigung
        try {
            #Add-EXORecipientPermission -Identity $sharedMailbox -Trustee $user -AccessRights SendOnBehalfOf -Confirm:$false
            Write-Host "Successfully added 'Send On Behalf Of' permission to user $user for mailbox $sharedMailbox."
        } catch {
            Write-Host "Error adding 'Send On Behalf Of' permission to user $user for mailbox $sharedMailbox. Error: $_"
        }
    }
}

# Trennen der Exchange Online PowerShell-Session
#Disconnect-ExchangeOnline -Confirm:$false
 #>



# Abrufen aller freigegebenen Postfächer
$sharedMailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox

# Durchlaufen Sie alle freigegebenen Postfächer
foreach ($sharedMailbox in $sharedMailboxes) {
    # Abrufen der "Senden als"-Berechtigungen für das Postfach
    $permissions = Get-MailboxPermission -Identity $sharedMailbox.Identity | Where-Object {
        $_.AccessRights -contains "SendAs" -and $_.User -notlike "NT AUTHORITY\*" -and $_.User -notlike "S-1-5-*" 
    }

    # Für jeden Benutzer mit "Senden als"-Berechtigung
    foreach ($permission in $permissions) {
        $user = $permission.User

        # Entfernen der "Senden als"-Berechtigung
        try {
            #Remove-MailboxPermission -Identity $sharedMailbox.Identity -User $user -AccessRights "SendAs" -Confirm:$false
            Write-Host "Successfully removed 'Send As' permission from user $user for mailbox $sharedMailbox.Identity."
        } catch {
            Write-Host "Error removing 'Send As' permission from user $user for mailbox $sharedMailbox.Identity. Error: $_"
        }

        # Hinzufügen der "Senden im Auftrag von"-Berechtigung
        try {
            #Add-MailboxDelegation -Identity $sharedMailbox.Identity -Trustee $user -SendOnBehalfTo $user -Confirm:$false
            Write-Host "Successfully added 'Send On Behalf Of' permission to user $user for mailbox $sharedMailbox.Identity."
        } catch {
            Write-Host "Error adding 'Send On Behalf Of' permission to user $user for mailbox $sharedMailbox.Identity. Error: $_"
        }
    }
}



