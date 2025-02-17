# Task 3

## The creation of the user account and group assignments.
1) На початку треба просто зайти в термінал машини. Роблю це через putty.
2) Зайшов, вводжу свої кредити (заходжу як root user)
3) Далі, команди створення користувача та додавання в групу:

```useradd tymofii```

```passwd tymofii```

```usermod -aG sudo tymofii```

Після цього перевіряємо групи користувача командою:

```groups tymofii```

## The contents of your home directory, displaying the folder and file you created.

Заходимо під новим користувачем ```tymofii``` та перевіряємо чи все успішно командою ```whoami```.

Робимо папку за допомогою ```mkdir tymofii```

Після цього перевіряємо вміст каталогу командою ```ls```

Створюємо пустий файл за допомогою ```touch```. Переконуємося, що файл є.

## The symbolic link demonstrating access to your last name file.

Створюєму лінку для файлу за допомогою команди ```ln -s```. Перевіряємо існування + права.
Є ```l``` на початку прав, що свідчить, що це лінк

Копіюємо командою ```sudo cp``` і вводимо пароль. Після цього перевіряємо результат операції і дивимося на права.

## The output showing the permission and ownership changes made to the copied file.

Далі, використовуємо команди ```sudo chown``` для зміни власника файлу та ```sudo chmod 644``` для встановлення доступу.

6 -> modify + read

1 -> execute

1 -> execute

Перевіряємо.

## Students Group

Створюємо групу ```students``` за допомогою команди ```sudo groupadd```. Додаємо юзера і перевіряємо результат

## tar

Створюємо бекап за допомогою команди ```tar``` флагами ```-czf```, де

c - новий архів

z - стиснення за допомогою gzip

f - ім'я

Перевіряємо.

## The output from the disk usage analysis and file search commands.

Виконуємо команду ```du```, щоб побачити використання пам'яті.
Після цього використовуємо команду з флажками для виводу 5 найбільших: ```du -h | head -n 5```

Також виводимо файли, які були редаговані за допомогою команди: ```find ~ -type f -mtime -7```


Скріншоти можна переглянути за посиланням:

https://drive.google.com/drive/u/0/folders/1HkrP1SWLtt2VTbBWad55lrdwaFlet1xE

Ресурс по флагам для tar:

https://www.geeksforgeeks.org/tar-command-linux-examples/

Ресурс по mtime:

https://stackoverflow.com/questions/25599094/explaining-the-find-mtime-command
