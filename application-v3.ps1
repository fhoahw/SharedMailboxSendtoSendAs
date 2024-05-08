# Variablen fuer das Logging definieren
$logFile = "C:\ExchangeLogs\SharedMailboxPermissions.log"

# Log-Datei vorbereiten
if (-not (Test-Path "C:\ExchangeLogs")) {
    New-Item -ItemType Directory -Path "C:\ExchangeLogs"
}
if (Test-Path $logFile) {
    Remove-Item $logFile -Force
}
New-Item -ItemType File -Path $logFile

function LogWrite {
    Param ([string]$logString)
    Add-Content $logFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $logString"
    Write-Host $logString
}

# Verbinden Sie sich mit Ihrem Exchange Online
Connect-ExchangeOnline 

# Alle Shared Mailboxes auflisten
$sharedMailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails SharedMailbox

# Test Felix - Nimmt nur Sharedmailboxen deren Alias Adresse mit "test" beginnt.
#$sharedMailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails SharedMailbox -Filter { Alias -like 'test*' }



foreach ($mailbox in $sharedMailboxes) {
    LogWrite "Bearbeitung der Shared Mailbox: $($mailbox.DisplayName)"

    # SendAs Berechtigungen abrufen
    $sendAsPermissions = Get-RecipientPermission -Identity $mailbox.Identity | Where-Object { $_.AccessRights -eq "SendAs" -and $_.Trustee -notlike 'NT AUTHORITY\*' }
    
    foreach ($permission in $sendAsPermissions) {
        # SendAs Berechtigung entfernen
        Try {
            Remove-RecipientPermission $mailbox.Identity -Trustee $permission.Trustee -AccessRights SendAs -Confirm:$false
            LogWrite "SendAs Berechtigung entfernt von $($permission.Trustee)"
        } Catch {
            LogWrite "Fehler beim Entfernen der SendAs Berechtigung von $($permission.Trustee): $_"
        }

        # SendOnBehalf Berechtigung hinzufuegen
        Try {
            Set-Mailbox $mailbox.Identity -GrantSendOnBehalfTo @{Add=$permission.Trustee}
            LogWrite "SendOnBehalf Berechtigung hinzugefuegt fuer $($permission.Trustee)"
        } Catch {
            LogWrite "Fehler beim Hinzufuegen der SendOnBehalf Berechtigung fuer $($permission.Trustee): $_"
        }
    }
    LogWrite "-------------------------"
}

LogWrite "Skript abgeschlossen."

Disconnect-ExchangeOnline
