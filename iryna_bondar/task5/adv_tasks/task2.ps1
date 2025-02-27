#!/usr/bin/env pwsh

$num1 = [int](Read-Host 'Enter num 1')
$num2= [int](Read-Host 'Enter num 2')
$sum = $num1 + $num2
Write-Host "Sum is: $sum"
