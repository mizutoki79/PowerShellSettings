$modules =
    'posh-git',
    'oh-my-posh',
    'WintellectPowerShell'

Push-Location -Path $autoloadDir

Write-Host (Get-Date -Format "HH:mm:ss.ffff") 'Search modules...'

$subDirectory = '.\Dependency'
$availableModules = Get-Module -ListAvailable `
    | Where-Object -Property Name -Match ($modules -join '|') `
    | Sort-Object -Property Version -Descending `
    | Get-Unique

Write-Host (Get-Date -Format "HH:mm:ss.ffff") 'Import modules...'

foreach ($target in $availableModules) {
    if (![bool] (Get-Module -Name $target)) {
        Import-Module $target
    }
}

Write-Host (Get-Date -Format "HH:mm:ss.ffff") "Set additional modules' preferences..."

if ((Test-Path -Path $subDirectory)) {
    Set-Location -Path $subDirectory
    Get-ChildItem | Get-ChildItem | ForEach-Object {.$_.FullName}
} else {
    Write-Host (Get-Location)
}

Write-Host (Get-Date -Format "HH:mm:ss.ffff") 'Cleaning...'

'modules', 'subDirectory', 'availableModules', 'target' | ForEach-Object -Process {Remove-Variable -Name $_}

Pop-Location

Write-Host
