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


##############
# EXTENSIONS #
##############


# Install VS Code extensions
# --------------------------
$extensions = @(
    #.NET Core extension pack
    "doggy8088.netcore-extension-pack",
    # Angular extension pack
    "doggy8088.angular-extension-pack",
    # Azure account management
    "ms-vscode.azure-account",
    # AKS extension for debugging microservices
    "azuredevspaces.azds",
    # Azure kubernetes service
    "ms-kubernetes-tools.vscode-aks-tools",
    # Azure tools extension pack
    "ms-vscode.vscode-node-azure-pack",
    # C#
    "ms-dotnettools.csharp",
    # C# extensions (refactorings)
    "jchannon.csharpextensions",
    # Chrome debugger
    "msjsdiag.debugger-for-chrome",
    # Convert csharp to typescript
    "adrianwilczynski.csharp-to-typescript",
    # Colorize comments
    "aaron-bond.better-comments",
    # Colorize brackets
    "coenraads.bracket-pair-colorizer-2",
    # CSS peek
    "pranaygp.vscode-css-peek",
    # Docker extension pack
    "formulahendry.docker-extension-pack",
    # Draw.io integration
    "hediet.vscode-drawio",
    # Excel viewer, opens Excel and CSV files as a table
    "grapecity.gc-excelviewer",
    # Firefox debugger
    "firefox-devtools.vscode-firefox-debug",
    # GitLens
    "eamodio.gitlens",
    # Import cost, shows size of imports for JS and TS
    "wix.vscode-import-cost",
    # JSON to TS
    "mariusalchimavicius.json-to-ts",
    # Kubernetes extension
    "ms-kubernetes-tools.vscode-kubernetes-tools",
    # Kubernetes pod file system explorer
    "sandipchitale.kubernetes-file-system-explorer",
    # Kubernetes template snippets
    "ipedrazas.kubernetes-snippets",
    # Live server
    "ritwickdey.liveserver",
    # Live share extension pack
    "MS-vsliveshare.vsliveshare-pack",
    # Microsoft Edge debugger
    "msjsdiag.debugger-for-edge",
    # Move TS, add move functionality that updates imports
    "stringham.move-ts",
    # NPM extension
    "eg2.vscode-npm-script",
    # Paste JSON as Code
    "quicktype.quicktype",
    # Powershell scripting extension
    "ms-vscode.powershell",
    # Prettier code formatter
    "esbenp.prettier-vscode",
    # Project manager
    "alefragnani.project-manager",
    # Python extension
    "ms-python.python",
    # Remote development pack
    "ms-vscode-remote.vscode-remote-extensionpack",
    # REST client
    "humao.rest-client",
    # Settings sync, save VS code settings to github
    "shan.code-settings-sync",
    # SQL server extension
    "ms-mssql.mssql",
    # Typescript extension pack
    "loiane.ts-extension-pack",
    # Visual studio codespaces
    "ms-vsonline.vsonline",
    # Visual Studio intellicode
    "visualstudioexptteam.vscodeintellicode",
    # XML tools
    "dotjoshjohnson.xml",
    # YAML support
    "redhat.vscode-yaml"
)

Write-Title "Installing VS Code extensions"
$cmd = "code --list-extensions"
Invoke-Expression $cmd -OutVariable output | Out-Null
$installed = $output -split "\s"

foreach ($ext in $extensions) {
    if ($installed.Contains($ext)) {
        Write-Host $ext "already installed." -ForegroundColor Gray
    } else {
        Write-Host "Installing" $ext "..." -ForegroundColor White
        code --install-extension $ext
    }
}


#################
# CONFIGURATION #
#################


# WSL Kernel update and configuration
# -----------------------------------
Write-Title "Updating and configuring WSL"
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile .\wsl_kernel_update.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I wsl_kernel_update.msi /quiet'
Remove-Item .\wsl_kernel_update.msi
# Set WSL2 as default
wsl --set-default-version 2
# TODO: install UBUNTU and set as default
# Do not use Alpine due to incompatibility with glibc dependencies
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile "$PSScriptRoot\Ubuntu.appx" -UseBasicParsing
Add-AppxPackage "$PSScriptRoot\Ubuntu.appx"
Remove-Item 
wsl --set-default ubuntu-20.04 2
# NOTE: could be you need to start Ubuntu manually before setting to default!


# Set Visual Studio to automatically open in admin mode
# -----------------------------------------------------
Write-Title "Setting Visual Studio to automatically open in admin mode"
$visualStudioDir = Get-ItemPropertyValue -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\devenv.exe" -Name "(Default)"
Set-AdminMode $visualStudioDir


# Set Visual Studio Code to automatically open in admin mode
# ----------------------------------------------------------
Write-Title "Setting Visual Studio Code to automatically open in admin mode"
$visualStudioCodeDir = get-childitem -recurse HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall | 
  get-itemproperty | where { $_  -match 'code.exe' } | Get-ItemPropertyValue -name displayicon
Set-AdminMode $visualStudioCodeDir


