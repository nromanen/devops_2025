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
