###########
# IMPORTS #
###########


"$PSScriptRoot\*" | gci -include '*.psm1' | Import-Module


######################
# SCRIPT STARTS HERE #
######################


# Elevate the script to administrator priveleges
# ----------------------------------------------
Invoke-AdminPrivileges


# ========================= #
# Windows specific settings #
# ========================= #


# Ask for computer name and change computer name
# ----------------------------------------------
Write-Title "Change computer name"
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName


# Disable standby and change monitor timeout to 60 seconds
# --------------------------------------------------------
Write-Title "Disabling standby-timeout for further installation"
Edit-Timeout


# Disable user account control notifications (open applications in admin mode without prompt)
# -------------------------------------------------------------------------------------------
Write-Title "Disabling user account control notifications"
Edit-RegistryValue "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" "ConsentPromptBehaviorAdmin" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "PromptOnSecureDesktop" 0


# Disable Telemetry
# -----------------
Write-Title "Disabling Windows telemetry"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" "AllowTelemetry" 0


# Disable user activity tracking
# ------------------------------
Write-Title "Disabling user activity tracking"
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "EnableActivityFeed" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "PublishUserActivities" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" "UploadUserActivities" 0


# Disable Bing search in start menu
# ---------------------------------
Write-Title "Disabling Bing search in start menu"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0


# Remove people icon from taskbar
# -------------------------------
Write-Title "Removing people icon from taskbar"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" "PeopleBand" 0


# Disable Advertising ID
# ----------------------
Write-Title "Disabling Advertising ID"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0


# Disable Windows GameDVR
# -----------------------
Write-Title "Disabling Windows GameDVR"
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" "AllowGameDVR" 0
Edit-RegistryValue "HKCU:\System\GameConfigStore" "GameDVR_Enabled" 0
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" "AppCaptureEnabled" 0


# Disable Windows Update Automatic restart
# ----------------------------------------
Write-Title "Disabling Window Update Automatic restart"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" "UxOption" 1
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "NoAutoRebootWithLoggedOnUsers" 1
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" "AUPowerManagement" 0


# Disable Windows update network seeding
# --------------------------------------
Write-Title "Disabling seeding of updates to other computers via Group Policies"
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" "DODownloadMode" 0


# Disable Edge desktop shortcut on new profiles
# ---------------------------------------------
Write-Title "Disable Edge desktop shortcut on new profiles"
Edit-RegistryValue "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer" "DisableEdgeDesktopShortcutCreation" 1


# Remove edge shortcut from desktop
# ---------------------------------
Write-Title "Removing Edge Desktop Icon"
$edgeLink = $env:USERPROFILE + "\Desktop\Microsoft Edge.lnk"
Remove-Item $edgeLink -ErrorAction Ignore


# Restore old volume slider with application volume control
# ---------------------------------------------------------
Write-Title "Restoring old volume slider"
Edit-RegistryValue "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\MTCUVC" "EnableMtcUvc" 0


# Change Windows explorer options
# -------------------------------
Write-Title "Setting Windows explorer options"
# Show hidden files
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1
# Never hide extensions
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0
# Default explorer view to This PC
Edit-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "LaunchTo" 1
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
# Remove 3D Objects from This PC
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
Remove-Item "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
# Disable Quick Access: Recent Files
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "ShowRecent" 0
# Disable Quick Access: Frequent Folders
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "ShowFrequent" 0


# Enable mapped drive sharing between users
# -----------------------------------------
Write-Title "Enabling sharing mapped drives between users"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" "EnableLinkedConnections" 1


# Set current network profile to private (allow file sharing, device discovery, etc.)
# -----------------------------------------------------------------------------------
Write-Title "Setting current network profile to private"
Set-NetConnectionProfile -NetworkCategory Private


# Change Windows to Dark Theme
# ----------------------------
Write-Title "Setting Windows Dark Theme"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0


# Enable Remote Desktop w/o Network Level Authentication
# ------------------------------------------------------
Write-Title "Enabling Remote Desktop w/o Network Level Authentication"
Edit-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" "fDenyTSConnections" 0
Edit-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" "UserAuthentication" 0
Enable-NetFirewallRule -Name "RemoteDesktop*"


