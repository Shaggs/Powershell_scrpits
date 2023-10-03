# Connect to Exchange Online (Office 365)
Connect-ExchangeOnline -UserPrincipalName admin@contoso.com -ShowProgress $true
# Replace 'username' with the actual username of the user you want to manage
$username = "username"
# Get a list of all groups the user is a member of
$groups = Get-DistributionGroup | Where-Object { (Get-DistributionGroupMember $_.Identity).PrimarySmtpAddress -contains $username }
# Remove the user from each group
foreach ($group in $groups) {
    Remove-DistributionGroupMember -Identity $group.Identity -Member $username -Confirm:$false
}
# Convert the user's mailbox to a shared mailbox
Set-Mail -Identity $username -Type Shared

# Connect to Azure Active Directory (Azure AD)
Connect-AzureAD -TenantId yourtenant.onmicrosoft.com

# Disable the user account
Set-AzureADUser -ObjectId (Get-AzureADUser -Filter "userPrincipalName eq '$username'").ObjectId -AccountEnabled $false
