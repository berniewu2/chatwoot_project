# Chatwoot – Local Development Setup Guide

Welcome to the Chatwoot setup guide! Chatwoot is an open-source customer-support platform (live-chat, shared inbox, etc.) that you can run on your own machine.  

These guides will help you set up the environment required for Chatwoot. Follow the guides based on the operating system you use.

## Environment Setup

- [Mac OS installation guide](https://www.chatwoot.com/docs/contributing-guide/environment-setup/mac-os)
- [Ubuntu installation guide](https://www.chatwoot.com/docs/contributing-guide/environment-setup/ubuntu)
- [Windows 10 Installation Guide](https://www.chatwoot.com/docs/contributing-guide/environment-setup/windows)
- [Docker Setup](https://www.chatwoot.com/docs/contributing-guide/environment-setup/docker)
- [Make](https://www.chatwoot.com/docs/contributing-guide/environment-setup/make)

## Project Setup

### 1. Clone the repo
```bash
# change location to the path you want chatwoot to be installed
cd ~

# clone the repo and cd to chatwoot dir
git clone https://github.com/chatwoot/chatwoot.git
cd chatwoot
```

### 2. Install Ruby & Javascript dependencies

```bash
make burn
```

### 3. Setup environment variables.
```bash
cp .env.example .env
```
Follow this [guide](https://www.chatwoot.com/docs/self-hosted/configuration/environment-variables)

Make sure to configure postgres and redis

### 4. Setup rails server
```bash
# run db migrations
make db
# fireup the server
foreman start -f Procfile.dev
```

### 5. Login with credentials
```bash
http://localhost:3000
user name: john@acme.inc
password: Password1!
```

### Docker for development
```bash
# build base image first
docker compose build base

# build the server and worker
docker compose build

# prepare the database
docker compose exec rails bundle exec rails db:chatwoot_prepare

docker compose up
```

### Note
**Some online PostgreSQL services only support IPv6. If yours does, make sure IPv6 is enabled in your environment (e.g., Docker or VM).**

## Testing
[Cypress Guide](https://www.chatwoot.com/docs/contributing-guide/tests/cypress)