# Disable Hibernation
# -------------------
# Write-Title "Disabling Hibernation"
# Edit-RegistryValue "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" "HibernteEnabled" 0
# Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" "ShowHibernateOption" 0


# Hide search box/icon from task bar
# ---------------------------------
Write-Title "Hiding Taskbar Search icon/box"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0


# Hide Task View button
# ---------------------
Write-Title "Hiding Task View button"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0


# Show small icons in taskbar
# ---------------------------
Write-Title "Setting taskbar icons to small"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarSmallIcons" 1


# Set taskbar buttons to show labels and never combine
# ----------------------------------------------------
Write-Title "Setting taskbar buttons to never combine"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarGlomLevel" 2


# Show all tray icons
# -------------------
Write-Title "Showing all tray icons"
Edit-RegistryValue "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" "EnableAutoTray" 0


# Disable search for app in store for unknown extensions
# ------------------------------------------------------
Write-Title "Disabling search for app in store for unknown extensions"
Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" "NoUseStoreOpenWith" 1


# Enable NumLock after startup
# ----------------------------
Write-Title "Enabling NumLock after startup"
If (!(Test-Path "HKU:")) {
	New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
}
Edit-RegistryValue "HKU:\.DEFAULT\Control Panel\Keyboard" "InitialKeyboardIndicators" 2147483650
Add-Type -AssemblyName System.Windows.Forms
If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
	$wsh = New-Object -ComObject WScript.Shell
	$wsh.SendKeys('{NUMLOCK}')
}


# Disable offering of drivers through Windows Update
# --------------------------------------------------
# Note: This doesn't work properly if you use a driver intended for another hardware model. E.g. Intel I219-V on WinServer works only with I219-LM driver.
# Therefore Windows update will repeatedly try and fail to install I219-V driver indefinitely even if you use the tweak.
# Write-Title "Disabling driver offering through Windows Update"
# Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" "PreventDeviceMetadataFromNetwork" 1
# Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" "SearchOrderConfig" 
# Edit-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "ExcludeWUDriversInQualityUpdate" 1


# Enable NTFS paths with length over 260 characters
# -------------------------------------------------
Write-Title "Enabling NTFS paths with length over 260 characters"
Edit-RegistryValue "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1


# Disable adding '- shortcut' to shortcut name
# --------------------------------------------
Write-Title "Disabling adding '- shortcut' to shortcut name"
Edit-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" "link" -Type Binary -Value ([byte[]](0,0,0,0))


# Hide shortcut icon arrow
# ------------------------
Write-Title "Hiding shortcut icon arrow"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" "29" -Type String -Value "%SystemRoot%\System32\imageres.dll,-1015"


# Adjusts visual effects for performance
# --------------------------------------
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


# Show full directory path in Explorer title bar
# ----------------------------------------------
Write-Title "Showing full directory path in Explorer title bar"
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Type DWord -Value 1


# Show protected operating system files
# -------------------------------------
Write-Title "Showing protected operating system files..."
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Type DWord -Value 1


# Disable Edge preload after Windows startup (non-chromium)
# ---------------------------------------------------------
Write-Title "Disabling Edge preload..."
Edit-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "AllowPrelaunch" -Type DWord -Value 0
Edit-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" -Name "AllowTabPreloading" -Type DWord -Value 0


# Uninstall Microsoft XPS Document Writer
# ---------------------------------------
Write-Title "Uninstalling Microsoft XPS Document Writer..."
Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -eq "Printing-XPSServices-Features" } | Disable-WindowsOptionalFeature -Online -NoRestart -WarningAction SilentlyContinue | Out-Null


