$zedConfig = "$env:APPDATA\Zed"
$files = @("settings.json", "keymap.json", "tasks.json")

foreach ($file in $files) {
    $target = "$PWD\$file"
    $link = "$zedConfig\$file"

    if (-not (Test-Path $target)) {
        Write-Warning "Skipping $file — not found in current directory"
        continue
    }

    if (Test-Path $link) {
        Remove-Item $link -Force
    }

    New-Item -ItemType SymbolicLink -Path $link -Target $target | Out-Null
    Write-Host "Linked $file -> $target"
}
