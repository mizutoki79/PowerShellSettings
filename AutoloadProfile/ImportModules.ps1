$modules =
    'posh-git',
    'WintellectPowerShell',
    'oh-my-posh'

$subDirectory = '.\Dipendency'
$availableModules = Get-Module -ListAvailable | Where-Object -Property Name -Match ($modules -join '|')

foreach ($module in $modules) {
    $target = $availableModules `
        | Where-Object -Property Name -Match $module `
        | Sort-Object -Property Version -Descending `
        | Select-Object -Index 0
    Import-Module $target
    if ((Test-Path -Path $subDirectory) -and [bool] (Get-Module -Name $module)) {
        Get-ChildItem -LiteralPath $subDirectory -Include $module | Get-ChildItem | ForEach-Object {& $_.FullName}
    }
}

