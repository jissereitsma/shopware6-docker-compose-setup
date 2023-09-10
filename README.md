# Example Shopware 6 setup for docker-compose

**This is my personal `docker-compose` setup for Shopware 6 projects. Read it to learn from it. Don't copy it blindly, it is not meant for direct reusage (even though this might work).**

## Usage
Copy the files to your project. Modify the name `sw6.pollux.yr` and `sw6-pollux` to your liking.

Within Shopware, use the following env values:
```env
DATABASE_URL="mysql://shopware6:shopware6@mysql:3306/shopware6"
OPENSEARCH_URL=elasticsearch:9200
```

For Redis, use a file `config/packages/framework.yaml`:
```yaml
framework:
    cache:
        app: cache.adapter.redis
        system: cache.adapter.redis
        default_redis_provider: "redis://localhost:6379/1"
```

Run `docker-compose up -d` with crossed fingers.

## Some notes

- The hostname I'm using for this setup is `sw6.pollux.yr` and it comes with an identifier `sw6-pollux` throughout this code. I'm using bash scripts to generate new copies of this configuration, per project.

- Underneath, Traefik is used to allow a domain name (like `sw6.pollux.yr`) per project. The `bin/` folder contains a Docker script and Traefik configuration.

- For various Docker containers, specific builds or configuration files are configured under `docker-compose/`. Generally, if you change settings there, the cluster needs to be rebuilt (`docker-compose up -d --build`).

- Varnish is running, but its Traefik labels are commented out. This needs to be toggled somehow.

- MySQL tuning (`docker-compose/mysql/`) and OpenSearch tuning (`docker-compose.yaml`) might need to be modified.

- The OpenSearch custom Docker build (`docker-compose/opensearch/Dockerfile`) seems to be performant and solid.