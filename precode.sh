#!/bin/bash
set -e

# создаём каталог task с вложенными директориями
mkdir task
cd task

mkdir dir1 dir2 dir3
mkdir dir3/dir4

# создаём пустой файл task/dir2/empty
touch dir2/empty

# создаём файл task/dir2/hello.sh
cat > dir2/hello.sh <<'EOF'
#!/bin/bash
echo "$1, привет!"
EOF

# устанавливаем права rwxrw-r--
chmod 764 dir2/hello.sh

# сохраняем список файлов task/dir2 в task/dir2/list.txt
ls dir2 > dir2/list.txt

# копируем содержимое каталога task/dir2 в task/dir3/dir4
cp -r dir2/. dir3/dir4/

# записываем в task/dir1/summary.txt список файлов *.txt в task,
# включая поддиректории, исключая сам summary.txt
find . -type f -name '*.txt' ! -path './dir1/summary.txt' | sort > dir1/summary.txt

# дописываем содержимое task/dir2/list.txt
cat dir2/list.txt >> dir1/summary.txt

# определяем переменную окружения NAME
export NAME="Всем студентам"

# запускаем hello.sh с NAME в качестве аргумента и дописываем вывод
./dir2/hello.sh "$NAME" >> dir1/summary.txt

# перемещаем с переименованием summary.txt в task/Практическое задание
mv dir1/summary.txt "Практическое задание"

# выводим содержимое файла
cat "Практическое задание"

# ищем строки со словом dir и сортируем
grep "dir" "Практическое задание" | sort

# переходим в родительский каталог для task
cd ..

# удаляем task со всем содержимым
rm -rf task