# Set Total Commander to automatically open in admin mode
# -------------------------------------------------------
Write-Title "Setting Total Commander to automatically open in admin mode"
$totalComanderDir = Get-ItemPropertyValue -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\tc.exe" -Name "(Default)"
Set-AdminMode $totalComanderDir


# Change mouse cursor to show circle when ctrl pressed
# ----------------------------------------------------
Write-Title "Enabling find my pointer"
Edit-RegistryValue -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Type Binary -Value ([byte[]](0x9E,0x5E,0x07,0x80,0x12,0x00,0x00,0x00))


# Windows Defender Exclusions
# ---------------------------

$userPath = $env:USERPROFILE

$pathExclusions = @(
    # Default installation paths
    'C:\Windows\Microsoft.NET',
    'C:\Windows\assembly',
    'C:\Program Files\dotnet',
    'C:\ProgramData\Microsoft\VisualStudio\Packages',
    'C:\Program Files (x86)\Microsoft SDKs\NuGetPackages',
    'C:\Program Files (x86)\MSBuild',
    'C:\Program Files (x86)\Microsoft Visual Studio',
    'C:\Program Files (x86)\Microsoft Visual Studio Tools for Unity',
    'C:\Program Files\Microsoft VS Code',
    'C:\Program Files (x86)\Microsoft SDKs',
    'C:\Program Files (x86)\Windows Kits',
    'C:\Program Files\Docker',

    # User profile paths
    "$userPath\AppData\Roaming\npm",
    "$userPath\AppData\Roaming\npm-cache",
    "$userPath\AppData\Local\Microsoft\VisualStudio",
    "$userPath\AppData\Local\JetBrains\Transient",
    "$env:ProgramData\Docker",
    "$env:ProgramData\DockerDesktop",

    # Project paths
    'C:\_sync',
    'C:\_projects'
)

$processExclusions = @(
    # Visual Studio
    'vshost-clr2.exe',
    'VSInitializer.exe',
    'VSIXInstaller.exe',
    'VSLaunchBrowser.exe',
    'vsn.exe',
    'VsRegEdit.exe',
    'VSWebHandler.exe',
    'VSWebLauncher.exe',
    'XDesProc.exe',
    'Blend.exe',
    'CodeCoverage.exe',
    'DDConfigCA.exe',
    'devenv.exe',
    'FeedbackCollector.exe',
    'IntelliTrace.exe',
    'Microsoft.VisualStudio.Web.Host.exe',
    'mspdbsrv.exe',
    'MSTest.exe',
    'PerfWatson2.exe',
    'Publicize.exe',
    'QTAgent.exe',
    'QTAgent_35.exe',
    'QTAgent_40.exe',
    'QTAgent32.exe',
    'QTAgent32_35.exe',
    'QTAgent32_40.exe',
    'QTDCAgent.exe',
    'QTDCAgent32.exe',
    'StorePID.exe',
    'T4VSHostProcess.exe',
    'TailoredDeploy.exe',
    'TCM.exe',
    'testhost.exe',
    'TextTransform.exe',
    'TfsLabConfig.exe',
    'UserControlTestContainer.exe',
    'vb7to8.exe',
    'VcxprojReader.exe',
    'VsDebugWERHelper.exe',
    'VSFinalizer.exe',
    'VsGa.exe',
    'VSHiveStub.exe',
    'vshost.exe',
    'vshost32.exe',
    'vshost32-clr2.exe',
    'vbcscompiler.exe',

    # VS Code
    'Code.exe',

    # Runtimes, build tools
    'dotnet.exe',
    'mono.exe',
    'mono-sgen.exe',
    'java.exe',
    'java64.exe',
    'msbuild.exe',
    'node.exe',
    'node.js',
    'perfwatson2.exe',
    'ServiceHub.Host.Node.x86.exe',
    'vbcscompiler.exe',
    'nuget.exe',
    
    # VCS
    'git.exe',
    'sourcetree.exe',

    # Docker
    'Docker Desktop.exe',
    'DockerWatchguard.exe',
    'dockerd.exe',
    
    # Shells
    'git-bash.exe',
    'bash.exe',
    'powershell.exe',
    
    # All of JetBrains stuff
    'JetBrains.EntityFramework.Runner620.exe',
    'JetBrains.MsBuild.TaskEntryPoint.exe',
    'JetBrains.Platform.Satellite.exe',
    'JetBrains.ReSharper.Features.XamlPreview.External.exe',
    'JetBrains.ReSharper.Host.exe',
    'JetBrains.ReSharper.Host64.exe',
    'JetBrains.ReSharper.Roslyn.Worker.exe',
    'JetLauncher32.exe',
    'JetLauncher32c.exe',
    'JetLauncher64.exe',
    'JetLauncher64c.exe',
    'JetLauncherIL.exe',
    'JetLauncherILc.exe',
    'OperatorsResolveCacheGenerator.exe',
    'PsiGen.exe',
    'ReSharperTestRunner32.exe',
    'ReSharperTestRunner64.exe',
    'ReSharperTestRunnerIL.exe',
    'RiderClrProcessEnumerator32.exe',
    'RiderClrProcessEnumeratorIL.exe',
    'TokenGenerator.exe',
    'xamarin-component.exe',
    'ClrStack.x64.exe',
    'ClrStack.x86.exe',
    'CsLex.exe',
    'ErrorsGen.exe',
    'JetBrains.Debugger.Worker.exe',
    'JetBrains.Debugger.Worker32c.exe',
    'JetBrains.Debugger.Worker64c.exe',
    'dotPeek32.exe',
    'dotPeek64.exe',
    'DotTabWellScattered32.exe',
    'DotTabWellScattered64.exe',
    'DotTabWellScatteredIL.exe',
    'JetBrains.Platform.Installer.Bootstrap.exe',
    'JetBrains.Platform.Installer.Cleanup.exe',
    'JetBrains.Platform.Installer.exe',
    'CleanUpProfiler.x64.exe',
    'CleanUpProfiler.x86.exe',
    'Configuration2Xml32.exe',
    'Configuration2Xml64.exe',
    'ConsoleProfiler.exe',
    'dotTrace32.exe',
    'dotTrace64.exe',
    'DotTraceLauncher.exe',
    'dotTraceView32.exe',
    'dotTraceView64.exe',
    'JetBrains.Common.ElevationAgent.exe',
    'JetBrains.Common.ExternalStorage.exe',
    'JetBrains.Common.ExternalStorage.x86.exe',
    'JetBrains.dotTrace.IntegrationDemo.exe',
    'Reporter.exe',
    'SnapshotStat.exe',
    'Timeline32.exe',
    'Timeline64.exe',
    'dotMemory.UI.32.exe',
    'dotMemory.UI.64.exe',
    'dotMemoryUnit.exe',
    'JetBrains.dotMemory.Console.SingleExe.exe',
    'JetBrains.dotMemoryUnit.Server.exe',
    'restarter.exe',
    'rider64.exe',
    'runnerw.exe',
    'runnerw64.exe',
    'WinProcessListHelper.exe',
    'elevator.exe',
    'fsnotifier.exe',
    'fsnotifier64.exe',
    'launcher.exe',
    'NGen Rider Assemblies.exe',
    'idea.exe',
    'idea64.exe',
    'JetBrains.Etw.Collector.Host.exe',
    'webstorm64.exe',
    'datagrip64.exe',
    'clion64.exe',
    'goland64.exe',
    'phpstorm64.exe',
    'pycharm64.exe',
    'rubymine64.exe',
    'studio64.exe',
    
    # JB Toolbox
    'jetbrains-toolbox.exe',
    'jetbrains-toolbox-cef.exe',
    'jetbrains-toolbox-cef-helper.exe',
    
    # Unity
    'UnityHelper.exe',
    'Unity.exe',
    'UnityShaderCompiler.exe',
    'UnityYAMLMerge.exe',
    'UnityCrashHandler64.exe'
)

