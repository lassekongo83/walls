$inputDir = "svg"
$outputDir4K = "png\4k"
$outputDir1080 = "png\1080"

New-Item -ItemType Directory -Force -Path $outputDir4K, $outputDir1080 | Out-Null

if (-not (Get-Command "inkscape" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Inkscape is not installed or not in the system path."
    exit 1
}

# Export 4K
Get-ChildItem "$inputDir\*.svg" | ForEach-Object {
    $filename = $_.BaseName
    & inkscape $_.FullName `
        --export-type="png" `
        --export-width=3840 `
        --export-height=2160 `
        --export-filename="$outputDir4K\$filename`_4k.png"
    Write-Host "✅ Exported 4K: $filename`_4k.png"
}

# Export 1080p
Get-ChildItem "$inputDir\*.svg" | ForEach-Object {
    $filename = $_.BaseName
    & inkscape $_.FullName `
        --export-type="png" `
        --export-width=1920 `
        --export-height=1080 `
        --export-filename="$outputDir1080\$filename.png"
    Write-Host "✅ Exported 1080p: $filename.png"
}
