$moduleName = "WintellectPowerShell"
if (-not [bool](Get-Module -Name $moduleName) -and [bool](Get-Module -Name $moduleName -ListAvailable)) {
    Import-Module $moduleName
}
if (([bool](Get-Module -Name $moduleName)) `
        -and (Test-Path -Path Function:Import-VisualStudioEnvironment)) {
    Import-VisualStudioEnvironment
}
Remove-Variable -Name moduleName