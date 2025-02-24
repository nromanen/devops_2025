#!/usr/bin/env pwsh

# Creating first hash table
$fruitNames = @{}

# Array to later populate that hashtable
$fruits = @("apple", "mango", "banana", "kiwi", "orange", "lemon", "pear", "peach", "apricot", "plum")
$id = 0

# Populating $fruitNames
$fruitNames = @{}
$fruits | ForEach-Object -Begin {$i=0} -Process { $fruitNames[$i++] = $_ }

# Creating second hashtable with random quantities (1-20)
$fruitQuantities = @{}

# Populating $fruitQuantities
0..9 | ForEach-Object { $fruitQuantities[$_] = Get-Random -Minimum 1 -Maximum 21 }

# Display fruit names and their quantities
foreach ($id in $fruitQuantities.Keys) {
    $quantity = $fruitQuantities[$id]
    $name = $fruitNames[$id]
    Write-Output "$name`: $quantity"
}
