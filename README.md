# pymongo-api

## Как запустить

1. Переходим в sharding-repl-cache

2. Запускаем mongodb кластер, redis и приложение

```shell
docker compose up -d
```

3. Инициализируем mongodb кластер и заполняем данными

```shell
./init-mongo-cluster.sh
```
