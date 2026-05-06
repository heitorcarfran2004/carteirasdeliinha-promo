$filePath = 'c:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main\index.html'
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# Remove the HTML block from <!-- HERO --> to just before <!-- OFERTA -->
$content = $content -replace '(?s)<!-- HERO -->.*?<!-- OFERTA -->', '<!-- OFERTA -->'

# Update the CTA FINAL button
$content = $content -replace 'onclick="document.getElementById\(''planos''\).scrollIntoView\(\{behavior:''smooth''\}\)"', 'onclick="window.open(''https://ggcheckout.app/checkout/v5/b5cxxDojvaL8Hl8kfJEY'', ''_blank''); return false;"'

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host 'Done!'
