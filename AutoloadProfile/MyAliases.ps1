Set-Alias -Name ea -Value Expand-Archive
Set-Alias -Name gfh -Value Get-FileHash
Set-Alias -Name wrh -Value Write-Host
Set-Alias -Name cro -Value Compare-Object
Set-Alias -Name sco -Value Select-Object
Set-Alias -Name jpa -Value Join-Path
Get-Verb | ForEach-Object {New-Alias -Name ($_.Verb + '-') -Value Out-Null -Description 'TAB補完用ダミーalias' -Option ReadOnly -ErrorAction SilentlyContinue}
