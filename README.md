# hermes-infra

Infrastructure for Hermes: local Docker Compose and, later, Terraform.

## Run locally

```
docker compose -f local/docker-compose.yml up -d
```

This starts MongoDB on `localhost:27017`. Data lives in the `mongo-data` volume.

Check it:

```
docker compose -f local/docker-compose.yml exec mongo mongosh --quiet --eval "db.runCommand({ping:1})"
```

Expected: `{ ok: 1 }`.

Stop it (data is kept):

```
docker compose -f local/docker-compose.yml down
```

Stop it and delete the data:

```
docker compose -f local/docker-compose.yml down -v
```
