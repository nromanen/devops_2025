## Level 1
```
$name = Read-Host "Enter your name"
Write-Host "Hello, $name!"
 ```
 ## Result:
 ```
 Enter your name: iryna
 Hello, iryna!
  ```
  ---

Screanshots: https://drive.google.com/file/d/1Ll5iB8mvMcuQicFhPfWoRtWhQbET64-o/view?usp=drive_link

## Level 2
```
function Add-Numbers {
    param (
        [string]$num1,
        [string]$num2
    )

    if ($num1 -match '^\d+(\.\d+)?$' -and $num2 -match '^\d+(\.\d+)?$') {
        $sum = [double]$num1 + [double]$num2
        Write-Host "Sum is: $sum"
    } else {
        throw "The user did not enter a number"
    }
}

try {
    $num1 = Read-Host "Enter first number"
    $num2 = Read-Host "Enter second number"
    
    Add-Numbers $num1 $num2
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
```
## Positive result 
```
Enter first number: 7
Enter second number: 3
Sum is: 10
```
  ---

Screanshots: https://drive.google.com/file/d/1Dm009HcsVGpg3f1GatWKLQF1rXKYeMVM/view?usp=drive_link

## Negative result
```
Enter first number: day
Enter second number: 2
Error: The user did not enter a number
```
  ---

Screanshots: https://drive.google.com/file/d/1RXr4gza2hY-19n203DeQiHwfr8puRRgx/view?usp=drive_link