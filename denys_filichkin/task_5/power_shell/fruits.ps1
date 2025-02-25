#!/usr/bin/env pwsh
$fruitNames = @{
    1 = "Apple"
    2 = "Pear"
    3 = "Peach"
    4 = "Banana"
    5 = "Orange"
    6 = "Grapes"
    7 = "Pineapple"
    8 = "Mango"
    9 = "Watermelon"
    10 = "Strawberry"
}

$fruitQuantities = @{
    1 = 4
    2 = 3
    3 = 1
    4 = 6
    5 = 8
    6 = 10
    7 = 2
    8 = 5
    9 = 7
    10 = 9
}

foreach ($id in $fruitQuantities.Keys | Sort-Object) {
    $fruitName = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]
    Write-Output "${fruitName}: ${quantity}"
}


