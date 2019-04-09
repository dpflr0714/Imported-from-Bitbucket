#Connecting to AzureAd with stored credential, does not Require MFA?
$Cred = Get-Credential
Connect-AzureAd -Credential $Cred

Connect-MsolService
#Licensing new user based on UPN: 	PMACLS:ENTERPRISEPACK for e3 		PMACLS:O365_BUSINESS_PREMIUM for business premium
Import-Csv -Path C:\Users\jun.park\Desktop\Creation.csv | Foreach-Object{
Set-MsolUser -UserPrincipalName $_.userprincipalname -Usagelocation US
(Set-MsolUserLicense -UserPrincipalName $_.userprincipalname -AddLicenses "PMACLS:O365_BUSINESS_PREMIUM" ) 
}