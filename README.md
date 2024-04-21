# Smalland Dedicated Server

This repository contains the necessary files to set up a Smalland game server using Docker

## Prerequisites

- Docker
- Docker Compose (optional)

## Getting Started

1. Clone this repository:

    ```shell
    git clone https://github.com/dreallday/smalland-dedicated.git
    ```

2. Navigate to the project directory:

    ```shell
    cd smalland-dedicated
    ```

3. Copy the `.env.sample` file and rename it to `.env`:

    ```shell
    cp .env.sample .env
    ```

4. Edit the `.env` file and provide the necessary configuration values for your game server.

5. Build and start the containers:

    ```shell
    docker-compose up -d
    ```

6. Access your game server via the server browser.

## Configuration

Change at the very least the following configuration options in `.env`:

- `SERVERNAME`: The server name, this is searchable within the game client.
- `PASSWORD`: In a public server people will be able to mess with your buildings and items, so set a password.

## To Do
- [ ] Automated backup of save data
- [ ] Script to restore save data
- [ ] Automated restarts
- [ ] Automated updates
- [ ] Automated server status checks
