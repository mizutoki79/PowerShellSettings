Write-Host (Get-Date -Format HH:mm:ss.ffff) 'Set Prompt'
if ([bool] (Get-Command -Module oh-my-posh -Name Set-PoshPrompt)) {
    Set-PoshPrompt -Theme powerlevel10k_modern
}
Write-Host (Get-Date -Format HH:mm:ss.ffff) 'Import VisualStudio Environment'
if ([bool] (Get-Command -Module WintellectPowerShell -Name Import-VisualStudioEnvironment)) {
    Import-VisualStudioEnvironment
}
