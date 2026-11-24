# Local environment

Docker Compose for the services Hermes needs on a developer machine. Run every command from the root of `hermes-infra`.

| Service | Used by  | Port  | Volume       |
|---------|----------|-------|--------------|
| mongo   | proposals | 27017 | `mongo-data` |
| mysql   | credit   | 3306  | `mysql-data` |

## Start

```
docker compose -f local/docker-compose.yml up -d
```

To start only one service, add its name at the end (`mongo` or `mysql`).

## Check

MongoDB. Expected: `{ ok: 1 }`.

```
docker compose -f local/docker-compose.yml exec mongo mongosh --quiet --eval "db.runCommand({ping:1})"
```

MySQL. Expected: one row with `credit`. The root password is `hermes`, for local use only.

```
docker compose -f local/docker-compose.yml exec mysql mysql -uroot -phermes -e "SHOW DATABASES LIKE 'credit'"
```

The first start of MySQL takes a few seconds to create the database. If the command fails, wait and try again.

## Stop

Keep the data:

```
docker compose -f local/docker-compose.yml down
```

Delete the data too:

```
docker compose -f local/docker-compose.yml down -v
```
