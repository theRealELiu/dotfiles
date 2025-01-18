# Build image

```
docker build . -t ubuntu24.04:develop
```

# Create container

```
image_name="ubuntu24.04:develop"
container_name="${USER}-dev"
mount_source="/Users/${USER}/workspace"
mount_target="/workspace"

docker run                                                          \
    --hostname=dev                                                  \
    --env TERM=xterm-256color                                       \
    --env HOST_USERNAME=${USER}                                     \
    --env HOST_UID=$(id -u)                                         \
    --env HOST_GID=$(id -g)                                         \
    --init                                                          \
    --detach                                                        \
    --shm-size=4g                                                   \
    --name ${container_name}                                        \
    --mount type=bind,source=${mount_source},target=${mount_target} \
    --workdir ${mount_target}                                       \
    ${image_name}                                                   \
    tail -f /dev/null
```

This command

1. Enables fancy prompt for bash by setting TERM.
2. Creates a shared dir between container and host, mount_source specifies the dir in host, mount_target is the dir in container.
3. Uses "tail -f /dev/null" to keep container running. See https://github.com/docker/getting-started/issues/201

# Create a new sudo enabled user in container

Login container in root:

```
docker exec -it -u root ${container_name} /bin/bash
```

Use `adduser` command to add a new user to your system. Be sure to replace `summer` with the username that you want to create.

```
adduser summer
```

Use `usermod` command to add user to the sudo group:

```
usermod -aG sudo summer
```

Refs:
1. https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04
2. https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu
