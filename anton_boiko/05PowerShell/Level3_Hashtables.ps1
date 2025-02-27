#!/usr/bin/env pwsh

$fruitNames = @{ 1 = "apple"; 2 = "pear"; 3 = "peach"; 4 = "grape"; 5 = "banana"; 6 = "mango"; 7 = "avocado"; 8 = "lemon"; 9 = "orange"; 10 = "tangerine"; 11 = "nectarine"; 12 = "grapefruit"}


$fruitQuantities = @{ 1 = 75; 2 = 64; 3 = 53; 4 = 49; 5 = 66; 6 = 90; 7 = 24; 8 = 36; 9 = 44; 10 = 33; 11 = 37; 12 = 40}


foreach ($id in $fruitQuantities.Keys) {
    $name = $fruitNames[$id]
    $quantity = $fruitQuantities[$id]
    Write-Host ("{0, -12} {1}" -f $name, $quantity)
}