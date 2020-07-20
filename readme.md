Execute all commands below in Powershell, opened in administrator mode.
The scripts for installation will automatically try to elevate themself to administrator mode.


// Check your current execution policies
Get-ExecutionPolicy -List

// Set policies to unrestricted before running the script
Set-ExecutionPolicy unrestricted

// Change execution policies back or use remote signed
Set-ExecutionPolicy RemoteSigned