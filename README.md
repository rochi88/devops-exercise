# devops_exercise

## Docker Help

### How to Do a Clean Restart of a Docker Instance
Stop the container(s) using the following command:
```sh
docker-compose down
```
Delete all containers using the following command:
```sh
docker rm -f $(docker ps -a -q)
```
Delete all volumes using the following command:
```sh
docker volume rm $(docker volume ls -q)
```
Restart the containers using the following command:
```sh
docker-compose up -d
```

### Restart all container
```sh
docker restart $(docker ps -q)
```

### Up container with new build 
```sh
docker compose up --build
```