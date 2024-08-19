# Variablen fuer das Logging definieren
$logFile = "C:\ExchangeLogs\AllUserMailboxesSendAs.log"

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
#Connect-ExchangeOnline 

# Alle Shared Mailboxes auflisten
$sharedMailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox

# Test Felix - Nimmt nur Sharedmailboxen deren Alias Adresse mit "test" beginnt.
#$sharedMailboxes = Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails SharedMailbox -Filter { Alias -like 'test*' }

$permissionUser = "backofficebot@atp-group.de"

foreach ($mailbox in $sharedMailboxes) {
    LogWrite "Bearbeitung der User Mailbox: $($mailbox.DisplayName)"


        # SendOnBehalf Berechtigung hinzufuegen
        Try {
            Add-RecipientPermission -Identity $mailbox.Identity -Trustee $permissionUser -AccessRights SendAs
            Add-MailboxPermission -Identity $mailbox.Identity -User $permissionUser -AccessRights FullAccess -AutoMapping $false
            LogWrite "Berechtigung hinzugefuegt fuer $($permissionUser)"
        } Catch {
            LogWrite "Fehler beim Hinzufuegen der SendAs Berechtigung fuer $($permissionUser): $_"
        }
    }
    LogWrite "-------------------------"

LogWrite "Skript abgeschlossen."

