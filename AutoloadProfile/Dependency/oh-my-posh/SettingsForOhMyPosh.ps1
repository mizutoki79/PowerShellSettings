if ([bool] (Get-Module -Name 'oh-my-posh') -and (Test-Path -Path Function:Set-Theme)) {
    Set-Theme -name Paradox
}
