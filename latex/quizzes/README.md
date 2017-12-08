Это шаблон для создания тестов или экзаменов на русском языке на базе eqexam. 
Исходный файл `example.tex`, который содержит пример экзамена. Необходимые 
стили лежат в текущем каталоге - их нельзя удалять и их нет в стандартной 
поставке texlive.

### Установка зависимостей

Нужно поставить пакеты (для Fedora):

    sudo yum install texlive-comment texlive-collection-latexrecommended \
        texlive-collection-langcyrillic texlive-collection-fontsrecommended

### Генерация вариантов и ответов

Скрипт `gen.sh` автоматически создаст все варианты тестов с ответами.

---

This is a template for creating quizzes or exams (in Russian) based on eqexam 
style. The source is `example.tex` that includes exam sample. All required 
styles are in the current directory - do not remove them because there is no 
eqexam in texlive distribution.

### Installing dependencies

Install packages (for Fedora):

    sudo yum install texlive-comment texlive-collection-latexrecommended \
        texlive-collection-langcyrillic texlive-collection-fontsrecommended

### Versions an solutions generation

Shell `gen.sh` creates all versions with solutions automatically.
