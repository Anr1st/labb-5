#!/bin/bash

# Проверка, что есть измененные .txt файлы
changed_files=$(git diff --cached --name-only -- '*.txt')

if [ -z "$changed_files" ]; then
  echo "Нет изменений в .txt файлах. Пропуск проверки."
  exit 0
fi

# Проверка каждого .txt файла
for file in $changed_files; do
  # Проверка на пустой файл
  if [ ! -s "$file" ]; then
    echo "Файл $file пустой. Пожалуйста, добавьте текст в файл."
    exit 1
  fi

  # Проверка на наличие подписи автора в конце файла
  if ! tail -n 1 "$file" | grep -q "Автор"; then
    echo "Файл $file не содержит подписи автора в конце."
    exit 1
  fi
done

echo "Все .txt файлы прошли проверку."
exit 0
