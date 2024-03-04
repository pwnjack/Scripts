param(
    [string]$crypto = "BTC",
    [string]$currency = "USD"
)

function Get-CryptoSpotValue {
    param(
        [string]$cryptoCurrency,
        [string]$currencyValue
    )

    $uri = "https://api.coinbase.com/v2/prices/$($cryptoCurrency.ToUpper())-$($currencyValue.ToUpper())/spot"
    #Write-Host "Requesting URI: $uri" # Debugging line to check the constructed URI
    try {
        $response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{"Accept"="application/json"}
        $spotValue = $response.data.amount
        Write-Output "The current spot value of $cryptoCurrency in $currencyValue is $spotValue"
    }
    catch {
        Write-Output "Failed to retrieve data for $cryptoCurrency in $currencyValue. Please check the symbols and try again."
        Write-Host "Error details: $_" # Debugging line to print error details
    }
}

Get-CryptoSpotValue -cryptoCurrency $crypto -currencyValue $currency