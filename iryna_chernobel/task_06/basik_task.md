# Регулярний вираз для пошуку
```
$ grep -E '\bsudo[^ ]*@[^ ]+\.org\b' user_data.txt
```

## Результат
```
5, David, Miller, sudo_david+-millersell@ya2hoo.org, 23456
7, James, Anderson, sudojamesanderson@hotmaI_l.org, 34567
15, Noah, Scott, sudonoah_+scott@yahoo.org, 90876
```