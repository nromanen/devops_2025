#!/usr/bin/env pwsh
# Level 2 (70 points):
function Add-Numbers {
    param (
        [double]$num1,
        [double]$num2
    )
    # Calculating the sum and displaying the result
    $sum = $num1 + $num2
    Write-Output "Sum is: $sum"
}

try {
    $num1 = Read-Host "Enter the first number"
    $num2 = Read-Host "Enter the second number"

    # to cheked
    if (-not ($num1 -match "^\d+(\.\d+)?$") -or -not ($num2 -match "^\d+(\.\d+)?$")) {
        throw "The user did not enter a number"
    }

    # call function
    Add-Numbers -num1 $num1 -num2 $num2

}
catch {
    Write-Output "Error: $_"
}

