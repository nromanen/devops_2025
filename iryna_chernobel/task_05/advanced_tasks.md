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

## Level 3
```
$fruitNames = @{
    1 = "apple";
    2 = "pear";
    3 = "peach";
    4 = "banana";
    5 = "orange";
    6 = "mango";
    7 = "kiwi";
    8 = "pineapple";
    9 = "grape";
    10 = "plum";
}
$fruitQuantities = @{
    1 = 4;
    2 = 3;
    3 = 1;
    4 = 7;
    5 = 6;
    6 = 2;
    7 = 5;
    8 = 8;
    9 = 12;
    10 = 9;
}
foreach ($id in $fruitQuantities.Keys) {
    $fruitName = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]

    Write-Host "$fruitName : $quantity"
}
```

 ## Result:

 ```
plum : 9
grape : 12
pineapple : 8
kiwi : 5
mango : 2
orange : 6
banana : 7
peach : 1
pear : 3
apple : 4
```
  ---

Screanshots: https://drive.google.com/file/d/1-ssxW4H4S8cUZ26OM3lrrQoBNGx6BYwp/view?usp=drive_link