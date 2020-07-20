##################
# FUNCTIONS HERE #
##################


# Print text as title
# -------------------
Function Write-Title([string] $Title) {
    Write-Host ""
    $TitleLength = $Title.Length
    $TitleLine = "";
    For ($i=1; $i -le $TitleLength; $i++) {
        $TitleLine += "-"
    }
    Write-Host $TitleLine -ForegroundColor Green
    Write-Host $Title -ForegroundColor Green
    Write-Host $TitleLine -ForegroundColor Green
}


# Used for checking if a command is available
# -------------------------------------------
Function Find-Command([string] $CmdName) {
    return [bool](Get-Command -Name $CmdName -ErrorAction SilentlyContinue)
}


# Install chocolatey package
# --------------------------
Function Install-ChocoPackage([string] $ChocoPackageName) {
    Write-Title "Start installing $ChocoPackageName"
    # using upgrade will install or upgrade depending on current state
    choco upgrade $ChocoPackageName -y
}


# Change registry value
# ---------------------
Function Edit-RegistryValue([string] $Path, [string] $Name, $Value, $Type) {
    If (-not(Test-Path $Path)) {
        New-item -Path $Path -Force -ErrorAction SilentlyContinue | Out-Null
    }
    if($Type -eq $null) {
        $Type = "DWord"
    }
    Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -Force -ErrorAction SilentlyContinue
}


# Change standby and change monitor timeout
# -----------------------------------------
Function Edit-Timeout() {
    Write-Title "Disabling standby-timeout for further installation"
    # Settings when plugged in
    Powercfg /Change monitor-timeout-ac 60
    Powercfg /Change standby-timeout-ac 0
    # Settings when on battery
    Powercfg /Change monitor-timeout-dc 60
    Powercfg /Change standby-timeout-dc 0
}


# Install Windows feature
# -----------------------
Function Install-Feature ([string] $FeatureName) {
    Write-Title "Start installing $FeatureName"
    Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName -All -NoRestart -warningAction SilentlyContinue | Out-Null
}


# Wait for key press
# ------------------
Function Wait-ForKey {
	Write-Output "`nPress any key to continue..."
	[Console]::ReadKey($true) | Out-Null
}


# Set application to run in administrator mode
# --------------------------------------------
Function Set-AdminMode([string] $ApplicationPath) {
    $ApplicationPath = $ApplicationPath.Replace('"','')
    Edit-RegistryValue 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' $ApplicationPath '^ RUNASADMIN' 'string'
    Edit-RegistryValue 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' $ApplicationPath '^ RUNASADMIN' 'string'
}


# Elevate the script to administrator priveleges
# ----------------------------------------------
Function Invoke-AdminPrivileges() {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit 
    }
}