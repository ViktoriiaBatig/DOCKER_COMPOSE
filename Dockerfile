# Используем базовый образ Python
FROM python:3.9

# Устанавливаем переменную окружения PYTHONUNBUFFERED для запуска Python без буферизации вывода
ENV PYTHONUNBUFFERED 1

# Создаем рабочую директорию в контейнере
WORKDIR /code

# Копируем файлы зависимостей в контейнер
COPY requirements.txt /code/

# Устанавливаем зависимости через pip
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код проекта в контейнер
COPY . /code/


RUN python manage.py migrate
# Запускаем Gunicorn при запуске контейнера
CMD gunicorn education_project.wsgi:application --bind 0.0.0.0:8000
