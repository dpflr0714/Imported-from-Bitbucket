Import-CSV -path C:\Users\jun.park\Desktop\Creation.csv | New-ADUser -PassThru | `
#Reading the properties through CSV and creating accounts
Set-ADAccountPassword -Reset -NewPassword (ConvertTo-SecureString -AsPlainText 'Awf2019!' -Force) -PassThru | Enable-ADAccount
#Copy Member of Profile from One user to another

Import-CSV -path C:\Users\jun.park\Desktop\Creation.csv | Foreach-object{
$CopyFrom = Get-Aduser $_.instance -prop MemberOf
$CopyTo = Get-Aduser $_.samaccountname -prop Memberof
$CopyFrom.Memberof | Where{$CopyTo.Memberof -notcontains $_} | Add-AdGroupmember -Members $CopyTo
}


Add where to move them to in OU same as the instance