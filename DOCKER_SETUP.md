# Docker Setup Guide - Myanmar-Russian Language Learner

**အလွယ်ကျ setup - အခြားလူတွေ အတွက်**

## Prerequisites

- Docker installed ([Download](https://www.docker.com/products/docker-desktop))
- Docker Compose installed (included with Docker Desktop)

## Quick Start

### 1. Clone Project
```bash
git clone <repo-url>
cd myanmar-russian-ios
```

### 2. Setup Environment
```bash
cp .env.example .env
```

Edit `.env` and add your Gemini API key:
```
GEMINI_API_KEY=your_api_key_here
```

### 3. Start with Docker
```bash
docker-compose up
```

Wait for services to start:
```
✓ backend service running on port 3000
✓ web server running on port 80
```

### 4. Access Application

**Backend API:**
- Health check: http://localhost:3000/api/health
- Tutor API: http://localhost:3000/api/tutor
- Vocabulary: http://localhost:3000/api/vocabulary

**Web Interface:**
- Open: http://localhost

## Services

| Service | Port | Purpose |
|---------|------|---------|
| Backend | 3000 | Node.js + Gemini API |
| Web | 80 | Nginx + Static files |

## Common Commands

### View logs
```bash
docker-compose logs -f backend
```

### Stop services
```bash
docker-compose down
```

### Rebuild images
```bash
docker-compose build --no-cache
docker-compose up
```

### Access backend shell
```bash
docker-compose exec backend sh
```

## Troubleshooting

### Port already in use
```bash
# Change port in docker-compose.yml
# ports:
#   - "3001:3000"  # Use 3001 instead of 3000
```

### API not responding
```bash
# Check backend logs
docker-compose logs backend

# Verify health
curl http://localhost:3000/api/health
```

### Gemini API errors
- Verify API key in `.env`
- Check API quota at [Google AI Studio](https://aistudio.google.com)
- Ensure network connectivity

## iOS App Setup

After backend is running, setup iOS app:

```bash
# In another terminal
cd ios
open Package.swift

# In Xcode:
# 1. Update backendURL in ProTutorView.swift
#    Change: http://localhost:3000 → http://YOUR_IP:3000
# 2. Press Cmd+R to run
```

**Note:** If running on physical device, replace `localhost` with your computer's IP address.

## Production Deployment

For production, update `docker-compose.yml`:

```yaml
environment:
  - NODE_ENV=production
  - GEMINI_API_KEY=${GEMINI_API_KEY}
```

Then deploy with:
```bash
docker-compose -f docker-compose.yml up -d
```

## Support

For issues:
1. Check logs: `docker-compose logs`
2. Verify `.env` file
3. Ensure Docker is running
4. Check port availability

## Next Steps

- [iOS App Setup](README.md#ios-app)
- [API Documentation](README.md#api-endpoints)
- [Troubleshooting](README.md#troubleshooting)
