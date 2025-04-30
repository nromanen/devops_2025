# Prompt the user to enter their name
$name = Read-Host "Please enter your name"
Clear-Host
# Greet the user
Write-Output "Hello, $name!"
# Level 2 

function Add-Numbers {
    param (
        [Parameter(Mandatory=$true)]
        [string]$num1,
        
        [Parameter(Mandatory=$true)]
        [string]$num2
    )
    
    if (-not ($num1 -match "^-?\d+(\.\d+)?$" -and $num2 -match "^-?\d+(\.\d+)?$")) {
        throw "The user did not enter a number"
    }
    
    $n1 = [double]$num1
    $n2 = [double]$num2
    $sum = $n1 + $n2
    Write-Output "Sum is: $sum"
}

# Prompting user for input
$num1 = Read-Host "Enter the first number"
$num2 = Read-Host "Enter the second number"

# Calling the function
try {
    Add-Numbers -num1 $num1 -num2 $num2
} catch {
    Write-Output $_
}

# Creating hash tables
$fruitNames = @{
    1 = "Apple"; 2 = "Pear"; 3 = "Peach"; 4 = "Banana"; 5 = "Grapes";
    6 = "Mango"; 7 = "Orange"; 8 = "Strawberry"; 9 = "Pineapple"; 10 = "Cherry"
}

$fruitQuantities = @{
    1 = 4; 2 = 3; 3 = 1; 4 = 6; 5 = 10;
    6 = 2; 7 = 7; 8 = 5; 9 = 3; 10 = 8
}

# Iterating through fruit quantities and printing fruit names with their quantities
foreach ($id in $fruitQuantities.Keys) {
    $fruitName = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]
    Write-Output ("{0}: {1}" -f $fruitName, $quantity)
}
