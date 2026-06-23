# Quick Start - Myanmar-Russian Language Learner

**5 မိနစ်မှာ app ကြည့်နိုင်ပါတယ်!**

## Step 1: Clone Project
```bash
git clone <repo-url>
cd myanmar-russian-ios
```

## Step 2: Setup API Key
```bash
cp .env.example .env
# Edit .env and add GEMINI_API_KEY
```

Get free API key: [Google AI Studio](https://aistudio.google.com)

## Step 3: Start with Docker
```bash
docker-compose up
```

**Wait for:**
```
✓ backend_1 | 🚀 Backend server running on http://localhost:3000
✓ web_1 | nginx: master process started
```

## Step 4: Test Backend
```bash
curl http://localhost:3000/api/health
# Response: {"status":"ok","timestamp":"..."}
```

## Step 5: iOS App (Optional)

If you want to run iOS app locally:

```bash
cd ios
open Package.swift
# In Xcode: Cmd+R
```

Update backend URL in `ProTutorView.swift`:
```swift
@State private var backendURL = "http://localhost:3000"
// or your computer's IP if on physical device
```

## Features Available

✅ **Flashcards** - Learn vocabulary with TTS  
✅ **Quiz** - Test your knowledge  
✅ **Pro Tutor** - AI chat with Gemini  
✅ **Progress** - Track your learning  

## API Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/health` | GET | Health check |
| `/api/tutor` | POST | AI tutor chat |
| `/api/vocabulary` | GET | Get word list |

## Stop Services
```bash
docker-compose down
```

## Troubleshooting

**Port 3000 already in use?**
```bash
# Edit docker-compose.yml
# Change: "3000:3000" → "3001:3000"
docker-compose up
```

**API not working?**
```bash
docker-compose logs backend
# Check for errors
```

**Gemini API error?**
- Verify API key in `.env`
- Check quota at [Google AI Studio](https://aistudio.google.com)

## Next Steps

- [Full Documentation](README.md)
- [Docker Setup](DOCKER_SETUP.md)
- [iOS Development](README.md#ios-app)

---

**Need help?** Check README.md or DOCKER_SETUP.md
