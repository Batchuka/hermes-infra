# Local environment

Docker Compose for the services Hermes needs on a developer machine. Run every command from the root of `hermes-infra`.

| Service | Used by  | Port  | Volume       |
|---------|----------|-------|--------------|
| mongo   | proposals | 27017 | `mongo-data` |
| mysql   | credit and contracts | 3306  | `mysql-data` |

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

### Contracts schema and user

The same MySQL container also holds the `contracts` schema, with its own user (`contracts`, password `contracts`, for local use only). The script that creates them is `local/mysql-init/01-contracts.sql`.

MySQL runs that script only when its volume is empty. If you already had the container running, delete the data and start again (see Stop):

```
docker compose -f local/docker-compose.yml down -v
docker compose -f local/docker-compose.yml up -d mysql
```

Check that the `contracts` user sees only its own schema. Expected: `contracts`, `information_schema` and `performance_schema`, and no `credit`.

```
docker compose -f local/docker-compose.yml exec mysql mysql -ucontracts -pcontracts -e "SHOW DATABASES"
```

Check that it cannot read the credit data. Expected: `ERROR 1142 ... SELECT command denied to user 'contracts'`. The table does not need to exist, because the permission is checked first.

```
docker compose -f local/docker-compose.yml exec mysql mysql -ucontracts -pcontracts -e "SELECT * FROM credit.x"
```

## Stop

Keep the data:

```
docker compose -f local/docker-compose.yml down
```

Delete the data too:

```
docker compose -f local/docker-compose.yml down -v
```
