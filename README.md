# pgcli-docker
pgcli in a tiny Docker image powered by Alpine Linux

# How to use this image

Print help:

```bash
docker run --rm diyan/pgcli --help
```

Run PostgreSQL server if you don't have it:

```bash
docker run -d --name=postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=secret \
  postgres:9.5
```

Run pgcli:

```bash
docker run --rm -ti --name=pgcli \
  -e PGPASSWORD=secret \
  --link=postgres:postgres \
  diyan/pgcli \
  --host=postgres \
  --dbname=postgres \
  --user=postgres
```
