#!/usr/bin/env pwsh

$inp = Read-Host "Enter two numbers"

$numbers = $inp -split " " # split into an array

# Check if were exactly two arguments provided
if ($numbers.Count -ne 2) {
    Write-Error "Enter exactly TWO numbers"
    exit 1
}

# Initialize x & y to hold references later
[int]$x = 0
[int]$y = 0

# Convert to numbers (and raise an error if fails)
if (-not [int]::TryParse($numbers[0], [ref]$x) -or 
    -not [int]::TryParse($numbers[1], [ref]$y)) {
    Write-Error "The user did not enter a number"
    exit 1
}

# Creating a function with two parameters
function Sum { 
    param(
        [int]$a,
        [int]$b
    )
    $sum = ($a + $b)
    Write-Output "Sum is: $sum"
}

Sum $x $y
