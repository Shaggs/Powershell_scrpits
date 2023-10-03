#simple script to allow muliple users to edit a calendar

$UserCredential = Get-Credential
Connect-ExchangeOnline -UserPrincipalName <YourAdminAccount> -ShowProgress $true -DelegatedOrganization <YourOrganizationName> -Credential $UserCredential
$CalendrOwner = "JohnDoe"
$UsersToShareWith = @("User1", "User2", "User3")
$AccessRighs = "Editor"  

# Loop through the list and grant calendar permissions
foreach ($UserToShareWith in $UsersToShareWith) {
    Add-MailboxFolerPermission -Identity "$CalendarOwner:\Calendar" -User "$UserToShareWith" -AccessRights $AccessRights
    Write-Host "Permission granted: $UserToShareWith can access $CalendarOwner's calendar with $AccessRights access."
}
Disconnect-ExchangeOnline -Confirm:$false
