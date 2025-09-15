-- Create the application user before running other scripts
-- This runs before 01-init.sql due to alphabetical ordering

-- Create the application user if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = '${POSTGRES_APP_USER}') THEN
        CREATE USER ${POSTGRES_APP_USER} WITH 
            PASSWORD '${POSTGRES_APP_PASSWORD}'
            CREATEDB
            NOSUPERUSER
            NOCREATEROLE;
    END IF;
END
$$;

-- Grant connect privilege to the database
GRANT CONNECT ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_APP_USER};

-- Create pg_stat_statements extension if it doesn't exist
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
