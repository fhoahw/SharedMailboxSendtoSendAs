# Login to Exchange Online
#Connect-ExchangeOnline


#$sharedMailboxes = Get-EXOMailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited
$sharedMailboxes = "test1@ahwdigital.onmicrosoft.com","test2@ahwdigital.onmicrosoft.com","test3@ahw-digital.de"

foreach ($element in $sharedMailboxes) {
    $mailbox = $element.PrimarySmtpAddress
    $users = Get-Mailbox -Identity $element.PrimarySmtpAddress | Format-List GrantSendAs
    Write-Output $users
    # Get-MailboxPermission -Identity $element.PrimarySmtpAddress | Format-List | Write-Output 
}

