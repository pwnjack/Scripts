# Load the .env file and extract the API key
$envPath = Join-Path -Path $PSScriptRoot -ChildPath ".env"
Get-Content $envPath | ForEach-Object {
    $key, $value = $_.Split('=',2)
    Set-Item -Path env:$key -Value $value
}
$apiKey = $env:OPENAI_API_KEY

$headers = @{
    "Authorization" = "Bearer $apiKey"
    "Content-Type" = "application/json"
}

$uri = "https://api.openai.com/v1/chat/completions"

function Send-MessageToOpenAI {
    param(
        [string]$userInput
    )

    $body = @{
        model = "gpt-3.5-turbo"
        messages = @(
            @{
                role = "system"
                content = "You are a helpful assistant."
            },
            @{
                role = "user"
                content = $userInput
            }
        )
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -Headers $headers
    return $response.choices[0].message.content
}

Clear-Host
Write-Host "OpenAI Chat - Type 'exit' to quit."
do {
    $userInput = Read-Host "You"
    if ($userInput -eq 'exit') {
        break
    }
    $response = Send-MessageToOpenAI -userInput $userInput
    Write-Host "AI: $response"
} while ($true)