## Працюю на віртуальной машині по OS Oracle Linux Server release 9.5
### Посилання на гугл диск https://drive.google.com/drive/folders/1DgAIP_C0xyBoQcYH2Ktu2YDeWXgqXzdf?usp=sharing

- Додаємо користувача з вашим ім'ям до операційної системи
```useradd -m denysfv```

- перевиряемо чи додався користувач
```id denysfv```

- Призначити користувача до кореневої групи (з наданням адміністративних привілеїв)
```usermod -aG wheel denysfv```
```usermod -aG root denysfv```
> дивимось чи додався користувач до групи
```groups denysfv```

- заходимо під root правами
```su denysfv```

- Створіть теку з вашим ім'ям у домашньому каталозі
```mkdir ~/denys```

- У цій теці створіть файл, названий вашим прізвищем
```touch ~/denys/filichkin.t```

- Створіємо символічне посилання, що вказує на файл вашого прізвища
```ln -s ~/denys/filichkin.t ~/filichkin_ln```

- Скопіюйте файл прізвища до кореневого каталогу
```sudo cp ~/denys/filichkin.t /filichkin_cp```
> перевиремо
```ls -l /```

- Змінюємо власника скопійованого файлу на root і змініть його права доступу 
```sudo chown root:root /filichkin_cp```
```sudo chmod 644 /filichkin_cp```
> Перевірюю зміни
```ls -l /filichkin_cp```

- Створю нову групу з назвою students і додайю до неї мого користувача
```sudo groupadd students```
```sudo usermod -aG students denys```
> Маємо членство в групі
```groups denysfv```

- Створюю стислу резервну копію файлу мого прізвища за допомогою tar
```tar -czvf ~/filichkin_backup.tar.gz ~/denys/filichkin.t```
> перевиремо присутність архива
```ls -lh ~/filichkin_backup.tar.gz```

- Алізую використання диска домашнього каталогу та знаходжу 5 найбільших файлів/тек
```du -ah ~ | sort -rh | head -5```

- За допомогою команду find, щоб знайти всі файли, змінені за останні 7 днів
```find ~ -type f -mtime -7```

- Остані перевірки 
```ls -l```
```ls -l /filichkin_cp```