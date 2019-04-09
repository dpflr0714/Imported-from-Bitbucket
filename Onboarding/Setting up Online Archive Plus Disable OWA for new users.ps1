#Connect to Exchange Server
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic
Import-PSSession $Session -DisableNameChecking
#Read users in CSV and turning online archive and disable OWA
Import-CSV -Path C:\Users\jun.park\Desktop\Creation.csv | Foreach-object{
Get-Mailbox -Identity $_.samaccountname | Enable-Mailbox -Archive | Set-CASMailbox -activesyncenabled $false -OWAfordevicesenabled $true -owaenabled $false
}