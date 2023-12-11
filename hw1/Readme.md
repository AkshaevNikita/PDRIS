script.sh объявляет команды START, STATUS, STOP

monitoring_script.sh достает информацию об утилизации CPU с помощью команды top и помещает в файл monitoring_results.csv каждые 10 секунд

Для начала нужно дать права на исполнение

```sh
cmod +x ./script.sh
chmod +x ./monitoring_script.sh
```
Использование скрипта
```sh
./script.sh (START|STATUS|STOP)
```
Просмотр результатов
```sh
cat monitoring_results.csv
```
