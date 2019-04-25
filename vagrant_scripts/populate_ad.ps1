


Write-Host "Creating Jenni's Account..."
New-ADUser -Name "Books" -GivenName Jennifer `
     -SamAccountName jennifer.books -UserPrincipalName jennifer.books@seclabs.lab `
     -AccountPassword (ConvertTo-SecureString "P$$rmonth78" -asplaintext -force) `
     -PassThru | Enable-ADAccount
