$port = 8085
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
try {
    $listener.Start()
    Write-Host "Servidor rodando em http://localhost:$port/"
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $response = $context.Response
        $buffer = [System.IO.File]::ReadAllBytes("c:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main\index.html")
        $response.ContentType = "text/html; charset=utf-8"
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
        $response.Close()
    }
} catch {
    Write-Error $_.Exception.Message
} finally {
    $listener.Stop()
}
