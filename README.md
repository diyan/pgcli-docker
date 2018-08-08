# pgcli-docker

[`pgcli`](https://www.pgcli.com/) in a tiny Docker image powered by [Alpine Linux](https://alpinelinux.org/)

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

If you want to preserve **query-history, pgcli-log and pgcli-config** on the
host-machine, just mount the volume to the path `/root/.config/pgcli/` for
`pgcli` files:

```bash
docker run -v $(pwd)/pgcli-cfg:/root/.config/pgcli/ --rm diyan/pgcli --help
```

# AUTHORS

* [Alexey Diyan](http://diyan.github.io/)

# LICENSE

[MIT](https://github.com/diyan/pgcli-docker/blob/master/LICENSE)
