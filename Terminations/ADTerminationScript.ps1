Import-Csv -Path C:\Users\jun.park\Desktop\Termination.csv | Foreach-Object{

Set-ADAccountPassword -Identity $_.samaccountname -Reset -NewPassword (ConvertTo-SecureString -AsPlaintext "Awf2019!" -Force)

#Degroup except domain user
$ADgroups = Get-ADPrincipalGroupMembership -Identity $_.samaccountname | where {$_.Name -ne “Domain Users”}
Remove-ADPrincipalGroupMembership -Identity $_.samaccountname -MemberOf $ADgroups -Confirm:$false

#Setting email nickname
Get-ADuser $_.samaccountname -properties MailNickName | Set-Aduser -Replace @{MailNickName = $_.samaccountname}

#Exchange Hide From Address, setting it true
Get-ADuser $_.samaccountname -properties msexchhidefromaddresslists | Set-Aduser -Replace @{msexchhidefromaddresslists = $true}

#Clearing Manager
Set-ADuser $_.samaccountname -Manager $null

#Disable and move them to Disabled Accounts Folder
Disable-ADAccount -Identity $_.samaccountname
Get-ADUser -Identity $_.samaccountname | Move-ADObject -TargetPath "OU=Disabled Accounts,DC=amwestfunding,DC=internal"
}



# SIG # Begin signature block
# MIIFoQYJKoZIhvcNAQcCoIIFkjCCBY4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUdLyDfiYCc6dgRzbd9idz2u8y
# mO2gggM2MIIDMjCCAhqgAwIBAgIQMa7yIAA8qI9Ii81s9YF5QDANBgkqhkiG9w0B
# AQsFADAgMR4wHAYDVQQDDBVkcGZscjA3MTRAaG90bWFpbC5jb20wHhcNMTkwMjI1
# MjIyNDE0WhcNMjAwMjI1MjI0NDE0WjAgMR4wHAYDVQQDDBVkcGZscjA3MTRAaG90
# bWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWlox8V+op
# 1l8i9EKQ8G4Zza15y2jMp2xn/cSRQqjcrvpW05Fdk3r9tnt/CpeQonacSJYFf2B6
# okRMR/MqAcG+GS7mf3Pz0AYB/U6CVwwYHQ7sJUHewvmLBRkgGE4jww7uvkJb4zdJ
# JuXclvkXgRpg0Sw31rO2Y7TKEFvyq3dgyowzIN39MRjs+XnRI9xVqDfo+49uqWoH
# i82cHOExITSFs30gVkxEtX0vDumYpcpjNiNEsxZ+FF202XFbp8bcOOJ86LK/Fau+
# h5TE+ucxNG+flTxihAi2FBeombhi3kEhgMUcz0F/XUwgDp3mGIKLocjFvpcdJYfS
# VCehxK2X5jW1AgMBAAGjaDBmMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAgBgNVHREEGTAXghVkcGZscjA3MTRAaG90bWFpbC5jb20wHQYDVR0O
# BBYEFM2IfrgTjzWsrONCSfGj9E14m51zMA0GCSqGSIb3DQEBCwUAA4IBAQAed8Wi
# 4lyjDQbShbGegLQH9gcskLd3dLg+g8LE99uaUKwFhFWnrTfK6AxWDmIXiZW2uu2Y
# ETyMar0m7hbrEbMCbXERqxuk/c9x0u+CbL5mnmuQSt0tCojMn/LwXDWsVeyLQt6D
# 6RYWHSt0hzC4pQtAINBr8R3WDCn98wJY7iudiXo9QS4vS6ICzsHwmhXzn7Z+/1cQ
# 6PKDx7ceTcZ8eHzuVqXtTCHoWgwtwVuqQLJcqIoXYHeiWMy/UzfNpXGquHaCoK/U
# eDEJ3s5FbHFhNhESx9R3UdwePoAZ3VDOsbxC7CucRvrC/OejXxawMXJH1FhFTT5m
# sGjurH9KkeChS7Q+MYIB1TCCAdECAQEwNDAgMR4wHAYDVQQDDBVkcGZscjA3MTRA
# aG90bWFpbC5jb20CEDGu8iAAPKiPSIvNbPWBeUAwCQYFKw4DAhoFAKB4MBgGCisG
# AQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFN1r
# wAYHMSH9wWu3A5PcyNudh8vEMA0GCSqGSIb3DQEBAQUABIIBADaaPMN/epYEbUTi
# 4Lh2CwFzU8xMxyIG2v0g9Bnxa5HcM0KJmgpRpSWF8e17tAgQNvkKTbHtBOB/tSQ7
# GbnR0SGk6OPEbvYmqLWp/Ixhcx/xPGzKUqfwcDCs/GkP0h0gJdQ86nh9NZ3FMhKk
# xbzFRxVIn3JtO7oWzJ7tFHF9hfMnat1i8aBaKXPDPb15t+U1zx46umY2nfWbZgPJ
# FSQ3+S9eSca9tyGRGq6zkNLUQWHKOFuW2sPyZ5Fg2HhSNMUUOoP3e0oUp13+v3AI
# Jp5KMJDAcQyvFRGV4tLMiQQAzDOa00HxtPtMRwdtXu19fsCUYSx+bIHkk9aglafc
# AvnHtGE=
# SIG # End signature block
