$port = 8085
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
try {
    $listener.Start()
    Write-Host "Servidor ativo em http://localhost:$port/"
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $response = $context.Response
        try {
            $path = $context.Request.Url.LocalPath
            if ($path -eq "/" -or $path -eq "/index.html") {
                $content = [System.IO.File]::ReadAllText("index.html", [System.Text.Encoding]::UTF8)
                $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
                $response.ContentType = "text/html; charset=utf-8"
                $response.ContentLength64 = $buffer.Length
                $response.OutputStream.Write($buffer, 0, $buffer.Length)
            } else {
                $response.StatusCode = 404
            }
        } catch {
            $response.StatusCode = 500
        }
        $response.Close()
    }
} catch {
    Write-Host "ERRO: $($_.Exception.Message)"
} finally {
    if ($null -ne $listener) { $listener.Stop() }
}
