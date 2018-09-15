$moduleName = "WintellectPowerShell"
if (-not [bool](Get-Module -Name $moduleName) -and [bool]($targetModule = (Get-Module -Name $moduleName -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -Index 0))) {
    Import-Module $targetModule
    Remove-Variable -Name targetModule
}
if (([bool](Get-Module -Name $moduleName)) `
        -and (Test-Path -Path Function:Import-VisualStudioEnvironment)) {
    Import-VisualStudioEnvironment
}
Remove-Variable -Name moduleName