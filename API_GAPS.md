# API Gaps

This document lists missing or incomplete backend endpoints required for the full Flutter client experience.

## 1. Phone + OTP Registration/Login Flow
**Gap**: SMS OTP endpoints (`/sms/send-otp`, `/sms/verify-otp`) exist but there is no phone-based registration/login flow.

**Expected endpoints**:
```http
POST /api/v1/auth/phone-register
Request: { phone, otp, name?, password? }
Response: { user, token }

POST /api/v1/auth/phone-login
Request: { phone, otp }
Response: { user, token }
```

## 2. Google Social Login
**Gap**: No OAuth endpoints for Google Sign-In.

**Expected endpoint**:
```http
POST /api/v1/auth/google
Request: { id_token }
Response: { user, token }
```

## 3. Contest Registration Status Check
**Gap**: No endpoint to check if the authenticated user has already joined a specific contest.

**Expected endpoint**:
```http
GET /api/v1/contests/{id}/joined
Response: { joined: boolean }
```

## 4. Real-Time Contest Leaderboard via WebSocket
**Gap**: Reverb is configured server-side but no WebSocket events are defined for real-time leaderboard updates.

**Expected events**:
- `App\Events\ContestLeaderboardUpdated` broadcast on `contest.{id}` channel
- Payload: `{ contest_id, leaderboard: [{user_id, name, score, rank}], timestamp }`

## 5. In-App Notifications List
**Gap**: No GET endpoint to list user notifications.

**Expected endpoint**:
```http
GET /api/v1/notifications
Response: [
  {
    id,
    title,
    body,
    type,
    data: {},
    read_at: "2026-01-01T00:00:00Z" | null,
    created_at
  }
]
```

## 6. Book Search/Filter/Categories
**Gap**: No search or category endpoints for books.

**Expected endpoints**:
```http
GET /api/v1/books?search=query&category_id=1&page=1
GET /api/v1/book-categories
```

## 7. Exam Premium/Unlock Status Check
**Gap**: No endpoint to verify if a user has unlocked a premium exam or category.

**Expected endpoint**:
```http
GET /api/v1/exams/{id}/unlock-status
Response: { unlocked: boolean, expires_at: string | null }
```

## 8. Weak Areas Topic-Wise Breakdown
**Gap**: Analytics endpoint returns aggregate counts but not topic names with scores.

**Expected response enhancement**:
```json
{
  "overall_score": 65,
  "total_attempts": 120,
  "weak_areas": [
    { "topic": "Algebra", "score": 40, "attempts": 15 },
    { "topic": "Geometry", "score": 55, "attempts": 12 }
  ]
}
```

## 9. CV Template Content/HTML Rendering
**Gap**: Templates are listed but no endpoint returns rendered HTML/content for a specific template.

**Expected endpoint**:
```http
GET /api/v1/cv-templates/{id}/content
Response: { html: "<div>...</div>", sections: [...] }
```

## 10. User Dashboard Unified Stats
**Gap**: No single endpoint for home feed data; the app must call multiple endpoints in parallel.

**Expected endpoint**:
```http
GET /api/v1/dashboard
Response: {
  stats: { exams_completed, avg_score, saved_jobs, purchased_books },
  upcoming_contests: [...],
  recent_jobs: [...],
  continue_reading: [...]
}
```
