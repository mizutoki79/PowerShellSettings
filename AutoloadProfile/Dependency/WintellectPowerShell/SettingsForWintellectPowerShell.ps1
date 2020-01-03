if (([bool](Get-Module -Name 'WintellectPowerShell')) `
        -and (Test-Path -Path Function:Import-VisualStudioEnvironment)) {
    Import-VisualStudioEnvironment
}
