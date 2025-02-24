# Advanced Tasks on PowerShell

>Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)  

## Preparation

Ensuring we **can run scripts** in PowerShell:  

1. `Get-ExecutionPolicy` to check,  

2. `Set-ExecutionPolicy RemoteSigned` and then `Y` if needed.  

> For return to the default state (that does not allow running scripts:  
`Set-ExecutionPolicy Restricted`, then `A`).  

---

## Level 1

### Task lv.1

Prompt the user to enter their name.  
Greet the user by printing "Hello, [name]!" to the console.  

### Solution lv.1

```pwsh
$name = Read-Host "Enter your name"
Write-Host "Hello, $name!"
```

#### Output lv.1

> The simplicity of the task does not require the usage of a script, so I performed it in the PowerShell directly.  

```pwsh
Enter your name: Lians
Hello, Lians!
```

---

## Level 2

### Task lv.2

Prompt the user to enter two numbers.  
Write a function that accepts two parameters, two numbers.  
Call this function by passing it the data entered by the user.  
This function should add two numbers and print result for example: "Sum is: 10"  
If the user enters a non-numeric value for the numbers, throws exception with message "The user did not enter a number"  

### Solution lv.2

```pwsh
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

```

#### Output lv.2

```pwsh
Enter two numbers: 49 -7
Sum is: 42
```

#### Notes

`[int]` is an alias for `[Int32]` .NET type.  

`TryParse` is a *statuc method* from *int* .NET type.  
It has two parameters:  

1. **first**: a string to convert;  

2. **second**: a reference variable (will store the converted value).  

---

## Level 3

### Task lv.3

Create two hash tables: $fruitNames, where the key is an ID (e.g., 1, 2, 3) and the value is the fruit name (e.g., 1: "apple", 2: "pear", 3: "peach"), and $fruitQuantities, where the key is the ID and the value is the quantity of each fruit (e.g., 1: 4, 2: 3, 3: 1). and populate it with at least ten different fruits.  
Next, iterate through $fruitQuantities using a loop and print the fruit name along with the corresponding quantity. Retrieve the fruit name from $fruitNames using the current ID from the iteration.  

### Solution lv.3

```pwsh
#!/usr/bin/env pwsh

# Creating first hash table
$fruitNames = @{}

# Array to later populate that hashtable
$fruits = @("apple", "mango", "banana", "kiwi", "orange", "lemon", "pear", "peach", "apricot", "plum")
$id = 0

# Populating $fruitNames
foreach ($fruit in $fruits) {
    $fruitNames.add($id, $fruit)
    $id++
}

# Making second hashtable
$fruitQuantities = @{}

for ($i = 0; $i -lt 10; $i++) {
    $quantity = Get-Random -Minimum 1 -Maximum 21 # max = 20
    $fruitQuantities.add($i, $quantity)
}

# Iterating $fruitQuantities & printing desired output
foreach ($_ in $fruitQuantities.Keys) {
    $quan = $fruitQuantities[$_]
    $name = $fruitNames[$_]
    Write-Output "${name}: ${quan}"
}

```

#### Output lv.3

```pwsh
plum: 2
apricot: 7
peach: 12
pear: 8
lemon: 2
orange: 1
kiwi: 4
banana: 5
mango: 7
apple: 18
```
