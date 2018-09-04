if (Test-Path -Path Alias:cd) {
    Remove-Item -Path Alias:cd -Force
}
function cd {
    param (
        [string]
        $Path,
        [string]
        $LiteralPath,
        [switch]
        $PassThru,
        [string]
        $StackName
    )
    begin {
        if ((($Path.Length -gt 0) -and (Test-Path -Path $Path) `
                    -and [bool](Compare-Object -ReferenceObject (Get-Location).Path -DifferenceObject (Resolve-Path -Path $Path).Path)) `
                -or ($Path.Length -eq 0 `
                    -and [bool](Compare-Object -ReferenceObject (Get-Location).Path -DifferenceObject $env:USERPROFILE))) {
            Push-Location
        }
    }
    process {
        if ($Path.Length -gt 0) {
            if ($PassThru) {
                Set-Location -Path $Path -PassThru $PassThru
            }
            else {
                Set-Location -Path $Path
            }
        }
        elseif ($LiteralPath.Length -gt 0) {
            if ($PassThru) {
                Set-Location -LiteralPath $LiteralPath -PassThru $PassThru
            }
            else {
                Set-Location -LiteralPath $LiteralPath
            }
        }
        elseif ($StackName.Length -gt 0) {
            if ($PassThru) {
                Set-Location -PassThru -StackName $StackName
            }
            else {
                Set-Location -StackName $StackName
            }
        }
        else {
            Set-Location -Path $env:USERPROFILE
        }
    }
}
if (Test-Path -Path Alias:sl) {
    Remove-Item -Path Alias:sl -Force
}
Set-Alias -Name sl -Value cd

function su() {Start-Process -FilePath "powershell" -Verb runAs -Wait}
# for example, [sudo "Get-Process | Where-Object {`$_.Name -eq 'powershell'}"]
function sudo ($argslist) {
    Start-Process -FilePath 'powershell' -ArgumentList "-noexit -command $argslist" -WorkingDirectory (Get-Location) -Verb runAs -Wait
}