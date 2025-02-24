# Регулярний вираз для пошуку
```
 grep -E '^[^,]+,[^,]+,[^,]+,[^,]+@[a-zA-Z0-9.-]+\.com,[^!№%:?@#$]+$' user_data_task2.txt | grep -Ev '@[^[:alnum:]]' | 
grep -Ev '\.\.' | grep -Ev '[^a-zA-Z0-9._-]@'
```
## [^!№%:?@#$] додала додаткові символи, крім тих що є в умові завдання @#$ - для того щоб точно визначити слабкий пароль

## Результат
```
1, Bob, Sinkler, sudobobbsinnn@gmail.com, 12345
3, Michael, Thompson, mthompson@hotmail.com, 54&321
4, Sarah, Williams, sarahwills@gmail.com, 98765
6, Emily, Davis, emilydavis@gmail.com, 87654
```