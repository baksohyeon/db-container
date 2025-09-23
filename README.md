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

# Access web interfaces
make pgadmin    # pgAdmin
make minio      # MinIO Console
```

## Default Connection Details

| Service        | Host      | Port                       | Database | User              | Password              |
| -------------- | --------- | -------------------------- | -------- | ----------------- | --------------------- |
| MySQL          | localhost | 3306                       | testdb   | testuser          | testpass              |
| Redis          | localhost | 6379                       | -        | -                 | redispass             |
| PostgreSQL     | localhost | 5432                       | testdb   | postgres          | postgres              |
| PostgreSQL App | localhost | 5432                       | testdb   | myapp_backend     | myapp_secure_password |
| pgAdmin        | localhost | 8080                       | -        | admin@example.com | admin                 |
| MinIO          | localhost | 9000 (api), 9001 (console) | -        | minioadmin        | minioadmin123         |
| Kafka          | localhost | 9092                       | -        | -                 | -                     |
| Zookeeper      | localhost | 2181                       | -        | -                 | -                     |

## Service Access

### Web Interfaces
- **pgAdmin**: http://localhost:8080
- **MinIO Console**: http://localhost:9001

### Command Line Access
- **Kafka**: Use kafka tools or connect to localhost:9092
- **Zookeeper**: Connect to localhost:2181

## pgadmin 사용법

- 왼쪽 사이드바에서 "Servers" 우클릭 →
  "Register" → "Server..."
- General 탭:
  Name: PostgreSQL Database
- Connection 탭:
  - Host name/address: postgres-db
  - Port: 5432
  - Maintenance database: postgres
  - Username: postgres
  - Password: postgres

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

# pgAdmin
PGADMIN_EMAIL=admin@example.com
PGADMIN_PASSWORD=admin
PGADMIN_PORT=8080

# MinIO
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin123
MINIO_API_PORT=9000
MINIO_CONSOLE_PORT=9001

# Kafka & Zookeeper
ZOOKEEPER_PORT=2181
ZOOKEEPER_CLIENT_PORT=2181
ZOOKEEPER_TICK_TIME=2000

KAFKA_PORT=9092
KAFKA_BROKER_ID=1
KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181
KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1
KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
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
make pgadmin        # Open pgAdmin web interface
make minio          # Open MinIO console
make kafka          # Connect to Kafka broker
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
├── .env                   # Environment variables
├── mysql/init/            # MySQL initialization scripts
├── postgres/
│   ├── init/              # PostgreSQL initialization scripts
│   ├── postgresql.conf    # PostgreSQL configuration
│   └── pgadmin_servers.json # pgAdmin server configuration
├── redis/redis.conf       # Redis configuration
└── README.md
```
