$modules =
    'posh-git',
    'WintellectPowerShell',
    'oh-my-posh',
    'AWSPowerShell.NetCore'

Push-Location -Path $autoloadDir
$subDirectory = '.\Dependency'
$availableModules = Get-Module -ListAvailable `
    | Where-Object -Property Name -Match ($modules -join '|') `
    | Sort-Object -Property Version -Descending `
    | Get-Unique

foreach ($target in $availableModules) {
    Import-Module $target
    if ((Test-Path -Path $subDirectory) -and [bool] (Get-Module -Name $target)) {
        Get-ChildItem -LiteralPath $subDirectory -Include $module | Get-ChildItem | ForEach-Object {& $_.FullName}
    } else {
        Write-Host (Get-Location)
    }
}

'modules', 'subDirectory', 'availableModules', 'target' | ForEach-Object -Process {Remove-Variable -Name $_}
Pop-Location
