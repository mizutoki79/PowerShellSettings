Write-Host (Get-Date -Format "HH:mm:ss.ffff") 'Set for WintellectPowerShell...'
if (([bool](Get-Module -Name 'WintellectPowerShell')) `
        -and (Test-Path -Path Function:Import-VisualStudioEnvironment)) {
    (Import-VisualStudioEnvironment &) > $null
}
