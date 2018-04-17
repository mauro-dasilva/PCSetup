# Automated PC Setup

Automates various Machine Installations

## Windows Notes

* You need to run Powershell as an Administrator 

* Before executing the Setup Script, you will probably have to change the execution policy in Powershell to Unrestricted

  ````Set-ExecutionPolicy Unrestricted -Force````

* You can execute the Powershell script as follows:

  ````Powershell.exe .\SetupPC.ps1````

* Currently, the Pinning/Unpinning of items on the Taskbar, as well as the setting up of file associations are currently not working in Windows 10. Until a workaround is found by the Chocolatey Team, they have been commented out.