Write-Title 'Excluding paths from Windows Defender'
foreach ($exclusion in $pathExclusions) 
{
    Write-Host "Adding Path Exclusion: " $exclusion
    Add-MpPreference -ExclusionPath $exclusion
}

Write-Title 'Excluding processes from Windows Defender'
foreach ($exclusion in $processExclusions)
{
    Write-Host "Adding Process Exclusion: " $exclusion
    Add-MpPreference -ExclusionProcess $exclusion
}


# Windows Defender exclusions - WSL specific
# ------------------------------------------
# Source: https://gist.github.com/noelbundick/9c804a710eb76e1d6a234b14abf42a52
#
# MIT License
# 
# Copyright (c) 2018 Noel Bundick
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Write-Title 'Excluding WSL specific paths and processes from Windows Defender'

# Find registered WSL environments
$wslPaths = (Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss | ForEach-Object { Get-ItemProperty $_.PSPath}).BasePath

# List of paths inside the Linux distro to exclude (https://github.com/Microsoft/WSL/issues/1932#issuecomment-407855346)
$dirs = @("\bin", "\sbin", "\usr\bin", "\usr\sbin", "\usr\local\bin", "\usr\local\go\bin")

# Add the missing entries to Windows Defender
if ($wslPaths.Length -gt 0) {
  $wslPaths | ForEach-Object { 
    
    # Exclude paths from the root of the WSL install
    $_ = $_.Replace('\\?\','')
    Add-MpPreference -ExclusionPath $_
    Write-Output "Added exclusion for $_"

    # Exclude processes contained inside WSL
    $rootfs = $_ + "\rootfs"
    $dirs | ForEach-Object {
        $exclusion = $rootfs + $_ + "\*"
        Add-MpPreference -ExclusionProcess $exclusion
        Write-Output "Added exclusion for $exclusion"
    }
  }
}


##########
# FINISH #
##########


# Let the user know the script finished
# -------------------------------------
Write-Host "All done!"
Wait-ForKey