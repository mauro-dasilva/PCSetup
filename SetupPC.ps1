$OfficeVersion = 16
$WarningPreference = "SilentlyContinue"
$ErrorActionPreference = "SilentlyContinue"

Function CreateRegistryKey ($Path)
{
    If (!(Test-Path $Path)) {
        New-Item -Path $Path | Out-Null
    }
}

#####################################################################################################################################################################################################
#                                                   PRE-REQUISITES
#####################################################################################################################################################################################################
Write-Host "Please Enter Your Desired Computer Name: "
$ComputerName = Read-Host 
Rename-Computer -NewName $ComputerName | Out-Null

Write-Host "Installing Pre-requisites" -ForegroundColor Green

Write-Host "    Chocolatey Script" -ForegroundColor Magenta
    Invoke-Expression ((New-Object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) | Out-Null
    Import-Module $env:chocolateyinstall\helpers\chocolateyInstaller.psm1 | Out-Null

Write-Host "    NuGet Package Provider" -ForegroundColor Magenta 
    Install-PackageProvider -Name NuGet -Confirm:$false -Force | Out-Null

Write-Host "    VS Setup Script" -ForegroundColor Magenta
    Install-Module VSSetup -Scope CurrentUser -Confirm:$false -Force | Out-Null

Write-Host "    Windows Update Powershell Script" -ForegroundColor Magenta
    Install-Module PSWindowsUpdate -Confirm:$false -Force | Out-Null

#####################################################################################################################################################################################################
#                                                   ENVIRONMENT VARIABLES
#####################################################################################################################################################################################################
Write-Host "Setting up Environment Variables" -ForegroundColor Green

    [Environment]::SetEnvironmentVariable('ChocolateyToolsLocation', ${env:ProgramFiles(x86)}, "User")
    [Environment]::SetEnvironmentVariable('Path',$Env:Path + ";${env:ProgramFiles}\SourceGear\Common\DiffMerge\","User")
    Update-SessionEnvironment
  
#####################################################################################################################################################################################################
#                                                   INSTALLING APPLICATIONS
#####################################################################################################################################################################################################

# Visual Studio
Write-Host "Installing Visual Studio" -ForegroundColor Green
    choco install visualstudio2017enterprise -y | Out-Null  #visualstudio2017professional or visualstudio2017community

    #Choose your workloads. More information on workloads can be found at https://www.visualstudio.com/vs/visual-studio-workloads/
    Write-Host "    Installing Azure" -ForegroundColor Magenta
    choco install visualstudio2017-workload-azure -package-parameters "--wait" -y | Out-Null
    Write-Host "    Installing Data Storage & Processing" -ForegroundColor Magenta
    choco install visualstudio2017-workload-data -package-parameters "--wait" -y | Out-Null
    Write-Host "    Installing .NET Desktop" -ForegroundColor Magenta
    choco install visualstudio2017-workload-manageddesktop -package-parameters "--wait" -y | Out-Null
    Write-Host "    Installing .NET Core" -ForegroundColor Magenta
    choco install visualstudio2017-workload-netcoretools -package-parameters "--wait" -y | Out-Null
    Write-Host "    Installing Web Development" -ForegroundColor Magenta
    choco install visualstudio2017-workload-netweb -package-parameters "--wait" -y | Out-Null

#SQL Server Management Studio
Write-Host "Install SQL Server Management Studio" -ForegroundColor Green
    choco install sql-server-management-studio -y | Out-Null

# Visual Studio Code
Write-Host "Installing Visual Studio Code" -ForegroundColor Green
    choco install visualstudiocode -y --params '"/NoDesktopIcon"' | Out-Null
    Update-SessionEnvironment

    Write-Host "    Installing C# Extension" -ForegroundColor Magenta
    code --install-extension ms-vscode.csharp | Out-Null
    Write-Host "    Installing PowerShell Extension" -ForegroundColor Magenta
    code --install-extension ms-vscode.PowerShell | Out-Null
    Write-Host "    Installing Chrome Debugger Extension" -ForegroundColor Magenta
    code --install-extension msjsdiag.debugger-for-chrome | Out-Null
    Write-Host "    Installing Angular Extension" -ForegroundColor Magenta
    code --install-extension johnpapa.Angular2 | Out-Null
    Write-Host "    Installing Docker Extension" -ForegroundColor Magenta
    code --install-extension PeterJausovec.vscode-docker | Out-Null
    Write-Host "    Installing Git Lens Extension" -ForegroundColor Magenta
    code --install-extension eamodio.gitlens | Out-Null
    Write-Host "    Installing Spell Checker Extension" -ForegroundColor Magenta
    code --install-extension streetsidesoftware.code-spell-checker | Out-Null
    Write-Host "    Installing VSTS Extension" -ForegroundColor Magenta
    code --install-extension ms-vsts.team | Out-Null
    Write-Host "    Installing SQL Extension" -ForegroundColor Magenta
    code --install-extension ms-mssql.mssql | Out-Null
    Write-Host "    Installing Azure Account Extension" -ForegroundColor Magenta
    code --install-extension ms-vscode.azure-account | Out-Null

#Office 365
Write-Host "Installing Office 365" -ForegroundColor Green
    choco install office365proplus -y | Out-Null

#Various Apps
Write-Host "Installing Various Apps" -ForegroundColor Green

    Write-Host "    Git" -ForegroundColor Magenta
    choco install git.install -y --params '/NoShellIntegration' | Out-Null
    Write-Host "    Telnet" -ForegroundColor Magenta
    choco install TelnetClient -source windowsFeatures | Out-Null
    Write-Host "    Adobe Acrobat Reader" -ForegroundColor Magenta
    choco install adobereader -y | Out-Null
    Write-Host "    Node.js" -ForegroundColor Magenta
    choco install nodejs.install -y | Out-Null    
    Write-Host "    Google Chrome" -ForegroundColor Magenta
    choco install googlechrome -y | Out-Null
    Write-Host "    Skype" -ForegroundColor Magenta
    choco install skype -y | Out-Null
    Write-Host "    Sysinternals" -ForegroundColor Magenta
    choco install sysinternals -y --params '/InstallDir:""${env:ChocolateyToolsLocation}\Sysinternals""'  | Out-Null
    Write-Host "    Notepad++" -ForegroundColor Magenta
    choco install notepadplusplus -y | Out-Null
    Write-Host "    7-Zip" -ForegroundColor Magenta
    choco install 7zip.install -y | Out-Null
    Write-Host "    VLC" -ForegroundColor Magenta
    choco install vlc -y | Out-Null
    Write-Host "    Cmder Mini" -ForegroundColor Magenta
    choco install cmdermini -y | Out-Null
    Write-Host "    CCleaner" -ForegroundColor Magenta
    choco install CCleaner -y | Out-Null
    Write-Host "    Paint.net" -ForegroundColor Magenta
    choco install paint.net -y | Out-Null
    Write-Host "    Calibre" -ForegroundColor Magenta
    choco install calibre -y | Out-Null
    Write-Host "    DiffMerge" -ForegroundColor Magenta
    choco install diffmerge  -y | Out-Null
    Write-Host "    WhatsApp" -ForegroundColor Magenta
    choco install whatsapp -y | Out-Null
    Write-Host "    Microsoft Teams" -ForegroundColor Magenta
    choco install microsoft-teams -y | Out-Null
    Write-Host "    Slack" -ForegroundColor Magenta
    choco install slack -y | Out-Null
    Write-Host "    Royal TS" -ForegroundColor Magenta
    choco install royalts -y | Out-Null
    Write-Host "    Steam" -ForegroundColor Magenta
    choco install steam -y | Out-Null
    Write-Host "    ReSharper" -ForegroundColor Magenta
    choco install resharper-platform -y | Out-Null

    Update-SessionEnvironment

#####################################################################################################################################################################################################
#                                                   REMOVING PREINSTALLED APPS
#####################################################################################################################################################################################################
Write-Host "Removing Preinstalled Windows Apps" -ForegroundColor Green

    $AppsToRemove = @(
        "Microsoft.BingFinance"
        "Microsoft.BingNews"
        "Microsoft.BingSports"
        "Microsoft.BingWeather"
        "Microsoft.FreshPaint"
        "Microsoft.Getstarted"
        "Microsoft.MSPaint"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.MicrosoftStickyNotes"        
        "Microsoft.Office.OneNote"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.OneConnect"
        "Microsoft.SkypeApp"
        "Microsoft.WindowsAlarms"
        "Microsoft.WindowsCamera"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsPhone"
        "Microsoft.ZuneVideo"
        "Microsoft.MinecraftUWP"
        "Microsoft.MicrosoftPowerBIForWindows"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.CommsPhone"
        "Microsoft.ConnectivityStore"
        "Microsoft.Messaging"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.BingFoodAndDrink"
        "Microsoft.BingTravel"
        "Microsoft.BingHealthAndFitness"
        "Microsoft.WindowsReadingList"
        "9E2F88E3.Twitter"
        "PandoraMediaInc.29680B314EFC2"
        "Flipboard.Flipboard"
        "ShazamEntertainmentLtd.Shazam"
        "king.com.CandyCrushSaga"
        "king.com.CandyCrushSodaSaga"
        "king.com.*"
        "ClearChannelRadioDigital.iHeartRadio"
        "4DF9E0F8.Netflix"
        "6Wunderkinder.Wunderlist"
        "Drawboard.DrawboardPDF"
        "2FE3CB00.PicsArt-PhotoStudio"
        "D52A8D61.FarmVille2CountryEscape"
        "TuneIn.TuneInRadio"
        "GAMELOFTSA.Asphalt8Airborne"
        "TheNewYorkTimes.NYTCrossword"
        "DB6EA5DB.CyberLinkMediaSuiteEssentials"
        "Facebook.Facebook"
        "flaregamesGmbH.RoyalRevolt2"
        "Playtika.CaesarsSlotsFreeCasino"
        "A278AB0D.MarchofEmpires"
        "KeeperSecurityInc.Keeper"
        "ThumbmunkeysLtd.PhototasticCollage"
        "XINGAG.XING"
        "89006A2E.AutodeskSketchBook"
        "D5EA27B7.Duolingo-LearnLanguagesforFree"
        "46928bounde.EclipseManager"
        "ActiproSoftwareLLC.562882FEEB491"
        "DolbyLaboratories.DolbyAccess"
        "SpotifyAB.SpotifyMusic"
        "A278AB0D.DisneyMagicKingdoms"
        "WinZipComputing.WinZipUniversal"
        "BethesdaSoftworks.FalloutShelter"
        "PandoraMediaInc.29680B314EFC2"
        "AdobeSystemIncorporated.AdobePhotoshop"
        "Microsoft.Print3D"
        "Microsoft.GetHelp"
    )

    foreach ($CurrentAppName in $AppsToRemove) {
        
        Write-Host "    Removing $CurrentAppName" -ForegroundColor Magenta

        Get-AppxPackage -Name $CurrentAppName -AllUsers | Remove-AppxPackage -AllUsers | Out-Null
        Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ $CurrentAppName | Remove-AppxProvisionedPackage -Online | Out-Null   
        
        Start-Sleep -m 100
    }

#####################################################################################################################################################################################################
#                                                   DOWNLOAD REMOTE FILES
#####################################################################################################################################################################################################
Write-Host "Downloading Remote Files" -ForegroundColor Green

    New-Item ($env:UserProfile + "\.gitconfig") -Type File -Value ((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mauro-dasilva/AutomatedPcSetup/master/Configs/Git/.gitconfig')) -Force | Out-Null
    New-Item ($env:ChocolateyToolsLocation + "\cmdermini\vendor\conemu-maximus5\ConEmu.xml") -Type File -Value ((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mauro-dasilva/AutomatedPcSetup/master/Configs/Cmder/ConEmu.xml')) -Force | Out-Null

#####################################################################################################################################################################################################
#                                                   WINDOWS PREFERENCES
#####################################################################################################################################################################################################
Write-Host "Setting Windows Preferences" -ForegroundColor Green    

    New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null 

    # Show Hidden Files
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 1 

    # Hide File Extensions
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1

    # Navigation Pane Shows The Current Folder
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "NavPaneExpandToCurrentFolder" -Type DWord -Value 1 

    # Remove Suggested Apps
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" -Name "DisableWindowsConsumerFeatures" -Type DWord -Value 1 

    # Enable Do Not Track on Edge
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "DoNotTrack" -Type DWord -Value 1  

    # Disable Ads in Windows Explorer
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSyncProviderNotifications"  -Type DWord -Value 0 

    # Show Cortana Circle
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 1 

    # Enable Lock Screen Spotlight
    Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "ConfigureWindowsSpotlight" -Type DWord -Value 1 

    # Hide Task View Button
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

    # Disable Sticky Keys Prompt
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" "506" 
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" "122" 
    Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" "58"

    # Show All Icons in Tray
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

    # Windows Explorer Default to My Computer
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Type DWord -Value 1

    # Enable P2P Downloads over LAN only
    CreateRegistryKey "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config"
    CreateRegistryKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization"    
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" -Name "DODownloadMode" -Type DWord -Value 1 
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" -Name "SystemSettingsDownloadMode" -Type DWord -Value 3

    # Automatically Pick a Colour from your Background for your Theme Colour
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Type DWord -Value 1

    # Hide Recycle Bin on Desktop
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1

    # Use Light Theme By Default
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 1 

    # Disable Windows Ink Workspace
    CreateRegistryKey "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowWindowsInkWorkspace" -Type DWord -Value 0

    # Disable App Suggestions & Tips
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0

    # Enable Driver Updates through Windows Update
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 1
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" 
    
    # Disable Auto Play
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" -Name "DisableAutoplay" -Type DWord -Value 1

    #Show Details when Copying Files
    CreateRegistryKey "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager"
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1

    # Use Large Taskbar Icons
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" 

    # Hiding Recent Shortcuts
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowRecent" -Type DWord -Value 0
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "ShowFrequent" -Type DWord -Value 0

    # Hiding Desktop Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" -Recurse 

    # Hiding Downloads Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" -Recurse 
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" -Recurse 

    # Hiding Music Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" -Recurse 
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" -Recurse 

    # Hiding Pictures Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" -Recurse 
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" -Recurse 

    # Hiding Videos Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" -Recurse 
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" -Recurse 

    # Hiding 3D Objects Icon from This PC
	Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" -Recurse 

    # Disabling creation of Thumbs.db
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbnailCache" -Type DWord -Value 1
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisableThumbsDBOnNetworkFolders" -Type DWord -Value 1

    # Hiding Titles in Taskbar
    Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarGlomLevel" 

    # Enabling NumLock After Startup
    If (!(Test-Path "HKU:")) {
        New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
    }
    Set-ItemProperty -Path "HKU:\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Type DWord -Value 2147483650
    Add-Type -AssemblyName System.Windows.Forms
    If (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }

    # Disabling Search for App in Store for Unknown Extensions
    CreateRegistryKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer"
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "NoUseStoreOpenWith" -Type DWord -Value 1

    # Enabling Driver Updates through Windows Update
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Type DWord -Value 1
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" 

    # Enable Remote Desktop
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
    Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

    # Allow Trusted Apps (Needed for Linux Subsystem)
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Type DWord -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowAllTrustedApps" -Type DWord -Value 1

    # Remove "Include in Library" From Context Menu   
    Remove-Item -Path "HKLM:\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" -Recurse 
    Remove-Item -Path "HKCR:\Folder\ShellEx\ContextMenuHandlers\Library Location" -Recurse     

    # Remove "Pin to Quick Access" From Context Menu   
    Remove-Item -Path "HKLM:\SOFTWARE\Classes\Folder\shell\pintohome" -Recurse   
    Remove-Item -Path "HKCR:\Folder\shell\pintohome" -Recurse 

    # Remove "New Contact" From Context Menu   
    Remove-Item -Path "HKCR:\.contact\ShellNew" -Recurse 

    # Remove "Intel Graphics" From Context Menu   
    Remove-Item -Path "HKCR:\Directory\Background\shellex\ContextMenuHandlers\igfxcui" -Recurse 

    # Remove "New Journal" From Context Menu   
    Remove-Item -Path "HKCR:\.jnt\jntfile\ShellNew" -Recurse 

    # Remove "New Rich Text Document" From Context Menu   
    Remove-Item -Path "HKCR:\.rtf\ShellNew" -Recurse    

    # Remove "New Compressed Folder" From Context Menu   
    Remove-Item -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Recurse    

    # Remove "New Bitmap Image" From Context Menu   
    Remove-Item -Path "HKCR:\.bmp\ShellNew" -Recurse  
    
    # Remove "Modern Share" From Context Menu   
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\ModernSharing" -Recurse  

    # Remove "New Word Document" From Context Menu   
    Remove-Item -Path "HKCR:\.docx\Word.Document.12\ShellNew" -Recurse

    # Remove "New Excel Document" From Context Menu   
    Remove-Item -Path "HKCR:\.xlsx\Excel.Sheet.12\ShellNew" -Recurse

    # Remove "New Publisher Document" From Context Menu   
    Remove-Item -Path "HKCR:\.pub\Publisher.Document.16\ShellNew" -Recurse

    # Remove "New Access Document" From Context Menu   
    Remove-Item -Path "HKCR:\.accdb\Access.Application.16\ShellNew" -Recurse
    Remove-Item -Path "HKCR:\.mdb\ShellNew" -Recurse

    # Remove "New Powerpoint Document" From Context Menu   
    Remove-Item -Path "HKCR:\.pptx\PowerPoint.Show.12\ShellNew" -Recurse

    # Remove "New Shortcut" From Context Menu   
    Remove-Item -Path "HKCR:\.lnk\ShellNew" -Recurse    
        
    # Remove "Open in Visual Studio" From Context Menu   
    Remove-Item -Path "HKCR:\Directory\Background\shell\AnyCode" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shell\AnyCode" -Recurse 

    # Remove "Scan with Windows Defender" From Context Menu   
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\EPP" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\EPP" -Recurse 
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\EPP" -Recurse 
    Remove-Item -Path "HKCR:\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780" -Recurse 

    # Remove "Set as Backgroud Wallpaper" From Context Menu   
    Remove-Item -Path "HKCR:\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.dib\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.gif\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jfif\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpe\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpeg\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.png\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tif\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tiff\Shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.wdp\Shell\setdesktopwallpaper" -Recurse 

    # Remove "Shared Folder Synchronization" From Context Menu   
    Remove-Item -Path "HKCR:\CLSID\{6C467336-8281-4E60-8204-430CED96822D}" -Recurse 

    # Remove "Restore Previous Versions" From Context Menu   
    Remove-Item -Path "HKCR:\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 
    Remove-Item -Path "HKCR:\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" -Recurse 

    # Remove "Add to VLC media player's Playlist" From Context Menu  
    Get-Item -Path HKCR:\VLC.*\shell\AddToPlaylistVLC  | Remove-Item -Recurse 
    Get-Item -Path HKCR:\VLC.*\shell\PlayWithVLC  | Remove-Item -Recurse 
    Remove-Item -Path "HKCR:\Directory\shell\AddtoPlaylistVLC" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shell\PlayWithVLC" -Recurse 

    # Remove "Git Gui Here & Git Bash Here" From Context Menu  
    Remove-Item -Path "HKCR:\Directory\shell\git_gui" -Recurse 
    Remove-Item -Path "HKCR:\Directory\shell\git_shell" -Recurse 
    Remove-Item -Path "HKCR:\Directory\Background\shell\git_gui" -Recurse 
    Remove-Item -Path "HKCR:\Directory\Background\shell\git_shell" -Recurse 

    # Remove "Open with VS Code" From Context Menu  
    Remove-Item -Path "HKCR:\Directory\shell\VSCode" -Recurse 
    Remove-Item -Path "HKCR:\Directory\Background\shell\VSCode" -Recurse 
    Remove-Item -LiteralPath "HKCR:\*\shell\VSCode" -Recurse 
    Remove-Item -Path "HKCR:\Drive\shell\VSCode" -Recurse 

    # Remove "Windows Media Player" From Context Menu  
    Remove-Item -Path "HKCR:\Directory\shell\VSCode" -Recurse 
    Remove-Item -Path "HKCR:\Directory\Background\shell\VSCode" -Recurse 

    # Remove "Edit with Paint 3D" From Context Menu  
    Remove-Item -Path "HKCR:\SystemFileAssociations\.3mf\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.bmp\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.fbx\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.gif\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.glb\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jfif\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpe\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpeg\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpg\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.obj\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.ply\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.png\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.stl\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tif\shell\3D Edit" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tiff\shell\3D Edit" -Recurse 

    # Remove "Set as Wallpaper" From Context Menu  
    Remove-Item -Path "HKCR:\SystemFileAssociations\.bmp\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.dib\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.gif\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jfif\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpe\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpeg\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.jpg\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.png\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tif\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.tiff\shell\setdesktopwallpaper" -Recurse 
    Remove-Item -Path "HKCR:\SystemFileAssociations\.wdp\shell\setdesktopwallpaper" -Recurse 

    # Remove "3D Print" From Context Menu
    Remove-Item -Path "HKCR:\SystemFileAssociations\.3ds\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.3mf\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.dae\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.dxf\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.obj\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.ply\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.stl\shell\3D Print" -Recurse 	
    Remove-Item -Path "HKCR:\SystemFileAssociations\.wrl\shell\3D Print" -Recurse 	

    # Remove "DiffMerge" From Context Menu
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\SourceGearDiffMergeShellExtension32" -Recurse 
    Remove-Item -LiteralPath "HKCR:\*\shellex\ContextMenuHandlers\SourceGearDiffMergeShellExtension64" -Recurse
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\SourceGearDiffMergeShellExtension32" -Recurse
    Remove-Item -Path "HKCR:\Directory\shellex\ContextMenuHandlers\SourceGearDiffMergeShellExtension64" -Recurse
    
    # Remove "Send To" Links
    Remove-Item -Path "${env:APPDATA}\Microsoft\Windows\SendTo\Bluetooth File Transfer.LNK"
    Remove-Item -Path "${env:APPDATA}\Microsoft\Windows\SendTo\Desktop (create shortcut).DeskLink"
    Remove-Item -Path "${env:APPDATA}\Microsoft\Windows\SendTo\Documents.mydocs"
    Remove-Item -Path "${env:APPDATA}\Microsoft\Windows\SendTo\Mail Recipient.MAPIMail"

    Remove-PSDrive -Name HKCR     

#####################################################################################################################################################################################################
#                                                  ADD/REMOVE WINDOWS FEATURES
#####################################################################################################################################################################################################
Write-Host "Adding/Removing Windows Features" -ForegroundColor Green

    Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -NoRestart | Out-Null
    Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "MediaPlayback" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "FaxServicesClientPackage" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "Xps-Foundation-Xps-Viewer" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices-Features" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-Foundation-InternetPrinting-Client" -NoRestart | Out-Null
    Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-amd64" -NoRestart | Out-Null

#####################################################################################################################################################################################################
#                                                  KEYBOARD PREFERENCES
#####################################################################################################################################################################################################
Write-Host "Setting up Keyboard Preferences" -ForegroundColor Green

    $Languages = Get-WinUserLanguageList
    $Languages.Add("en-US")
    Set-WinUserLanguageList $Languages -Force

#####################################################################################################################################################################################################
#                                                  DESKTOP SETUP
#####################################################################################################################################################################################################
Write-Host "Setting Up Desktop" -ForegroundColor Green

    Write-Host "    Removing Desktop Shortcuts" -ForegroundColor Magenta
    Remove-Item "$env:Public\Desktop\*.*" -Force
    Remove-Item "$env:UserProfile\Desktop\*.*" -Force

#####################################################################################################################################################################################################
#                                                  TASKBAR (CURRENTLY NOT WORKING IN WINDOWS 10)
#####################################################################################################################################################################################################
# Write-Host "Add Shortcuts to Taskbar" -ForegroundColor Green

    # $VisualStudioExe = Join-Path -Path ((Get-VSSetupInstance | Select-VSSetupInstance -Latest).InstallationPath) -ChildPath "\Common7\IDE\devenv.exe"

    # Remove-Item "${env:APPDATA}\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Recurse
    # Remove-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Recurse
    # Install-ChocolateyPinnedTaskBarItem "$($env:windir)\explorer.exe"
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Office\root\Office$OfficeVersion\Outlook.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "$VisualStudioExe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft SQL Server\140\Tools\Binn\ManagementStudio\ssms.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ChocolateyToolsLocation}\cmder\cmder.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Office\root\Office$OfficeVersion\Onenote.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles}\Notepad++\Notepad++.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:UserProfile}\AppData\Local\WhatsApp\WhatsApp.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Skype\Phone\Skype.exe" | Out-Null
    # Install-ChocolateyPinnedTaskBarItem "${env:UserProfile}\AppData\Local\Microsoft\Teams\current\Teams.exe" | Out-Null

#####################################################################################################################################################################################################
#                                                   FILE ASSOCIATION (CURRENTLY NOT WORKING IN WINDOWS 10)
#####################################################################################################################################################################################################
# Write-Host "Setting Up Defaut File Associations" -ForegroundColor Green

    # Install-ChocolateyFileAssociation ".txt" "${env:ProgramFiles}\Notepad++\Notepad++.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".log" "${env:ProgramFiles}\Notepad++\Notepad++.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".xml" "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".cs" "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".ps1" "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".psm1" "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".config" "${env:ProgramFiles}\Microsoft VS Code\Code.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".avi" "${env:ProgramFiles}\VideoLAN\VLC\vlc.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".mp4" "${env:ProgramFiles}\VideoLAN\VLC\vlc.exe" | Out-Null
    # Install-ChocolateyFileAssociation ".mkv" "${env:ProgramFiles}\VideoLAN\VLC\vlc.exe" | Out-Null

    Stop-Process -ProcessName explorer

#####################################################################################################################################################################################################
#                                                   CLEAN UP
#####################################################################################################################################################################################################

Write-Host "Cleaning Up..." -ForegroundColor Green
    
    Write-Host "    Temp Folders" -ForegroundColor Magenta
    $Tempfolders = @("C:\Windows\Temp\*", "C:\Windows\Prefetch\*", "C:\Documents and Settings\*\Local Settings\Temp\*", "C:\Users\*\Appdata\Local\Temp\*")
    Remove-Item $Tempfolders -Force -Recurse 2>&1 | Out-Null

    Write-Host "    Scheduling Cleanup Of WinSXS Folder on Next Startup" -ForegroundColor Magenta
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce" -Name "Cleanup WinSXS" -Value "Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase"   

    
#####################################################################################################################################################################################################
#                                                   UPDATE WINDOWS
#####################################################################################################################################################################################################
Write-Host "Updating Windows" -ForegroundColor Green

    Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false | Out-Null
    Get-WUInstall -MicrosoftUpdate -AcceptAll -AutoReboot | Out-Null

