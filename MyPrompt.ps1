# this depend on posh-git
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    
    # # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
    $promptCurrentDateTime = "$(Get-Date -Format 'MM/dd HH:mm:ss')"
    $promptPath = (Get-Location).Path.Trim('\').Replace($env:USERPROFILE, '~')
    $promptLimitLength = 30
    if (($promptPath.Length -gt $promptLimitLength) -and ($promptPath.Split('\').Count -gt 3)) {
        $currentLocation = $promptPath
        if ($promptPath.ToString().Contains('~')) {
            $pathQualifier = '~'
        }
        else {
            $pathQualifier = Split-Path $promptPath -Qualifier
        }
        $PathLeaf = (Split-Path $promptPath -Parent | Split-Path -Leaf) + '\' `
            + (Split-Path $promptPath -Leaf)
        $promptPath = $pathQualifier + '\...'
        $substringStart = $currentLocation.Length - $promptLimitLength + $promptPath.Length
        $substringLength = $promptLimitLength - $promptPath.Length - $PathLeaf.Length
        if ($substringLength -gt 0) {
            $promptPath = $pathQualifier + '\...' `
                + $currentLocation.Substring($substringStart, $substringLength) `
                + $PathLeaf
        }
        else {
            $promptPath = $pathQualifier + '\...\' `
                + $PathLeaf
        }
    }
    $prompt += Write-Prompt -Object $promptCurrentDateTime -BackgroundColor ([System.ConsoleColor]::DarkMagenta) -ForegroundColor ([System.ConsoleColor]:: White)
    $prompt += Write-Prompt ' '
    $prompt = Write-Prompt -Object $promptPath -ForegroundColor ([System.ConsoleColor]::Green) 
    $prompt += Write-Prompt "`nPS"
    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return '> '
}
