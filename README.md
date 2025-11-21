# Strapi Docker Template with MySQL

A complete Strapi headless CMS project configured to run with Docker and MySQL database.

## Overview

This project provides a production-ready Strapi application with:
- **Strapi v5.31.2** - Open-source headless CMS
- **MySQL 8.0** - Database
- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (v20.10 or higher)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.0 or higher)

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd test-strapi-docker-template
```

### 2. Configure Environment Variables

Copy the example environment file and customize if needed:

```bash
cp .env.example .env
```

**Generate secure secrets:**

```bash
# Génère des valeurs à copier-coller
echo "APP_KEYS=\"$(openssl rand -hex 16),$(openssl rand -hex 16)\""
echo "API_TOKEN_SALT=$(openssl rand -hex 16)"
echo "ADMIN_JWT_SECRET=$(openssl rand -hex 32)"
echo "TRANSFER_TOKEN_SALT=$(openssl rand -hex 16)"
echo "JWT_SECRET=$(openssl rand -hex 32)"
echo "ENCRYPTION_KEY=$(openssl rand -hex 32)"
```

Copy the generated values and replace the corresponding `toBeModified` values in your `.env` file.

The default configuration includes:
- **Strapi Port**: 1337
- **Database**: MySQL 8.0
- **Database Name**: strapi
- **Database User**: strapi
- **Database Password**: strapi

### 3. Start the Application

Build and start all services using Docker Compose:

```bash
docker-compose up -d --build
```

This will:
1. Build the Strapi Docker image
2. Start MySQL database container
3. Start Strapi application container
4. Wait for MySQL to be healthy before starting Strapi

### 4. Access Strapi

Once the containers are running, access Strapi at:

**Admin Panel**: [http://localhost:1337/admin](http://localhost:1337/admin)

On first access, you'll be prompted to create an admin account.

## Project Structure

```
.
├── config/           # Strapi configuration files
├── database/         # Database migrations and schema
├── public/           # Public assets
├── src/              # Application source code
│   ├── admin/       # Admin panel customizations
│   ├── api/         # API endpoints and content types
│   └── extensions/  # Plugin extensions
├── .dockerignore    # Docker ignore file
├── .env             # Environment variables (not in git)
├── .env.example     # Example environment variables
├── .gitignore       # Git ignore file
├── docker-compose.yml # Docker Compose configuration
├── Dockerfile       # Strapi Docker image
├── package.json     # Node.js dependencies
└── README.md        # This file
```

## Docker Services

### Strapi Service
- **Container Name**: strapi
- **Port**: 1337
- **Volumes**: Configuration, source code, and uploads are mounted
- **Environment**: Production mode

### MySQL Service
- **Container Name**: strapi-mysql
- **Port**: 3306
- **Database**: strapi
- **User**: strapi
- **Persistent Storage**: MySQL data is stored in a Docker volume

## Development

### View Logs

View logs from all services:
```bash
docker-compose logs -f
```

View logs from a specific service:
```bash
docker-compose logs -f strapi
docker-compose logs -f mysql
```

### Stop Services

```bash
docker-compose down
```

### Stop Services and Remove Volumes

⚠️ **Warning**: This will delete all database data!

```bash
docker-compose down -v
```

### Rebuild Containers

```bash
docker-compose up -d --build
```

### Access MySQL Database

Connect to MySQL directly:
```bash
docker exec -it strapi-mysql mysql -u strapi -pstrapi strapi
```

## Local Development (Without Docker)

If you prefer to run Strapi locally without Docker:

### 1. Install Dependencies

```bash
npm install
```

### 2. Configure Local Database

Update `.env` file with your local MySQL configuration:

```
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_NAME=strapi
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=your_password
```

### 3. Run Development Server

```bash
npm run develop
```

This will start Strapi in watch mode with auto-reload on file changes.

## Useful Commands

### NPM Scripts

- `npm run develop` - Start Strapi in development mode
- `npm run start` - Start Strapi in production mode
- `npm run build` - Build the admin panel
- `npm run strapi` - Display all Strapi commands

### Docker Commands

- `docker-compose ps` - List running containers
- `docker-compose restart strapi` - Restart Strapi container
- `docker-compose exec strapi npm run strapi` - Run Strapi commands inside container

## Troubleshooting

### Container Won't Start

Check logs for error messages:
```bash
docker-compose logs strapi
docker-compose logs mysql
```

### Database Connection Issues

1. Ensure MySQL container is healthy:
   ```bash
   docker-compose ps
   ```

2. Check MySQL is ready:
   ```bash
   docker exec strapi-mysql mysqladmin ping -h localhost -u strapi -pstrapi
   ```

### Port Already in Use

If port 1337 or 3306 is already in use, modify the port mappings in `docker-compose.yml`.

### Reset Everything

To start fresh (⚠️ deletes all data):
```bash
docker-compose down -v
docker-compose up -d --build
```

## Security Notes

⚠️ **Important**: Before deploying to production:

1. Change all default passwords in `.env`
2. Generate secure random strings for APP_KEYS and secrets
3. Use strong database passwords
4. Enable SSL/TLS for database connections if applicable
5. Review and update security settings in `config/`

## Learn More

- [Strapi Documentation](https://docs.strapi.io/)
- [Strapi Docker Documentation](https://docs.strapi.io/dev-docs/installation/docker)
- [MySQL Documentation](https://dev.mysql.com/doc/)

## License

See the [LICENSE](LICENSE) file for details.
