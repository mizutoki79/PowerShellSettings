# this depend on posh-git
# import posh-git module before this imported
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    
    # # Reset color, which can be messed up by Enable-GitColors
    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
    $promptCurrentDateTime = "$(Get-Date -Format 'MM/dd HH:mm:ss')"
    $promptPath = (Get-Location).Path.Trim('\').Replace($env:USERPROFILE, '~')
    $PathLeaf = [System.Math]::Min($promptPath.Length, $(Split-Path -Path $promptPath -Leaf).Length)
    $currentRawUI = (Get-Host).ui.RawUI
    $promptLimitLength = [System.Math]::Min($currentRawUI.BufferSize.Width, $currentRawUI.WindowSize.Width)
    if ($promptCurrentDateTime.Length + $PathLeaf.Length + 3 -le $promptLimitLength) {
        $promptPathLimitLength = $promptLimitLength - $promptCurrentDateTime.Length - 1
        if (($promptPath.Length -gt $promptPathLimitLength)) {
            if ($promptPath.Split('\').Count -gt 3) {
                $currentLocation = $promptPath
                if ($promptPath.ToString().Contains('~')) {
                    $pathQualifier = '~'
                }
                else {
                    $pathQualifier = Split-Path $promptPath -Qualifier
                }
                $PathLeaf = (Split-Path $promptPath -Parent | Split-Path -Leaf) + '\' `
                    + (Split-Path $promptPath -Leaf)
                if ($PathLeaf.Length -le $promptPathLimitLength - $pathQualifier.Length - 5) {
                    $promptPath = $pathQualifier + '\...'
                    $substringStart = $currentLocation.Length - $promptPathLimitLength + $promptPath.Length
                    $substringLength = $promptPathLimitLength - $promptPath.Length - $PathLeaf.Length
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
                elseif (($PathLeaf = Split-Path -Path $PathLeaf -Leaf).Length -le $promptPathLimitLength) {
                    $promptPath = "[$PathLeaf]"
                }
            }
        }
        $prompt = Write-Prompt -Object $promptCurrentDateTime -BackgroundColor ([System.ConsoleColor]::DarkGray) -ForegroundColor ([System.ConsoleColor]::White)
        $prompt += Write-Prompt -Object ' '
        $prompt += Write-Prompt -Object $promptPath -ForegroundColor ([System.ConsoleColor]::Green) 
        $prompt += Write-Prompt -Object "`nPS"
        if ($promptLimitLength -gt 30) {
            $prompt += Write-VcsStatus
        }
    }
    elseif (($promptLeaf = (Split-Path -Path $promptPath -Leaf)).Length -le $promptLimitLength - 5) {
        $prompt = Write-Prompt -Object "[$promptLeaf]" -ForegroundColor ([System.ConsoleColor]::Green)
        $prompt += Write-Prompt -Object "`nPS"
    }
    else {
        $prompt = Write-Prompt -Object 'PS'
    }
    if ($prompt) {"$prompt> "} else {"> "}
    $global:LASTEXITCODE = $realLASTEXITCODE
}
