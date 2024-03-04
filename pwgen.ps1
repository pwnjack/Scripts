param(
    [int]$l = 12,
    [switch]$n
)

function Generate-StrongPassword {
    param(
        [int]$l,
        [switch]$n
    )

    $passwordChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    if (-not $n) {
        $passwordChars += "!@#$%^&*()_+-=[]{}|;':,.<>/?"
    }

    $password = -join (1..$l | ForEach-Object { Get-Random -Maximum $passwordChars.Length } | ForEach-Object { $passwordChars[$_ - 1] })
    Write-Output $password
}

Generate-StrongPassword -l $l -n:$n