# posh-git のインポート
Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
$moduleName = "posh-git"
if (-not (Get-Module -Name $moduleName)) {
    # If you installed "posh-git" by `Install-Module` from PowerShell Gallery
    if ($poshGitModule = Get-Module -Name $moduleName -ListAvailable | Sort-Object -Descending -Property Version | Select-Object -Index 0) {
        $poshGitModule | Import-Module
    }
    else {
        # If you installed "posh-git" by Chocolatey, maybe you can't find "posh-git" by "Get-Module -ListAvailable".
        # You can find it if you use "-All" option. But that command takes time. you should specify fullpath.
        $env:PSModulePath = $env:PSModulePath + ";C:\tools\"
        $poshGitModule = Get-Module $moduleName -All -ListAvailable | Sort-Object -Descending -Property Version | Select-Object -Index 0
        if ($poshGitModule) {
            $poshGitModule | Import-Module
        }
        else {
            throw "Failed to import posh-git."
        }
    }
}

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git

Remove-Variable -Name moduleName
Pop-Location
