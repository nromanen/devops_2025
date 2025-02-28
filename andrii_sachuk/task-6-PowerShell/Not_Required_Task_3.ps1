$fruitNames = @{
   1 = "Apple"
   2 = "Banana"
   3 = "Orange"
   4 = "Pear"
   5 = "Peach"
   6 = "Grapes"
   7 = "Pineapple"
   8 = "Strawberry"
   9 = "Cherry"
   10 = "Mango"
}

$fruitQuantities = @{
   1 = 5
   2 = 3
   3 = 8
   4 = 2
   5 = 4
   6 = 6
   7 = 1
   8 = 9
   9 = 7
   10 = 10
}

foreach ($id in $fruitQuantities.Keys) {
   $name = $fruitNames[$id]
   $quantity = $fruitQuantities[$id]
   Write-Host "$name: $quantity"
}