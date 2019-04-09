#the password is regular instead of MFA password
Connect-Msolservice -Credential
#Remove all license from Users
Import-Csv -Path C:\Users\jun.park\Desktop\Termination.csv | Foreach-Object{

$upn = $_.userprincipalname
(get-MsolUser -UserPrincipalName $upn).licenses.AccountSkuId |
foreach{
    Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses $_
}
}