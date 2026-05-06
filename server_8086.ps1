$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8086/")
try {
    $listener.Start()
    Write-Host "Servidor ativo em http://localhost:8086/"
    Write-Host "Pressione Ctrl+C para encerrar."
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $response = $context.Response
        $html = [System.IO.File]::ReadAllText("c:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main\index.html")
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
        $response.ContentType = "text/html; charset=utf-8"
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.Close()
    }
} catch {
    Write-Host "ERRO: $($_.Exception.Message)"
} finally {
    if ($null -ne $listener) { $listener.Stop() }
}
