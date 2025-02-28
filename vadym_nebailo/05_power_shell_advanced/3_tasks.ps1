$fruitNames = @{
    1 = "Apple"
    2 = "Pear"
    3 = "Peach"
    4 = "Banana"
    5 = "Orange"
    6 = "Strawberry"
    7 = "Lemon"
    8 = "Ananas"
    9 = "Mango"
    10 = "Melon"
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
    10 = 3
}


foreach ($id in $fruitQuantities.Keys) {
    $name = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]

    Write-Host ("{0}: {1}" -f $name, $quantity)
}