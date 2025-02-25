## 1: Greeting the User

```powershell
$name = Read-Host "Enter your name"
Write-Output "Hello, $name!"
```

**Example Output:**
```
Enter your name: Polina
Hello, Polina!
```

---

## 2: Adding Two Numbers with Exception Handling

```powershell
function Add-Numbers {
    param (
        [double]$num1,
        [double]$num2
    )
    $sum = $num1 + $num2
    Write-Output "Sum is: $sum"
}

try {
    $num1 = Read-Host "Enter the first number"
    $num2 = Read-Host "Enter the second number"

    $num1 = [double]::Parse($num1)
    $num2 = [double]::Parse($num2)

    Add-Numbers -num1 $num1 -num2 $num2
}
catch {
    Write-Output "The user did not enter a number"
}
```

**Example Output (Valid Input):**
```
Enter the first number: 1
Enter the second number: 2
Sum is: 3
```

**Example Output (Invalid Input):**
```
Enter the first number: hello
Enter the second number: world
The user did not enter a number
```


---

## 3: Hash Tables for Fruit Inventory

```powershell
$fruitNames = @{
    1 = "apple"
    2 = "pear"
    3 = "peach"
    4 = "banana"
    5 = "grape"
}

$fruitQuantities = @{
    1 = 4
    2 = 3
    3 = 1
    4 = 7
    5 = 5
}

foreach ($id in $fruitQuantities.Keys) {
    $fruitName = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]
    Write-Output "$($fruitName): $($quantity)"
}
```

**Example Output:**
```
grape: 5
banana: 7
peach: 1
pear: 3
apple: 4
```

---

Screanshots : https://drive.google.com/drive/folders/1CalD9FSXj4nA2AwF5MVD008A5o3Ho3XT?usp=sharing