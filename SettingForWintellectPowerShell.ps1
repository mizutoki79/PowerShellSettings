$moduleName = "WintellectPowerShell"
if (-not (Get-Module -Name $moduleName) -and (Get-Module -Name $moduleName -ListAvailable)) {
    Import-Module $moduleName
}
if (($null -ne (Get-Module -Name $moduleName | Sort-Object -Descending -Property Version | Select-Object -Index 0)) `
        -and (Test-Path -Path Function:Import-VisualStudioEnvironment)) {
    Import-VisualStudioEnvironment
}
Remove-Variable -Name moduleName