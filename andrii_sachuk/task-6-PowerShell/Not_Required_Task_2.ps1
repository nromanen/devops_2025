function Add-Numbers {
   param (
      [string]$num1,
      [string]$num2
   )

   if ($num1 -match '^\d+$' -and $num2 -match '^\d+$') {
      $sum = [int]$num1 + [int]$num2
      Write-Host "Sum is: $sum"
   } else {
      throw "The user did not enter a number"
   }
}

$num1 = Read-Host "Enter first number"
$num2 = Read-Host "Enter second number"

try {
   Add-Numbers -num1 $num1 -num2 $num2
} catch {
   Write-Host $_.Exception.Message
}