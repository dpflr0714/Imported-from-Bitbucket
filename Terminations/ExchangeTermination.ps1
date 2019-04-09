

#Connecting to Exchange Online Powershell
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic
Import-PSSession $Session -DisableNameChecking

Import-CSV -Path C:\Users\jun.park\Desktop\Termination.csv | Foreach-object{
#Setting up Email and Forwarding 
Get-Mailbox -identity $_.samaccountname  | Set-Mailbox -ForwardingAddress $_.forwardingaddress


#Disabling Mobile Access and disabling weboutlook access, converting to shared email
Set-CASmailbox -Identity $_.samaccountname -activesyncenabled $false
Set-CASmailbox -Identity $_.samaccountname -OWAfordevicesenabled $false
Set-CASmailbox -identity $_.samaccountname -owaenabled $false
Set-Mailbox -identity $_.samaccountname -Type shared

}