# DB setup

## Quick Start

```bash
# Start all databases
cp .env.exmaple .env
make start

# Check status
make status

# Open pgAdmin web interface
make pgadmin

# Connect to databases
make mysql      # MySQL
make redis      # Redis
make postgres   # PostgreSQL
```

## Default Connection Details

| Service        | Host      | Port | Database | User          | Password              |
| -------------- | --------- | ---- | -------- | ------------- | --------------------- |
| MySQL          | localhost | 3306 | testdb   | testuser      | testpass              |
| Redis          | localhost | 6379 | -        | -             | redispass             |
| PostgreSQL     | localhost | 5432 | testdb   | postgres      | postgres              |
| PostgreSQL App | localhost | 5432 | testdb   | myapp_backend | myapp_secure_password |

## Environment Variables

Create a `.env` file to customize settings:

```env
# MySQL
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=testdb
MYSQL_USER=testuser
MYSQL_PASSWORD=testpass
MYSQL_PORT=3306

# Redis
REDIS_PASSWORD=redispass
REDIS_PORT=6379

# PostgreSQL
POSTGRES_DB=testdb
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_PORT=5432
POSTGRES_APP_USER=myapp_backend
POSTGRES_APP_PASSWORD=myapp_secure_password
```

## Available Commands

### Container Management

```bash
make start      # Start containers
make stop       # Stop containers
make restart    # Restart containers
make status     # Show status
make logs       # View all logs
```

### Database Connections

```bash
make mysql          # Connect to MySQL
make mysql-root     # Connect as MySQL root
make redis          # Connect to Redis
make postgres       # Connect to PostgreSQL
make postgres-app   # Connect as PostgreSQL app user
```

### Backup & Maintenance

```bash
make backup         # Backup MySQL
make backup-postgres # Backup PostgreSQL
make backup-all     # Backup all databases
make clean          # Remove containers (keep data)
make clean-all      # Remove everything (DESTRUCTIVE)
```

### Information

```bash
make info          # Show connection details
make help          # Show all commands
```

## Project Structure

```
database-container/
├── docker-compose.yml      # Docker configuration
├── Makefile               # Management commands
├── mysql/init/            # MySQL initialization scripts
├── postgres/init/         # PostgreSQL initialization scripts
├── redis/redis.conf       # Redis configuration
└── README.md
```
