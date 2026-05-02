$filePath = 'c:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main\index.html'
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

$content = $content -replace '(?s)<!-- BÔNUS -->\s*<section class="secao-bonus">.*?</section>', ''

$garantiaRegex = '(?s)<!-- GARANTIA -->\s*<section class="secao-garantia">.*?</section>'
$garantiaMatch = [regex]::Match($content, $garantiaRegex)

if ($garantiaMatch.Success) {
    $garantiaText = $garantiaMatch.Value
    $content = $content -replace $garantiaRegex, ''
    
    $ofertaRegex = '(?s)(<!-- OFERTA -->\s*<section class="secao-oferta" id="planos">.*?</section>)'
    $content = $content -replace $ofertaRegex, "`${1}`r`n`r`n$garantiaText"
}

$content = $content.Replace('<p class="oferta-headline">Escolha seu Kit</p>', '<p class="oferta-headline">Espera! Não vá embora ainda</p>')
$content = $content.Replace('<p class="oferta-subheadline">Garanta seu acesso com desconto</p>', '<p class="oferta-subheadline">Antes de sair, liberamos uma oferta única do nosso pacote completo com desconto exclusivo. Mas é só agora!</p>')
$content = $content.Replace('<div class="oferta-label-badge">OFERTA EXCLUSIVA DE HOJE</div>', '<div class="oferta-label-badge">OFERTA EXCLUSIVA</div>')

$idx = $content.IndexOf('OFERTA EXCLUSIVA')
if ($idx -ge 0) {
    $idx2590 = $content.IndexOf('25,90', $idx)
    if ($idx2590 -ge 0) {
        $content = $content.Remove($idx2590, 5).Insert($idx2590, '8,90')
    }
}

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host 'Done!'
