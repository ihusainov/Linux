rsnapshot – Базирующаяся на rsync утилита на Perl для создания резервных копий. 
Особенностью является ориентация на создания полных снапшотов файловой системы через заданный интервал времени, для экономии места на диске, 
не изменившиеся с момента первого бэкапа файлы линкуются как hard link.


Установка

В Gentoo Linux для установки следует выполнить:

```
emerge app-backup/rsnapshot
```
Для установки в CentOS:

```
yum install rsnapshot
```

Настройка

Создание директории где будут храниться "снимки":

```
mkdir /var/snapshots
```
Необходимо скопировать шаблонную конфигурацию:

```
cp /etc/rsnapshot.conf.default /etc/rsnapshot.conf
```
Файл конфигурации:

	/etc/rsnapshot.conf

```
## Помните, что в конфигурационном файле недопустимы пробелы — используйте только табы.
## Директирия где будут находиться снимки
snapshot_root /var/snapshots/
## Для Linux систем необходимо разкомментировать сточку:
cmd_cp          /bin/cp
## Интервалы создания снимков. 
# Указывает тип снимка и сколько копий хранить
interval        hourly  6
interval        daily   7
interval        weekly  4
# будет храниться 6 ежечасных, 7 ежедневных и 4 еженедельных
## Настройка данных для архивации
# формат: цель для архивации | куда сохранять снимок (внутри папки snapshot_root)
# !!!ВАЖНО!!! указание завершающих слешей "/" в названии папок обязательно
backup  /home/          localhost/
backup  /etc/           localhost/
## Задание файлов исключений
exclude		*.tmp
exclude		~*
exclude		.git/
```


После изменения настроек следует выполнить их проверку:

```
rsnapshot configtest
```
Запуск в проверочном режиме (только вывод команд без их выполнения):

```
rsnapshot -t hourly
```
Создание первого архива:

```
rsnapshot hourly
```
Просмотр сколько места занимают резервные копии:

```
rsnapshot du
```
Для автоматического создания архивов нужно добавить выполнение в крон:

	/etc/cron.d/rsnapshot

```
0 */4 * * *     root /usr/bin/rsnapshot hourly
30 3 * * *      root /usr/bin/rsnapshot daily
0 3 * * 1       root /usr/bin/rsnapshot weekly
30 2 1 * *      root /usr/bin/rsnapshot monthly
```


Из файла крона нужно удалить те строчки заданий чьи интервалы не заданы в конфиге. 
Если вы не задали interval hourly то удалите строчку с /usr/bin/rsnapshot hourly, иначе rsnapshot выдаст ошибку.