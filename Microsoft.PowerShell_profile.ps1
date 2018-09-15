if ($IsWindows) {
    $autoloadDir = Join-Path -Path ([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)) -ChildPath '\PowerShell\AutoloadProfile'
}
# is WSL. `ln -s /mnt/c/Users/(username)/Documents ~/Documents`
elseif ($IsLinux -and (uname --kernel-release).Contains('Microsoft')) {
    $autoloadDir = Join-Path -Path (readlink -f ~/Documents) -ChildPath '/PowerShell/AutoloadProfile'
}
else {
    $autoloadDir = Join-Path -Path (Split-Path -Path $PROFILE -Parent) -ChildPath '/AutoloadProfile'
}
Get-ChildItem $autoloadDir | Where-Object {$_.Extension -eq ".ps1"} | ForEach-Object {.$_.FullName}
