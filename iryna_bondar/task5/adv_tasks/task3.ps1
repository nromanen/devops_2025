#!/usr/bin/env pwsh

$fruitNames = @{"1"="apple"; "2"="pear"; "3"="peach"; "4"="cucumber"; "5"="kartoxa"; "6"="baklajan"; "7"="the pomidor"; "8"="onion"; "9"="garlic"; "10"="pepper"}
$fruitQuantities = @{"10"=1; "9"=2; "8"=3; "7"=4; "6"=5; "5"=6; "4"=7; "3"=8; "2"=9; "1"=10}

foreach ($fruit in $fruitQuantities.Keys) {
    $fruitName = $fruitNames[$fruit]
    $quantity = $fruitQuantities[$fruit]
    Write-Host "${fruitName}: ${quantity}"
}
