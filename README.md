# Automated PC Setup

Automates various Machine Installations

##What Does It Do?

Below is a list of some of the functions of the script:

* Installs Various Applications via Chocolatey
* Removes Pre-Installed Windows UWP Bloatware Apps
* Downloads various configs & settings
* Adjusts various Windows Preferences
* Add/Remove Windows Features
* Creates Various Folders
* Setup Taskbar (Not working in Win 10)
* Setup File Associations (Not Working in Win 10)
* Configure Start Up Applications
* Updates Windows
* Cleanup

## Notes

* You need to run Powershell as an Administrator 

* Before executing the Setup Script, you will probably have to change the execution policy in Powershell to Unrestricted

  ````Set-ExecutionPolicy Unrestricted -Force````

* You can execute the Powershell script as follows:

  ````Powershell.exe .\SetupPC.ps1````

* Currently, the Pinning/Unpinning of items on the Taskbar, as well as the setting up of file associations are currently not working in Windows 10. Until a workaround is found by the Chocolatey Team, they have been commented out.
