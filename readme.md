# Getting started

Before executing any scripts be aware that you do this on your own risk and the author does not take any responsibility. All scripts were tested on Windows 10 Enterprise build 2004. 
Execute all commands in Powershell, opened in administrator mode. The command stated below will asure you have the necessary permissions to execute the installation scripts. 

````
// Set policies to unrestricted before running the script 
Set-ExecutionPolicy RemoteSigned
````

Next step, downloading the scripts. Feel free to examine the contents of the scripts and change whatever you want. 
You will need to place the `functions.psm1` file, that includes helper functions, in the same directory as the other scripts. 

To execute a script, navigate to the folder where you extracted all files and just use the filename precedeed with `.\`. For example, `.\01_Installation` followed by the enter key. 
The installation scripts will automatically try to elevate themself to run with administrator permissons. You will get the best experience running Powershell in admin mode. 

After executing all scripts, re-enable the execution policy for your own protection to prevent unwanted or malificent scripts from executing. 

````
// Change execution policies back or keep the policy remote signed for executing unsigned local scripts and signed scripts over network
Set-ExecutionPolicy RemoteSigned
```` 

All chapters below will explain the script in more detail. For better visualization, task lists will be used.

- [x] enabled by default
- [ ] disabled by default => commented out

Lists will contain copied parts from the scripts to make documenting the contents easier instead of favoring readability.  

# Contents

- [01_Installation.ps1](#01_installationps1)
  - [Windows 10 configuration](#windows-10-configuration)
  - [Bloatware removal](#bloatware-removal)
  - [Chocolatey](#chocolatey)
  - [Windows features](#windows-features)
  - [Other Installations](#other-installations)
  - [Cleanup and reboot](#cleanup-and-reboot)
- [02_extensions_and_configuration.ps1](#02_extensions_and_configurationps1)
  - [Visual Studio Code Extensions](#visual-studio-code-extensions)
  - [WSL configuration](#wsl-configuration)
  - [Tweaks](#tweaks)
  - [Windows Defender exclusions](#windows-defender-exclusions)
    - [Excluded directories](#excluded-directories)
    - [Excluded processes](#excluded-processes)
    - [WSL specific exclusions](#wsl-specific-exclusions)

## 01_Installation.ps1
This script will change some basic Windows 10 settings, remove bloatware, install features and install chocolatey with packages, further details below.

### Windows 10 configuration

- [x] Rename computer based on user input
- [x] Disable standby and change monitor timeout to 60 seconds
- [x] Disable user account control notifications (open applications in admin mode without prompt)
- [x] Disable Telemetry
- [x] Disable user activity tracking
- [x] Disable Bing search in start menu
- [x] Remove people icon from taskbar
- [x] Disable Advertising ID => no advertisements based on sites you visit
- [x] Disable Windows GameDVR
- [x] Disable Windows Update Automatic restart
- [x] Disable Windows update network seeding
- [x] Disable Edge desktop shortcut on new profiles
- [x] Remove edge shortcut from desktop
- [x] Restore old volume slider with application volume control
- [x] Change Windows explorer options
 - [x] Show hidden files
 - [x] Always show file extensions
 - [x] Change default explorer view from 'Quick Access' to 'This PC'
 - [x] Remove 'Music' from libraries
 - [x] Remove 'Videos' from libraries
 - [x] Remove '3D Objects' from libraries
 - [x] Disable recent files in 'Quick Access' view
 - [x] Disable frequent folders in 'Quick Access' view
- [x] Enable mapped drive sharing between users => mapped drives will be available to new user profiles
- [x] Set current network profile to private (allow file sharing, device discovery, etc.)
- [x] Change Windows to Dark Theme
- [x] Enable Remote Desktop w/o Network Level Authentication
- [ ] Disable Hibernation => Use this for always on desktops or home servers
- [x] Hide search box/icon from task bar
- [x] Hide Task View button
- [x] Show small icons in taskbar
- [x] Set taskbar buttons to show labels and never combine
- [x] Always show all tray icons
- [x] Disable search for app in store for unknown extensions
- [x] Enable NumLock after startup
- [ ] Disable offering of drivers through Windows Update
- [x] Enable NTFS paths with length over 260 characters
- [x] Disable adding '- shortcut' to shortcut name
- [x] Hide shortcut icon arrow
- [x] Adjust visual effects for performance
- [x] Change mouse cursor to show circle when ctrl pressed
- [x] Show full directory path in Explorer title bar
- [x] Show protected operating system files
- [x] Disable Edge preload after Windows startup (non-chromium version)
- [x] Uninstall Microsoft XPS Document Writer
- [x] Enable Windows 10 Developer mode

### Bloatware removal

Remove UWP apps and games that could be installed by default. These packages are different between Windows builds and vendors. List of package names that will be removed if found: 

- [x] 2414FC7A.Viber
- [x] 41038Axilesoft.ACGMediaPlayer
- [x] 46928bounde.EclipseManager
- [x] 4DF9E0F8.Netflix
- [x] 64885BlueEdge.OneCalendar
- [x] 7EE7776C.LinkedInforWindows
- [x] 828B5831.HiddenCityMysteryofShadows
- [x] 89006A2E.AutodeskSketchBook
- [x] 9E2F88E3.Twitter
- [x] A278AB0D.DisneyMagicKingdoms
- [x] A278AB0D.DragonManiaLegends
- [x] A278AB0D.MarchofEmpires
- [x] ActiproSoftwareLLC.562882FEEB491
- [x] AD2F1837.GettingStartedwithWindows8
- [x] AD2F1837.HPJumpStart
- [x] AD2F1837.HPRegistration
- [x] AdobeSystemsIncorporated.AdobePhotoshopExpress
- [x] Amazon.com.Amazon
- [x] C27EB4BA.DropboxOEM
- [x] CAF9E577.Plex
- [x] CyberLinkCorp.hs.PowerMediaPlayer14forHPConsumerPC
- [x] D52A8D61.FarmVille2CountryEscape
- [x] D5EA27B7.Duolingo-LearnLanguagesforFree
- [x] DB6EA5DB.CyberLinkMediaSuiteEssentials
- [x] DolbyLaboratories.DolbyAccess
- [x] Drawboard.DrawboardPDF
- [x] Facebook.Facebook
- [x] Fitbit.FitbitCoach
- [x] flaregamesGmbH.RoyalRevolt2
- [x] GAMELOFTSA.Asphalt8Airborne
- [x] KeeperSecurityInc.Keeper
- [x] king.com.BubbleWitch3Saga
- [x] king.com.CandyCrushFriends
- [x] king.com.CandyCrushSaga
- [x] king.com.CandyCrushSodaSaga
- [x] king.com.FarmHeroesSaga
- [x] Nordcurrent.CookingFever
- [x] PandoraMediaInc.29680B314EFC2
- [x] PricelinePartnerNetwork.Booking.comBigsavingsonhot
- [x] ThumbmunkeysLtd.PhototasticCollage
- [x] WinZipComputing.WinZipUniversal
- [x] XINGAG.XING
- [x] Microsoft.BingFinance
- [x] Microsoft.BingFoodAndDrink
- [x] Microsoft.BingHealthAndFitness
- [x] Microsoft.BingMaps
- [x] Microsoft.BingNews
- [x] Microsoft.BingSports
- [x] Microsoft.BingTranslator
- [x] Microsoft.BingTravel
- [x] Microsoft.CommsPhone
- [x] Microsoft.ConnectivityStore
- [x] Microsoft.FreshPaint
- [x] Microsoft.GetHelp
- [x] Microsoft.Getstarted
- [x] Microsoft.HelpAndTips
- [x] Microsoft.Messaging
- [x] Microsoft.Microsoft3DViewer
- [x] Microsoft.MicrosoftOfficeHub
- [x] Microsoft.MicrosoftPowerBIForWindows
- [x] Microsoft.MicrosoftSolitaireCollection
- [x] Microsoft.MicrosoftStickyNotes
- [x] Microsoft.MinecraftUWP
- [x] Microsoft.MoCamera
- [x] Microsoft.NetworkSpeedTest
- [x] Microsoft.Office.Sway
- [x] Microsoft.People
- [x] Microsoft.SkypeApp
- [x] Microsoft.Wallet
- [x] Microsoft.WindowsCamera
- [x] Microsoft.WindowsFeedbackHub
- [x] Microsoft.WindowsMaps
- [x] Microsoft.WindowsPhone
- [x] Microsoft.XboxGamingOverlay
- [x] Microsoft.ZuneMusic
- [x] Microsoft.ZuneVideo

### Chocolatey

[Chocolatey](https://chocolatey.org/) is a free utility that can help you installing packaged applications. It will make the installation of quite a few apps very easy in a manageable fashion. 
As a bonus it had the functionality to upgrade already installed applications/packages. List of Chocolatey packages in no particular order: 

- [x] cuda
- [x] git
- [x] nodejs
- [x] adobereader
- [x] googlechrome
- [x] jre8
- [x] firefox
- [x] 7zip.install
- [x] notepadplusplus.install
- [x] wget
- [x] openssl.light
- [x] fiddler
- [x] microsoft-teams.install
- [x] microsoft-edge => Chromium based
- [x] powertoys
- [x] k-litecodecpackmega
- [x] mobaxterm
- [x] sharex
- [x] slack
- [x] sourcetree
- [x] postman
- [x] docker-desktop
- [x] totalcommander
- [x] whatsapp
- [x] prusaslicer
- [x] rufus
- [x] sysinternals
- [x] dotnetcore-sdk
- [x] dotnetcore
- [x] netfx-4.8-devpack
- [x] netfx-4.8
- [x] sql-server-management-studio
- [x] visualstudio2019enterprise
- [ ] visualstudio2019professional
- [x] jetbrainstoolbox
- [x] anaconda3
- [x] vscode
- [x] typescript
- [x] microsoft-windows-terminal
- [x] blender
- [x] obs-studio
- [x] obs-virtualcam
- [x] eid-belgium
- [x] lastpass
- [x] sudo
- [x] fontbase
- [ ] daily package upgrade script => this will update ALL chocolatey packages on a daily base, not recommended for stable systems

### Windows features

- [x] IIS-ODBCLogging
- [x] IIS-IISCertificateMappingAuthentication
- [x] IIS-ClientCertificateMappingAuthentication
- [x] IIS-DigestAuthentication
- [x] HypervisorPlatform
- [x] Containers
- [x] Microsoft-Hyper-V-Management-Clients
- [x] Microsoft-Hyper-V-Services
- [x] Microsoft-Hyper-V-Hypervisor
- [x] Microsoft-Hyper-V-Management-PowerShell
- [x] Microsoft-Hyper-V-Tools-All
- [x] Microsoft-Hyper-V
- [x] Microsoft-Hyper-V-All
- [x] Containers-DisposableClientVM
- [x] IIS-RequestMonitor
- [x] IIS-HttpTracing
- [x] IIS-URLAuthorization
- [x] IIS-IPSecurity
- [x] IIS-LegacySnapIn
- [x] IIS-LegacyScripts
- [x] IIS-WMICompatibility
- [x] IIS-CustomLogging
- [x] IIS-CGI
- [x] IIS-ASP
- [x] IIS-ASPNET
- [x] IIS-WebDAV
- [x] IIS-FTPSvc
- [x] IIS-HostableWebCore
- [x] IIS-Metabase
- [x] IIS-IIS6ManagementCompatibility
- [x] IIS-ManagementScriptingTools
- [x] IIS-DefaultDocument
- [x] IIS-DirectoryBrowsing
- [x] IIS-WebSockets
- [x] IIS-ApplicationInit
- [x] IIS-ASPNET45
- [x] IIS-ISAPIExtensions
- [x] IIS-ISAPIFilter
- [x] IIS-ServerSideIncludes
- [x] IIS-BasicAuthentication
- [x] IIS-StaticContent
- [x] IIS-HttpCompressionStatic
- [x] IIS-ManagementService
- [x] IIS-CertProvider
- [x] IIS-WindowsAuthentication
- [x] MediaPlayback
- [x] SmbDirect
- [x] IIS-ManagementConsole
- [x] Microsoft-Windows-Subsystem-Linux
- [x] IIS-WebServerManagementTools
- [x] IIS-Performance
- [x] MSRDC-Infrastructure
- [x] NetFx4-AdvSrvs
- [x] NetFx4Extended-ASPNET45
- [x] WCF-Services45
- [x] IIS-HttpCompressionDynamic
- [x] WCF-TCP-PortSharing45
- [x] IIS-WebServer
- [x] IIS-CommonHttpFeatures
- [x] IIS-HttpErrors
- [x] IIS-ApplicationDevelopment
- [x] IIS-NetFxExtensibility45
- [x] IIS-HealthAndDiagnostics
- [x] IIS-HttpLogging
- [x] IIS-Security
- [x] IIS-RequestFiltering
- [x] IIS-WebServerRole
- [x] VirtualMachinePlatform

### Other installations

- [x] Azure CLI
- [x] WSL2
- [x] Powershell 7.0.3

### Cleanup and reboot

- [x] Remove Desktop icons
- [x] Unpin all Start Menu tiles
- [x] Unpin all Taskbar icons
- [x] Reboot computer after installation

## 02_extensions_and_configuration.ps1

The base for our installation was set in the first script. Features were added, applications installed, bloatwere removed... Time to dot the I's and cross the T's.

### Visual Studio Code extensions

- [x] .NET Core extension pack
- [x] Angular extension pack
- [x] Azure account management
- [x] AKS extension for debugging microservices
- [x] Azure kubernetes service
- [x] Azure tools extension pack
- [x] C# compiler
- [x] C# extensions (refactorings)
- [x] Chrome debugger
- [x] Convert csharp to typescript
- [x] Colorize comments
- [x] Colorize brackets
- [x] CSS peek
- [x] Docker extension pack
- [x] Draw.io integration
- [x] Excel viewer, opens Excel and CSV files as a table
- [x] Firefox debugger
- [x] GitLens
- [x] Import cost, shows size of imports for JS and TS
- [x] JSON to TS
- [x] Kubernetes extension
- [x] Kubernetes pod file system explorer
- [x] Kubernetes template snippets
- [x] Live server
- [x] Live share extension pack
- [x] Microsoft Edge debugger
- [x] Move TS, add move functionality that updates imports
- [x] NPM extension
- [x] Paste JSON as Code
- [x] Powershell scripting extension
- [x] Prettier code formatter
- [x] Project manager
- [x] Python extension
- [x] Remote development pack
- [x] REST client
- [x] Settings sync, save VS code settings to github
- [x] SQL server extension
- [x] Typescript extension pack
- [x] Visual studio codespaces
- [x] Visual Studio intellicode
- [x] XML tools
- [x] YAML support

### WSL configuration

- [x] Install new WSL2 kernel
- [x] Add memory limitation to WSL2, default behavior could use all system memory
- [x] Set WSL2 as default
- [x] Install Ubuntu 20.04 WSL
- [x] Set Ubuntu 20.04 as default WSL distribution

Unfortunately, I could not find how to automatically enable the Ubuntu distribution in Docker to combine it with the Docker WSL2 backend.
You can enable this by opening Docker Desktop => Settings => Resources => WSL integration. Enable the option `Enable integration with my default WSL distro` and toggle the Ubuntu distribution on in the same screen.  

### Tweaks

- [x] Set Visual Studio to automatically open in admin mode
- [x] Set Visual Studio Code to automatically open in admin mode
- [x] Set Total Commander to automatically open in admin mode

### Windows Defender exclusions

Windows Defender offers great general protection to us Windows 10 users. Unfortunately, it can get in the way when developing applications.  

#### Excluded directories

 - [x] Default installation paths
   - [x] C:\Windows\Microsoft.NET 
   - [x] C:\Windows\assembly 
   - [x] C:\Program Files\dotnet 
   - [x] C:\ProgramData\Microsoft\VisualStudio\Packages 
   - [x] C:\Program Files (x86)\Microsoft SDKs\NuGetPackages 
   - [x] C:\Program Files (x86)\MSBuild 
   - [x] C:\Program Files (x86)\Microsoft Visual Studio 
   - [x] C:\Program Files (x86)\Microsoft Visual Studio Tools for Unity 
   - [x] C:\Program Files\Microsoft VS Code 
   - [x] C:\Program Files (x86)\Microsoft SDKs 
   - [x] C:\Program Files (x86)\Windows Kits 
   - [x] C:\Program Files\Docker 

 - [x] User profile paths
   - [x] $userPath\AppData\Roaming\npm
   - [x] $userPath\AppData\Roaming\npm-cache
   - [x] $userPath\AppData\Local\Microsoft\VisualStudio
   - [x] $userPath\AppData\Local\JetBrains\Transient
   - [x] $env:ProgramData\Docker
   - [x] $env:ProgramData\DockerDesktop

 - [x] Project paths => change this to your own project paths
   - [x] C:\\_sync 
   - [x] C:\\_projects

#### Excluded processes

- [x] Visual Studio
   - [x] vshost-clr2.exe 
   - [x] VSInitializer.exe 
   - [x] VSIXInstaller.exe 
   - [x] VSLaunchBrowser.exe 
   - [x] vsn.exe 
   - [x] VsRegEdit.exe 
   - [x] VSWebHandler.exe 
   - [x] VSWebLauncher.exe 
   - [x] XDesProc.exe 
   - [x] Blend.exe 
   - [x] CodeCoverage.exe 
   - [x] DDConfigCA.exe 
   - [x] devenv.exe 
   - [x] FeedbackCollector.exe 
   - [x] IntelliTrace.exe 
   - [x] Microsoft.VisualStudio.Web.Host.exe 
   - [x] mspdbsrv.exe 
   - [x] MSTest.exe 
   - [x] PerfWatson2.exe 
   - [x] Publicize.exe 
   - [x] QTAgent.exe 
   - [x] QTAgent_35.exe 
   - [x] QTAgent_40.exe 
   - [x] QTAgent32.exe 
   - [x] QTAgent32_35.exe 
   - [x] QTAgent32_40.exe 
   - [x] QTDCAgent.exe 
   - [x] QTDCAgent32.exe 
   - [x] StorePID.exe 
   - [x] T4VSHostProcess.exe 
   - [x] TailoredDeploy.exe 
   - [x] TCM.exe 
   - [x] testhost.exe 
   - [x] TextTransform.exe 
   - [x] TfsLabConfig.exe 
   - [x] UserControlTestContainer.exe 
   - [x] vb7to8.exe 
   - [x] VcxprojReader.exe 
   - [x] VsDebugWERHelper.exe 
   - [x] VSFinalizer.exe 
   - [x] VsGa.exe 
   - [x] VSHiveStub.exe 
   - [x] vshost.exe 
   - [x] vshost32.exe 
   - [x] vshost32-clr2.exe 
   - [x] vbcscompiler.exe 

- [x] VS Code
   - [x] Code.exe 

- [x] Runtimes, build tools
   - [x] dotnet.exe 
   - [x] mono.exe 
   - [x] mono-sgen.exe 
   - [x] java.exe 
   - [x] java64.exe 
   - [x] msbuild.exe 
   - [x] node.exe 
   - [x] node.js 
   - [x] perfwatson2.exe 
   - [x] ServiceHub.Host.Node.x86.exe 
   - [x] vbcscompiler.exe 
   - [x] nuget.exe 
    
- [x] VCS
   - [x] git.exe 
   - [x] sourcetree.exe 

- [x] Docker
   - [x] Docker Desktop.exe 
   - [x] DockerWatchguard.exe 
   - [x] dockerd.exe 
    
- [x] Shells
   - [x] git-bash.exe 
   - [x] bash.exe 
   - [x] powershell.exe 
   - [x] wt.exe
    
- [x] All of JetBrains stuff
   - [x] JetBrains.EntityFramework.Runner620.exe 
   - [x] JetBrains.MsBuild.TaskEntryPoint.exe 
   - [x] JetBrains.Platform.Satellite.exe 
   - [x] JetBrains.ReSharper.Features.XamlPreview.External.exe 
   - [x] JetBrains.ReSharper.Host.exe 
   - [x] JetBrains.ReSharper.Host64.exe 
   - [x] JetBrains.ReSharper.Roslyn.Worker.exe 
   - [x] JetLauncher32.exe 
   - [x] JetLauncher32c.exe 
   - [x] JetLauncher64.exe 
   - [x] JetLauncher64c.exe 
   - [x] JetLauncherIL.exe 
   - [x] JetLauncherILc.exe 
   - [x] OperatorsResolveCacheGenerator.exe 
   - [x] PsiGen.exe 
   - [x] ReSharperTestRunner32.exe 
   - [x] ReSharperTestRunner64.exe 
   - [x] ReSharperTestRunnerIL.exe 
   - [x] RiderClrProcessEnumerator32.exe 
   - [x] RiderClrProcessEnumeratorIL.exe 
   - [x] TokenGenerator.exe 
   - [x] xamarin-component.exe 
   - [x] ClrStack.x64.exe 
   - [x] ClrStack.x86.exe 
   - [x] CsLex.exe 
   - [x] ErrorsGen.exe 
   - [x] JetBrains.Debugger.Worker.exe 
   - [x] JetBrains.Debugger.Worker32c.exe 
   - [x] JetBrains.Debugger.Worker64c.exe 
   - [x] dotPeek32.exe 
   - [x] dotPeek64.exe 
   - [x] DotTabWellScattered32.exe 
   - [x] DotTabWellScattered64.exe 
   - [x] DotTabWellScatteredIL.exe 
   - [x] JetBrains.Platform.Installer.Bootstrap.exe 
   - [x] JetBrains.Platform.Installer.Cleanup.exe 
   - [x] JetBrains.Platform.Installer.exe 
   - [x] CleanUpProfiler.x64.exe 
   - [x] CleanUpProfiler.x86.exe 
   - [x] Configuration2Xml32.exe 
   - [x] Configuration2Xml64.exe 
   - [x] ConsoleProfiler.exe 
   - [x] dotTrace32.exe 
   - [x] dotTrace64.exe 
   - [x] DotTraceLauncher.exe 
   - [x] dotTraceView32.exe 
   - [x] dotTraceView64.exe 
   - [x] JetBrains.Common.ElevationAgent.exe 
   - [x] JetBrains.Common.ExternalStorage.exe 
   - [x] JetBrains.Common.ExternalStorage.x86.exe 
   - [x] JetBrains.dotTrace.IntegrationDemo.exe 
   - [x] Reporter.exe 
   - [x] SnapshotStat.exe 
   - [x] Timeline32.exe 
   - [x] Timeline64.exe 
   - [x] dotMemory.UI.32.exe 
   - [x] dotMemory.UI.64.exe 
   - [x] dotMemoryUnit.exe 
   - [x] JetBrains.dotMemory.Console.SingleExe.exe 
   - [x] JetBrains.dotMemoryUnit.Server.exe 
   - [x] restarter.exe 
   - [x] rider64.exe 
   - [x] runnerw.exe 
   - [x] runnerw64.exe 
   - [x] WinProcessListHelper.exe 
   - [x] elevator.exe 
   - [x] fsnotifier.exe 
   - [x] fsnotifier64.exe 
   - [x] launcher.exe 
   - [x] NGen Rider Assemblies.exe 
   - [x] idea.exe 
   - [x] idea64.exe 
   - [x] JetBrains.Etw.Collector.Host.exe 
   - [x] webstorm64.exe 
   - [x] datagrip64.exe 
   - [x] clion64.exe 
   - [x] goland64.exe 
   - [x] phpstorm64.exe 
   - [x] pycharm64.exe 
   - [x] rubymine64.exe 
   - [x] studio64.exe 
    
- [x] JB Toolbox
   - [x] jetbrains-toolbox.exe 
   - [x] jetbrains-toolbox-cef.exe 
   - [x] jetbrains-toolbox-cef-helper.exe 
    
- [x] Unity
   - [x] UnityHelper.exe 
   - [x] Unity.exe 
   - [x] UnityShaderCompiler.exe 
   - [x] UnityYAMLMerge.exe 
   - [x] UnityCrashHandler64.exe'

#### WSL specific exclusions

Special thanks to Noel Bundick for [this script](https://gist.github.com/noelbundick/9c804a710eb76e1d6a234b14abf42a52). This will stop Windows Defender from scanning WSL files. 
Scanning WSL files often gives false positives and, at the moment, does not offer any security for Linux systems.