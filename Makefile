# Database Container Manager - Makefile
# Manages MySQL, Redis, and PostgreSQL containers using Docker Compose

# Include environment variables if .env exists
-include .env
export

# Colors for output
GREEN := \033[0;32m
BLUE := \033[0;34m
NC := \033[0m

# Docker Compose command (supports both docker-compose and docker compose)
DOCKER_COMPOSE := $(shell if command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; else echo "docker compose"; fi)

# Default target
.DEFAULT_GOAL := help

# Check if Docker is available
.PHONY: check-docker
check-docker:
	@if ! command -v docker >/dev/null 2>&1; then \
		echo "Docker is not installed or not in PATH"; \
		exit 1; \
	fi

# Start containers
.PHONY: start
start: check-docker
	@echo "$(BLUE)Starting containers...$(NC)"
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Containers started successfully!$(NC)"

# Stop containers
.PHONY: stop
stop: check-docker
	@$(DOCKER_COMPOSE) down

# Restart containers
.PHONY: restart
restart: stop start

# Show container status
.PHONY: status
status: check-docker
	@$(DOCKER_COMPOSE) ps

# View logs
.PHONY: logs
logs: check-docker
	@$(DOCKER_COMPOSE) logs -f

# Connect to MySQL
.PHONY: mysql
mysql: check-docker
	@docker exec -it mysql-db mysql -u testuser -ptestpass testdb

# Connect to MySQL as root
.PHONY: mysql-root
mysql-root: check-docker
	@docker exec -it mysql-db mysql -u root -prootpass

# Connect to Redis
.PHONY: redis
redis: check-docker
	@docker exec -it redis-cache redis-cli -a redispass

# Connect to PostgreSQL
.PHONY: postgres
postgres: check-docker
	@docker exec -it postgres-db psql -U postgres -d testdb

# Connect to PostgreSQL as app user
.PHONY: postgres-app
postgres-app: check-docker
	@docker exec -it postgres-db psql -U myapp_backend -d testdb

# Create MySQL backup
.PHONY: backup
backup: check-docker
	@mkdir -p backups
	@docker exec mysql-db mysqldump -u root -prootpass --all-databases > "backups/mysql_backup_$$(date +%Y%m%d_%H%M%S).sql"
	@echo "$(GREEN)MySQL backup created$(NC)"

# Create PostgreSQL backup
.PHONY: backup-postgres
backup-postgres: check-docker
	@mkdir -p backups
	@docker exec postgres-db pg_dumpall -U postgres > "backups/postgres_backup_$$(date +%Y%m%d_%H%M%S).sql"
	@echo "$(GREEN)PostgreSQL backup created$(NC)"

# Create all backups
.PHONY: backup-all
backup-all: backup backup-postgres
	@echo "$(GREEN)All backups completed$(NC)"

# Clean up containers (keep data)
.PHONY: clean
clean: check-docker
	@$(DOCKER_COMPOSE) down --remove-orphans
	@docker system prune -f

# Clean up everything including data
.PHONY: clean-all
clean-all: check-docker
	@$(DOCKER_COMPOSE) down -v --remove-orphans
	@docker system prune -f

# Show connection information
.PHONY: info
info:
	@echo "$(BLUE)Database Connection Information$(NC)"
	@echo ""
	@echo "$(GREEN)MySQL:$(NC)"
	@echo "  mysql://testuser:testpass@localhost:3306/testdb"
	@echo ""
	@echo "$(GREEN)Redis:$(NC)" 
	@echo "  redis://:redispass@localhost:6379"
	@echo ""
	@echo "$(GREEN)PostgreSQL:$(NC)"
	@echo "  postgresql://postgres:postgres@localhost:5432/testdb"
	@echo "  postgresql://myapp_backend:myapp_secure_password@localhost:5432/testdb"

# Show help
.PHONY: help
help:
	@echo "$(BLUE)Database Container Manager$(NC)"
	@echo ""
	@echo "$(GREEN)Container Management:$(NC)"
	@echo "  start          Start all containers"
	@echo "  stop           Stop all containers"
	@echo "  restart        Restart all containers"
	@echo "  status         Show container status"
	@echo "  logs           View container logs"
	@echo ""
	@echo "$(GREEN)Database Connections:$(NC)"
	@echo "  mysql          Connect to MySQL"
	@echo "  mysql-root     Connect to MySQL as root"
	@echo "  redis          Connect to Redis"
	@echo "  postgres       Connect to PostgreSQL"
	@echo "  postgres-app   Connect to PostgreSQL as app user"
	@echo ""
	@echo "$(GREEN)Backup & Maintenance:$(NC)"
	@echo "  backup         Backup MySQL"
	@echo "  backup-postgres Backup PostgreSQL"
	@echo "  backup-all     Backup all databases"
	@echo "  clean          Remove containers (keep data)"
	@echo "  clean-all      Remove everything (DESTRUCTIVE)"
	@echo ""
	@echo "$(GREEN)Information:$(NC)"
	@echo "  info           Show connection details"
	@echo "  help           Show this help"