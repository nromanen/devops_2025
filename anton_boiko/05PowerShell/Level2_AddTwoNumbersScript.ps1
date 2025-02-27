#!/usr/bin/env pwsh

function sumTwoNumbers {
    param (
        [int]$firstNumber,
        [int]$secondNumber
    )
    # Тіло функції
	$sum = $firstNumber + $secondNumber
    Write-Host "Sum is: $sum"
}

try {
$firstNumber = Read-Host "Enter first number" 
$secondNumber = Read-Host "Enter second number"
sumTwoNumbers $firstNumber $secondNumber

} catch {
    Write-Host "The user did not enter a number"
}