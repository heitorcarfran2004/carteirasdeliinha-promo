$port = 8084
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Listening on http://localhost:$port/"
[Environment]::CurrentDirectory = 'C:\Users\thorz\Downloads\carteirasdeliinha-main\carteirasdeliinha-main'
while ($listener.IsListening) {
    $context = $listener.GetContext()
    $response = $context.Response
    try {
        $path = $context.Request.Url.LocalPath
        if ($path -eq "/" -or $path -eq "/index.html") {
            $buffer = [System.IO.File]::ReadAllBytes("index.html")
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
