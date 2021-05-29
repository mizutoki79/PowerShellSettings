Write-Host (Get-Date -Format "HH:mm:ss.ffff") 'Set for oh-my-posh...'
if ([bool] (Get-Module -Name 'oh-my-posh') -and (Test-Path -Path Function:Set-PoshPrompt)) {
    Set-PoshPrompt -Theme powerlevel10k_modern
}
