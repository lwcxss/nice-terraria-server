# nice-terraria-server

Deploy a Terraria server, quickly!

<br> <br> <br>

## Setting it up!

To set the server up, there are a few steps to be followed.

### 0. Dependencies

This project is container-based, that means you need a Linux kernel to use it.

In addition to that, download Docker (as this tutorial uses) or Podman (just replace the command name, as it has similar syntax) 

### 1. Build the container image

The first step is building the image, to do that just use the command below, you can change the image name by replacing after the -t argument.

```
docker build . -t nice-terraria
```

That command built a light-weight linux container with directories for all server files and scripts.

### 2. Server Configuration

All server configuration is set through environment variables, as well as binding the worlds folder to sync the container's data with the host machine.

The port for connecting will aways be 7777 for now, we'll deal with it later on.

```
# Mandatory 
VERSION=1449 # This is where the terraria version is specified, dont use separations, eg: 1.4.4.9 = 1449, 1.4.4.8.1 = 14481.

# Optional (if not specified, either a default value or a null value is applied)
WORLD=niceworld # Defines the name of the world to be loaded, if world doesn't exist, a new one will be generated with that name.
SIZE=1 # World size to be generated, 1-small, 2-medium, 3-large.
DIFFICULTY=2 # New world difficulty, 0-normal, 1-expert, 2-master, 3-journey.
MOTD=This is a nice server # "Sets the server's message of the day".
SEED= # Sets new world's seed.
PASSWORD= # Sets server password
```

There are 2 ways to use them, either with a dedicated .env file, specificated by "--env-file=.env" arg, or arg-by-arg using "-e VERSION=1449 -e WORLD=myworld".

### 3. World folder volume

Container engines have a way to share data between containers and host, by using the argument "-v <path/to/host/worlds/folder>:/terraria/worlds" you link the host directory inside the container.

### 4. Running the server

To specify the port we need to forward the cointer's 7777 default port to the hosts desired one, to do so we use "-p <host-port>:7777"

To attach to the server use "docker attach -l".

```
# Add -it to allocate a terminal in the container and enable input.
# Add -d to run it in background/detached mode.
# Add --rm makes the container delete itself (the worlds folder won't be deleted if volume is specified) after stopping.
# Add -p <host_port>:<container_port> to port-foward the port.

docker run -it -d -e VERSION=1449 -v <host_path>:/terraria/worlds -p <port>:7777 nice-terraria
docker attach -l
```

To detach from the container without stopping it press CTRL+P+Q.