# =================== #
# Application removal #
# =================== #

    
# Remove unnecessary UWP apps
# ---------------------------
# To list all appx packages:
# Get-AppxPackage | Format-Table -Property Name,Version,PackageFullName
Write-Title "Removing UWP Rubbish"
$uwpRubbishApps = @(
    "2414FC7A.Viber",
    "41038Axilesoft.ACGMediaPlayer",
    "46928bounde.EclipseManager",
    "4DF9E0F8.Netflix",
    "64885BlueEdge.OneCalendar",
    "7EE7776C.LinkedInforWindows",
    "828B5831.HiddenCityMysteryofShadows",
    "89006A2E.AutodeskSketchBook",
    "9E2F88E3.Twitter",
    "A278AB0D.DisneyMagicKingdoms",
    "A278AB0D.DragonManiaLegends",
    "A278AB0D.MarchofEmpires",
    "ActiproSoftwareLLC.562882FEEB491",
    "AD2F1837.GettingStartedwithWindows8",
    "AD2F1837.HPJumpStart",
    "AD2F1837.HPRegistration",
    "AdobeSystemsIncorporated.AdobePhotoshopExpress",
    "Amazon.com.Amazon",
    "C27EB4BA.DropboxOEM",
    "CAF9E577.Plex",
    "CyberLinkCorp.hs.PowerMediaPlayer14forHPConsumerPC",
    "D52A8D61.FarmVille2CountryEscape",
    "D5EA27B7.Duolingo-LearnLanguagesforFree",
    "DB6EA5DB.CyberLinkMediaSuiteEssentials",
    "DolbyLaboratories.DolbyAccess",
    "Drawboard.DrawboardPDF",
    "Facebook.Facebook",
    "Fitbit.FitbitCoach",
    "flaregamesGmbH.RoyalRevolt2",
    "GAMELOFTSA.Asphalt8Airborne",
    "KeeperSecurityInc.Keeper",
    "king.com.BubbleWitch3Saga",
    "king.com.CandyCrushFriends",
    "king.com.CandyCrushSaga",
    "king.com.CandyCrushSodaSaga",
    "king.com.FarmHeroesSaga",
    "Nordcurrent.CookingFever",
    "PandoraMediaInc.29680B314EFC2",
    "PricelinePartnerNetwork.Booking.comBigsavingsonhot",
    "ThumbmunkeysLtd.PhototasticCollage",
    "WinZipComputing.WinZipUniversal",
    "XINGAG.XING",
    "Microsoft.BingFinance",
    "Microsoft.BingFoodAndDrink",
    "Microsoft.BingHealthAndFitness",
    "Microsoft.BingMaps",
    "Microsoft.BingNews",
    "Microsoft.BingSports",
    "Microsoft.BingTranslator",
    "Microsoft.BingTravel",
    "Microsoft.CommsPhone",
    "Microsoft.ConnectivityStore",
    "Microsoft.FreshPaint",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.HelpAndTips",
    "Microsoft.Messaging",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.MicrosoftPowerBIForWindows",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.MinecraftUWP",
    "Microsoft.MoCamera",
    "Microsoft.NetworkSpeedTest",
    "Microsoft.Office.Sway",
    "Microsoft.People",
    "Microsoft.SkypeApp",
    "Microsoft.Wallet",
    "Microsoft.WindowsCamera",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsPhone",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo"
)

foreach ($uwp in $uwpRubbishApps) {
    Get-AppxPackage -Name $uwp | Remove-AppxPackage
    Write-Host "Removing $uwp"
}


# Enable Windows 10 Developer mode
# --------------------------------
Write-Title "Enabling Windows 10 Developer Mode"
Edit-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" "AllowDevelopmentWithoutDevLicense" 1


# Install Chocolatey
# ------------------
if (Find-Command -cmdname 'choco') {
    Write-Host "Choco is already installed, skip installation."
}
else {
    Write-Title "Installing Chocolate for Windows..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}


# Install applications through chocolatey
# ---------------------------------------
$ChocoPackages = @(
    "cuda",
    "git",
    "nodejs",
    "adobereader",
    "googlechrome",
    "jre8",
    "firefox",
    "7zip.install",
    "notepadplusplus.install",
    "wget",
    "openssl.light",
    "fiddler",
    "microsoft-teams.install",
    "microsoft-edge",
    "powertoys",
    "k-litecodecpackmega",
    "mobaxterm",
    "sharex",
    "slack",
    "sourcetree",
    "postman",
    "docker-desktop",
    "totalcommander",
    "whatsapp",
    "prusaslicer",
    "rufus",
    "sysinternals",
    "dotnetcore-sdk",
    "dotnetcore",
    "netfx-4.8-devpack",
    "netfx-4.8",
    "sql-server-management-studio",
    "visualstudio2019enterprise",
    #"visualstudio2019professional",
    "jetbrainstoolbox",
    "anaconda3",
    "vscode",
    "typescript",
    "microsoft-windows-terminal",
    "blender",
    "obs-studio",
    "obs-virtualcam",
    "eid-belgium",
    "lastpass",
    "sudo"
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


# Install Windows features
# ------------------------
$WindowsFeatures = @(
    "IIS-ODBCLogging",
    "IIS-IISCertificateMappingAuthentication",
    "IIS-ClientCertificateMappingAuthentication",
    "IIS-DigestAuthentication",
    "HypervisorPlatform",
    "Containers",
    "Microsoft-Hyper-V-Management-Clients",
    "Microsoft-Hyper-V-Services",
    "Microsoft-Hyper-V-Hypervisor",
    "Microsoft-Hyper-V-Management-PowerShell",
    "Microsoft-Hyper-V-Tools-All",
    "Microsoft-Hyper-V",
    "Microsoft-Hyper-V-All",
    "Containers-DisposableClientVM",
    "IIS-RequestMonitor",
    "IIS-HttpTracing",
    "IIS-URLAuthorization",
    "IIS-IPSecurity",
    "IIS-LegacySnapIn",
    "IIS-LegacyScripts",
    "IIS-WMICompatibility",
    "IIS-CustomLogging",
    "IIS-CGI",
    "IIS-ASP",
    "IIS-ASPNET",
    "IIS-WebDAV",
    "IIS-FTPSvc",
    "IIS-HostableWebCore",
    "IIS-Metabase",
    "IIS-IIS6ManagementCompatibility",
    "IIS-ManagementScriptingTools",
    "IIS-DefaultDocument",
    "IIS-DirectoryBrowsing",
    "IIS-WebSockets",
    "IIS-ApplicationInit",
    "IIS-ASPNET45",
    "IIS-ISAPIExtensions",
    "IIS-ISAPIFilter",
    "IIS-ServerSideIncludes",
    "IIS-BasicAuthentication",
    "IIS-StaticContent",
    "IIS-HttpCompressionStatic",
    "IIS-ManagementService",
    "IIS-CertProvider",
    "IIS-WindowsAuthentication",
    "MediaPlayback",
    "SmbDirect",
    "IIS-ManagementConsole",
    "Microsoft-Windows-Subsystem-Linux",
    "IIS-WebServerManagementTools",
    "IIS-Performance",
    "MSRDC-Infrastructure",
    "NetFx4-AdvSrvs",
    "NetFx4Extended-ASPNET45",
    "WCF-Services45",
    "IIS-HttpCompressionDynamic",
    "WCF-TCP-PortSharing45",
    "IIS-WebServer",
    "IIS-CommonHttpFeatures",
    "IIS-HttpErrors",
    "IIS-ApplicationDevelopment",
    "IIS-NetFxExtensibility45",
    "IIS-HealthAndDiagnostics",
    "IIS-HttpLogging",
    "IIS-Security",
    "IIS-RequestFiltering",
    "IIS-WebServerRole",
    "VirtualMachinePlatform"
)

Write-Title "Installing Windows features"
foreach ($WindowsFeature in $WindowsFeatures) {
    Install-Feature $WindowsFeature
}


# Install Azure CLI
# -----------------
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
Remove-Item .\AzureCLI.msi


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


# Update Powershell
# -----------------
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/PowerShell-7.0.3-win-x64.msi -OutFile .\PS7.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I PS7.msi /quiet'
Remove-Item .\PS7.msi


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

# Unpin all Taskbar icons
# -----------------------
Write-Title "Unpinning all Taskbar icons..."
Edit-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "Favorites" -Type Binary -Value ([byte[]](255))
Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Name "FavoritesResolve" -ErrorAction SilentlyContinue


##########
# FINISH #
##########


# Reboot computer after installation
# ----------------------------------
Write-Host "Setup is done, restart is needed"
Wait-ForKey
Restart-Computer