# Getting started

Before executing any scripts be aware that you do this on your own risk and the author does not take any responsibility. All scripts were tested on Windows 11 20H2. 
Execute all commands in Powershell, opened in administrator mode. The command stated below will asure you have the necessary permissions to execute the installation scripts. 

````
// Set policies to unrestricted before running the script 
Set-ExecutionPolicy Unrestricted
````

Next step, downloading the scripts. Feel free to examine the contents of the scripts and change whatever you want. 

To execute a script, navigate to the folder where you extracted all files and just use the filename precedeed with `.\`. For example, `.\01_Installation` followed by the enter key. 
The installation scripts will automatically try to elevate themself to run with administrator permissons. You will get the best experience running Powershell in admin/elevated mode. 

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

- [Getting started](#getting-started)
- [Contents](#contents)
  - [SophiaScriptWrapper.exe](#sophiascriptwrapperexe)
  - [tweaks_and_packages.ps1](#tweaks_and_packagesps1)
    - [Windows configuration](#windows-configuration)
    - [Chocolatey](#chocolatey)
    - [Other installations](#other-installations)
    - [Cleanup and reboot](#cleanup-and-reboot)
  - [extensions_and_configuration.ps1](#extensions_and_configurationps1)
    - [Visual Studio Code extensions](#visual-studio-code-extensions)
    - [WSL configuration](#wsl-configuration)
    - [Tweaks](#tweaks)
    - [Windows Defender exclusions](#windows-defender-exclusions)
      - [Excluded directories](#excluded-directories)
      - [Excluded processes](#excluded-processes)
      - [WSL specific exclusions](#wsl-specific-exclusions)
      - [Install and select Node version](#install-and-select-node-version)


## SophiaScriptWrapper.exe

A lot of the previous tweaks were removed from the scripts because of this wonderfull project. Not only adds this project lots of additional options, it also has the possibility to create different profiles with different settings. 

One of the options that didn't work properly, was the WSL installation. It installed the correct Windows features, downloaded the linux distribution of choice and even looked like it was installing. Unfortunately, my system did not detect the distribution and I needed to install it again.

Even without this function, the Sophia Script has alot of nice features and good maintenance with regular updates. You can find the [Sophia script repository](https://github.com/farag2/Sophia-Script-for-Windows) with instructions here.


## tweaks_and_packages.ps1
This script will change some basic Windows settings, remove bloatware, install features and install chocolatey with packages, further details below.

### Windows configuration

- [x] Change Windows explorer options
 - [x] Remove 'Music' from libraries
 - [x] Remove 'Videos' from libraries
- [x] Enable mapped drive sharing between users => mapped drives will be available to new user profiles
- [x] Set current network profile to private (allow file sharing, device discovery, etc.)
- [x] Enable Remote Desktop w/o Network Level Authentication
- [x] Show small icons in taskbar => only Windows 10
- [x] Set small taskbar => Windows 11
- [x] Set taskbar buttons to show labels and never combine => only Windows 10
- [x] Always show all tray icons => only Windows 10
- [x] Disable search for app in store for unknown extensions
- [x] Hide shortcut icon arrow
- [x] Adjust visual effects for performance
- [x] Change mouse cursor to show circle when ctrl pressed
- [x] Show full directory path in Explorer title bar
- [x] Show protected operating system files
- [x] Uninstall Microsoft XPS Document Writer
- [x] Enable Windows Developer mode


### Chocolatey

[Chocolatey](https://chocolatey.org/) is a free utility that can help you installing packaged applications. It will make the installation of quite a few apps very easy in a manageable fashion. 
As a bonus it had the functionality to upgrade already installed applications/packages. List of Chocolatey packages in no particular order: 

- [x] 7zip.install
- [x] adobereader
- [x] anaconda3
- [x] azure-cli
- [x] azure-data-studio
- [x] cuda
- [x] docker-desktop
- [x] eid-belgium
- [x] fiddler
- [x] fontbase
- [x] geforce-game-ready-driver
- [x] git
- [x] googlechrome
- [x] jmeter
- [x] jre8
- [x] k-litecodecpackmega
- [x] lastpass
- [x] microsoftazurestorageexplorer
- [x] mobaxterm
- [x] notepadplusplus.install
- [x] nvm
- [x] obs-move-transition
- [x] obs-studio
- [x] obs-virtualcam
- [x] openssl.light
- [x] postman
- [x] powertoys
- [x] rufus
- [x] sharex
- [x] slack
- [x] sourcetree
- [x] spotify
- [x] sql-server-management-studio
- [x] totalcommander
- [x] typescript
- [x] visualstudio2019enterprise
- [x] visualstudio2022enterprise
- [x] vscode
- [x] wget
- [x] nswagstudio
- [x] p4merge
- [x] powershell
- [x] whatsapp


### Other installations

- [x] WSL2


### Cleanup and reboot

- [x] Remove Desktop icons
- [x] Unpin all Start Menu tiles
- [x] Unpin all Taskbar icons
- [x] Reboot computer after installation



## extensions_and_configuration.ps1

The base for our installation was set in the first script. Features were added, applications installed, bloatwere removed... Time to dot the I's and cross the T's.


### Visual Studio Code extensions

- [x] .NET Core extension pack
- [x] AKS extension for debugging microservices
- [x] Angular extension pack
- [x] Azure account management
- [x] Azure kubernetes service
- [x] Azure static web apps
- [x] Azure tools extension pack
- [x] Bracket pair colorizer 2
- [x] Bridge to Kubernetes for debugging MicroServices
- [x] C# extensions (refactorings)
- [x] Chrome debugger
- [x] Colorize comments
- [x] Convert csharp to typescript
- [x] CSS peek
- [x] Docker extension pack
- [x] Draw.io integration
- [x] Excel viewer, opens Excel and CSV files as a table
- [x] Firefox debugger
- [x] GitLens
- [x] Jupyter notebooks
- [x] Kubernetes extension
- [x] Kubernetes pod file system explorer
- [x] Kubernetes template snippets
- [x] Live server
- [x] Live share extension pack
- [x] Markdown All in One
- [x] Markdown Preview Enhanced
- [x] Microsoft Edge debugger
- [x] Move TS, add move functionality that updates imports
- [x] Node Essentials
- [x] Node.js extension pack
- [x] NPM extension
- [x] Partial Diff
- [x] Paste JSON as Code
- [x] Powershell scripting extension
- [x] Prettier code formatter
- [x] Project manager
- [x] Python extension
- [x] Remote development pack
- [x] REST client
- [x] Settings sync, save VS code settings to github
- [x] Sort lines
- [x] SQL server extension
- [x] Test Explorer UI
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

After this script is finished and Ubuntu for WSL is installed, start Ubuntu from start menu and create an account. When finished, open Powershell and execute: 
````
wsl --set-default ubuntu-20.04 2
````

Unfortunately, I could not find how to automatically enable the Ubuntu distribution in Docker to combine it with the Docker WSL2 backend.
You can enable this by opening Docker Desktop => Settings => Resources => WSL integration. Enable the option `Enable integration with my default WSL distro` and toggle the Ubuntu distribution on in the same screen.  

### Tweaks

- [x] Set Visual Studio to automatically open in admin mode
- [x] Set Visual Studio Code to automatically open in admin mode
- [x] Set Total Commander to automatically open in admin mode
- [x] Create Windows Terminal Desktop Shortcut with admin priveleges

### Windows Defender exclusions

Windows Defender offers great general protection to us Windows users. Unfortunately, it can get in the way when developing applications.  

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
   - [x] D:\\

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

#### Install and select Node version

NVM (Node Version Manager) will be installed in the 1st script. This application will give you the possibility to install and switch between different Node versions. By default the script will install the latest version (Non-LTS). It is possible to install versions by executing NVM install [version number here].