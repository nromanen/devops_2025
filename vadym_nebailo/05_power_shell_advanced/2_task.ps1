function AddTwoNumbers {
    param (
        [double]$number1,
        [double]$number2
    )

    $sum = $number1 + $number2
    Write-Host "Sum is: $sum"
}


$first = Read-Host "Enter first number" 
$second = Read-Host "Enter second number"

if (-not ($first -match '^\d+(\.\d+)?$') -or -not ($second -match '^\d+(\.\d+)?$')) {
    Write-Host "Error: There no numbers"
} else {
    AddTwoNumbers $first $second
}