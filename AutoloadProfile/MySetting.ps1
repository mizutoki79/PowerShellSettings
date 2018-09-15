if ([System.Environment]::OSVersion.Platform.ToString().Contains('Win')) {
    chcp 65001
}
Set-PSReadlineOption -BellStyle Visual
# Ctrl + D to Exit
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
