$filePath = 'c:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main\index.html'
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# Remove the block from /* HERO */ to just before /* GARANTIA */
$content = $content -replace '(?s)/\* HERO \*/.*?/\* GARANTIA \*/', '/* GARANTIA */'

# Remove the block from /* B�NUS */ to just before /* ?? HERO ?? */ (if it exists)
# Wait, let's look for exactly where B�NUS is.
$content = $content -replace '(?s)/\* B�NUS \*/.*?/\* ?? HERO ?? \*/', '/* ?? HERO ?? */'

# Remove the block from /* ?? HERO ?? */ to just before /* ?? OFERTA ?? */
$content = $content -replace '(?s)/\* ?? HERO ?? \*/.*?/\* ?? OFERTA ?? \*/', '/* ?? OFERTA ?? */'

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host 'Done!'
