if (Test-Path -Path Alias:cd) {
    Remove-Item -Path Alias:cd -Force
}
function cd {
    param (
        [string]
        $Path
    )
    begin {
        if (($Path.Length -gt 0) -and (Test-Path -Path $Path)) {
            Push-Location -Path .
        }
    }
    process {
        if ($Path.Length -gt 0) {
            Set-Location -Path $Path
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