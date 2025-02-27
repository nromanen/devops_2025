#Level 1 (50 points):

# Prompt the user to enter their name
$name = Read-Host "Please enter your name"

# Greet the user
Write-Output "Hello, $name!"

#Level 2 (70 points):

# Prompt the user to enter two numbers
do {
    $number1 = Read-Host "Please enter valid first number"
} until ($number1 -match '^\d+$')

do {
    $number2 = Read-Host "Please enter valid second number"
} until ($number2 -match '^\d+$')

# Function to add two numbers
function Add-Numbers {
    param (
        [int]$num1,
        [int]$num2
    )
    $sum = $num1 + $num2
    Write-Output "Sum is: $sum"
}

# Validate and call the function
try {
    if (-not ($number1 -match '^\d+$') -or -not ($number2 -match '^\d+$')) {
        throw "The user did not enter a number"
    }
    Add-Numbers -num1 $number1 -num2 $number2
} catch {
    Write-Error $_.Exception.Message
}

#Level 3 (100 points):

# Create hash tables for fruit names and quantities
$fruitNames = @{
    1 = "apple"
    2 = "pear"
    3 = "peach"
    4 = "banana"
    5 = "orange"
    6 = "grape"
    7 = "kiwi"
    8 = "mango"
    9 = "pineapple"
    10 = "strawberry"
}

$fruitQuantities = @{
    1 = 4
    2 = 3
    3 = 1
    4 = 6
    5 = 5
    6 = 2
    7 = 7
    8 = 8
    9 = 9
    10 = 10
}

# вумntity
foreach ($id in $fruitQuantities.Keys) {
    $fruitName = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]
    Write-Output "$fruitName : $quantity"
}