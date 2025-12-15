# TreeCure Backend API

Express.js backend for TreeCure mobile application with Neon PostgreSQL database.

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your Neon database credentials
   ```

3. **Start server:**
   ```bash
   npm start          # Production
   npm run dev        # Development with auto-reload
   ```

## API Endpoints

- `GET /health` - Health check
- `GET /api/trees` - Get all trees with diseases
- `GET /api/trees/:treeName` - Get specific tree
- `GET /api/trees/search/:query` - Search trees

## Environment Variables

Required in `.env`:
- `DATABASE_HOST` - Neon database host
- `DATABASE_NAME` - Database name (usually 'neondb')
- `DATABASE_USER` - Database username
- `DATABASE_PASSWORD` - Database password
- `DATABASE_PORT` - Database port (default: 5432)
- `DATABASE_SSL` - Enable SSL (true for Neon)
- `PORT` - Server port (default: 3000)

## Testing

```bash
# Health check
curl http://localhost:3000/health

# Get all trees
curl http://localhost:3000/api/trees
```
