# Пример Dockerfile который по-разному себя ведет в зависимости от места сбсорки и загрузки: локальная машина или CI/CD с загрузкой в Docker Registry

# За базовый образ берем Alpine
FROM alpine:latest
#Автор
LABEL maintainer="minaevsergei@gmail.com"
# Монтируем том. Но! Если том монтируется на CI/CD сервере (его runner), том существует там
VOLUME /netology
# Указываем рабочий каталог, это том который мы смонтировали
WORKDIR /netology
# Запускаем команду на создание файла в текущем рабочем каталоге
RUN echo «Hello World!» > ./testfile
# Читаем файле при запуске контейнера
CMD [«cat», «testfile»]

# Если собрать образ и локально запустить из него контейнер - контейнер будет работать.
# Если собрать образ на сервере CI/CD (в его runner), запушить образ в Docker Registry, затем загрузить образ на локальную машину и попытаться запустить контейнер - получим ошибку. Потому что Volume нет на локальной машине
