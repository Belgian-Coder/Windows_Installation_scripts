###########
# IMPORTS #
###########


"$PSScriptRoot\..\Modules\*" | Get-ChildItem -include '*.psm1' | Import-Module


######################
# SCRIPT STARTS HERE #
######################


# Elevate the script to administrator priveleges
# ----------------------------------------------
Invoke-AdminPrivileges


# ========================= #
# Windows specific settings #
# ========================= #


# Change Windows explorer options
# -------------------------------
Write-Title "Setting Windows explorer options"
# Remove Music from This PC
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}"
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}"
# Remove Videos from This PC
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}"
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}"


# Enable mapped drive sharing between users
# -----------------------------------------
Write-Title "Enabling sharing mapped drives between users"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLinkedConnections" 1


# Set current network profile to private (allow file sharing, device discovery, etc.)
# -----------------------------------------------------------------------------------
Write-Title "Setting current network profile to private"
Set-NetConnectionProfile -NetworkCategory Private


# Enable Remote Desktop w/o Network Level Authentication
# ------------------------------------------------------
Write-Title "Enabling Remote Desktop w/o Network Level Authentication"
Edit-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections" 0
Edit-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" "UserAuthentication" 0
Enable-NetFirewallRule -Name "RemoteDesktop*"


# Show small icons in taskbar
# ---------------------------
Write-Title "Setting taskbar icons to small"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSmallIcons" 1


# Set small taskbar
# -----------------
Write-Title "Setting taskbar to small"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSi" 0


# Set taskbar buttons to show labels and never combine
# ----------------------------------------------------
Write-Title "Setting taskbar buttons to never combine"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarGlomLevel" 2


# Always show all tray icons
# --------------------------
Write-Title "Showing all tray icons"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "EnableAutoTray" 0


# Disable search for app in store for unknown extensions
# ------------------------------------------------------
Write-Title "Disabling search for app in store for unknown extensions"
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoUseStoreOpenWith" 1


# Hide shortcut icon arrow
# ------------------------
Write-Title "Hiding shortcut icon arrow"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" "29" -Type String -Value "%SystemRoot%\System32\imageres.dll,-1015"


# Adjust visual effects for performance
# -------------------------------------
Write-Title "Adjusting visual effects for performance"
# Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop" -Name "DragFullWindows" -Type String -Value 0
Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Type String -Value 0
Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](144,18,3,128,16,0,0,0))
Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Type String -Value 0
Edit-RegistryValue -Path "HKCU:\Control Panel\Keyboard" -Name "KeyboardDelay" -Type DWord -Value 0
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Type DWord -Value 0
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Type DWord -Value 0
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Type DWord -Value 0
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Type DWord -Value 3
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Type DWord -Value 0


# Change mouse cursor to show circle when ctrl pressed
# ----------------------------------------------------
Write-Title "Enabling find my pointer"
Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](0x9E,0x5E,0x07,0x80,0x12,0x00,0x00,0x00))


# Show full directory path in Explorer title bar
# ----------------------------------------------
Write-Title "Showing full directory path in Explorer title bar"
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1


# Show protected operating system files
# -------------------------------------
Write-Title "Showing protected operating system files..."
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1


# Uninstall Microsoft XPS Document Writer
# ---------------------------------------
Write-Title "Uninstalling Microsoft XPS Document Writer..."
Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq "Printing-XPSServices-Features" } | Disable-WindowsOptionalFeature -Online -NoRestart -WarningAction SilentlyContinue | Out-Null
  

# Enable Windows Developer mode
# --------------------------------
Write-Title "Enabling Windows Developer Mode"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1


# Install Chocolatey
# ------------------
if (Find-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation."
}
else {
    Write-Title "Installing Chocolate for Windows..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
# Enable automatic EULA acceptance for installing packages
choco feature enable -n allowGlobalConfirmation

# Install applications through chocolatey
# ---------------------------------------
$ChocoPackages = @(
    "7zip.install",
    "adobereader",
    "anaconda3",
    "azure-cli",
    "azure-data-studio",
    "cuda",
    "docker-desktop",
    "eid-belgium",
    "fiddler",
    "fontbase",
    "geforce-game-ready-driver",
    "git",
    "googlechrome",
    "jmeter",
    "jre8",
    "k-litecodecpackmega",
    "lastpass",
    "microsoftazurestorageexplorer",
    "mobaxterm",
    "notepadplusplus.install",
    "nvm.portable",
    "obs-move-transition",
    "obs-studio",
    "obs-virtualcam",
    "openssl.light",
    "postman",
    "powertoys",
    "rufus",
    "sharex",
    "sourcetree",
    "spotify",
    "sql-server-management-studio",
    "totalcommander",
    "typescript",
    "visualstudio2019enterprise",
    "vscode",
    "wget",
    "nswagstudio",
    "p4merge",
    "powershell",
    "whatsapp"
)


Write-Title "Installing Applications"
foreach ($ChocoPackage in $ChocoPackages) {
    Install-ChocoPackage $ChocoPackage
}


# Create daily task to update chocolatey packages
# -----------------------------------------------
# Write-Title "Creating daily task to automatically upgrade Chocolatey packages"
# $ScheduledJob = @{
#     Name = "Chocolatey Daily Upgrade"
#     ScriptBlock = {choco upgrade all -y}
#     Trigger = New-JobTrigger -Daily -at 7pm
#     ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork
# }
# Register-ScheduledJob @ScheduledJob


# Install Linux Subsystem
# -----------------------
Write-Title "Installing Linux Subsystem"
If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
	# 1607 needs developer mode to be enabled
	Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1
	Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowAllTrustedApps" 1
}
Install-Feature "Microsoft-Windows-Subsystem-Linux"
Install-Feature "VirtualMachinePlatform"


# ======== #
# Clean up #
# ======== #


# Remove Desktop icons
# --------------------
Write-Title "Remove desktop icons"
Get-ChildItem $env:USERPROFILE\Desktop\*.lnk|ForEach-Object { Remove-Item $_ } -ErrorAction Ignore
Get-ChildItem $env:Public\Desktop\*.lnk | ForEach-Object { Remove-Item $_ } -ErrorAction Ignore


# Unpin all Start Menu tiles
# --------------------------
Write-Title "Unpinning all Start Menu tiles"
If ([System.Environment]::OSVersion.Version.Build -ge 15063 -And [System.Environment]::OSVersion.Version.Build -le 16299) {
	Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount" -Include "*.group" -Recurse | ForEach-Object {
		$data = (Get-ItemProperty -Path "$($_.PsPath)\Current" -Name "Data").Data -Join ","
		$data = $data.Substring(0, $data.IndexOf(",0,202,30") + 9) + ",0,202,80,0,0"
		Edit-RegistryValue -Path "$($_.PsPath)\Current" -Name "Data" -Type Binary -Value $data.Split(",")
	}
} ElseIf ([System.Environment]::OSVersion.Version.Build -ge 17134) {
	$key = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*start.tilegrid`$windows.data.curatedtilecollection.tilecollection\Current"
	$data = $key.Data[0..25] + ([byte[]](202,50,0,226,44,1,1,0,0))
	Edit-RegistryValue -Path $key.PSPath -Name "Data" -Type Binary -Value $data
	Stop-Process -Name "ShellExperienceHost" -Force -ErrorAction SilentlyContinue
}

##########
# FINISH #
##########


# Reboot computer after installation
# ----------------------------------
Write-Host "Setup is done, restart is needed"
Wait-ForKey
Restart-Computer