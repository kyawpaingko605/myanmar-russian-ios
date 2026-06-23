# Myanmar-Russian Language Learner - Native iOS App

Beautiful native iOS app for learning Myanmar-Russian language with AI tutor powered by Gemini API.

## Features

- 🃏 **Flashcards** — Interactive flashcards with TTS pronunciation
- 🧠 **Quiz** — Multiple-choice quizzes with scoring
- 🎓 **Pro Tutor** — AI-powered conversation practice with backend integration
- 📊 **Progress Tracking** — Track learning progress and streak
- 🎙️ **Text-to-Speech** — Native iOS TTS for Myanmar and Russian
- 🌐 **Backend Integration** — Gemini API auto-integrated via backend server

## Project Structure

```
myanmar-russian-ios/
├── backend/
│   ├── server.js          # Express server with Gemini API
│   ├── package.json       # Node.js dependencies
│   └── .env.example       # Environment variables template
└── ios/
    ├── Package.swift      # Swift package manifest
    └── Sources/
        ├── MyanmarRussianLearnerApp.swift
        ├── ContentView.swift
        └── Views/
            ├── HomeView.swift
            ├── FlashcardsView.swift
            ├── QuizView.swift
            ├── ProTutorView.swift
            └── ProgressView.swift
```

## Setup Instructions

### Backend Server

1. **Install dependencies:**
   ```bash
   cd backend
   npm install
   ```

2. **Create `.env` file:**
   ```bash
   cp .env.example .env
   ```

3. **Add Gemini API Key:**
   Edit `.env` and add your Gemini API key:
   ```
   GEMINI_API_KEY=your_api_key_here
   PORT=3000
   ```

4. **Start server:**
   ```bash
   npm start
   # or for development with auto-reload
   npm run dev
   ```

Server will run on `http://localhost:3000`

### iOS App

1. **Open in Xcode:**
   ```bash
   open ios/Package.swift
   ```

2. **Configure Backend URL:**
   - In `ProTutorView.swift`, update `backendURL` if needed
   - Default: `http://localhost:3000`

3. **Build & Run:**
   - Select iOS simulator or device
   - Press Cmd+R to build and run

## API Endpoints

### `/api/health`
Health check endpoint
- **Method:** GET
- **Response:** `{ status: "ok", timestamp: "..." }`

### `/api/tutor`
AI tutor chat endpoint
- **Method:** POST
- **Body:**
  ```json
  {
    "message": "user message",
    "mode": "conversation|pronunciation|grammar|vocabulary",
    "langMode": "myanmar|russian",
    "history": []
  }
  ```
- **Response:**
  ```json
  {
    "success": true,
    "response": "AI tutor response",
    "timestamp": "..."
  }
  ```

### `/api/vocabulary`
Get vocabulary list
- **Method:** GET
- **Response:** `{ success: true, vocabulary: [...], count: N }`

## Screens

### Home Screen
Dashboard with:
- Streak counter
- Words learned
- Success rate
- Feature cards (Flashcards, Quiz, Pro Tutor)

### Flashcards Screen
- Flip animation
- TTS pronunciation
- Navigation between cards
- Category organization

### Quiz Screen
- Multiple-choice questions
- Real-time feedback
- Score tracking
- Progress bar

### Pro Tutor Screen
- AI conversation with Gemini
- Language mode toggle (Myanmar/Russian)
- Tutor mode selection (Conversation, Pronunciation, Grammar, Vocabulary)
- Auto TTS for responses
- Backend API integration

### Progress Screen
- Overall progress percentage
- Category-wise progress
- Streak tracking
- Quiz history

## Technologies

- **iOS:** SwiftUI, AVFoundation
- **Backend:** Node.js, Express.js
- **AI:** Google Gemini API
- **Speech:** AVSpeechSynthesizer (native iOS TTS)

## Requirements

- iOS 15+
- Xcode 14+
- Node.js 16+
- Gemini API key from [Google AI Studio](https://aistudio.google.com)

## Getting Gemini API Key

1. Visit [Google AI Studio](https://aistudio.google.com)
2. Click "Get API Key"
3. Create new API key
4. Copy and paste into `.env` file

## Troubleshooting

### Backend not connecting
- Check if backend server is running: `http://localhost:3000/api/health`
- Verify backend URL in `ProTutorView.swift`
- Check network connectivity

### TTS not working
- Ensure device has speaker enabled
- Check iOS language settings
- Verify AVSpeechSynthesizer permissions

### Gemini API errors
- Verify API key is valid
- Check API quota limits
- Ensure network connectivity

## Future Enhancements

- Offline mode with cached lessons
- Spaced repetition algorithm (SM-2)
- User profiles and progress sync
- More vocabulary categories
- Pronunciation feedback
- Voice recording and analysis

## License

MIT

## Support

For issues or questions, please create an issue in the repository.
