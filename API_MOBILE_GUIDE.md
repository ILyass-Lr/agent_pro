# 📱 AgentPro — Mobile API Guide

> **Base URL:** `http://localhost:8000/api/v1/fr`
>
> **Auth method for mobile:** JWT Bearer token in `Authorization` header
>
> **Content-Type:** `application/json` (except file uploads → `multipart/form-data`)

---

## 🔐 AUTHENTICATION

### How auth works for mobile (Flutter)

1. Call **Login** → get `tokens.access` and `tokens.refresh` from the response body
2. Store both tokens securely on device (e.g. `flutter_secure_storage`)
3. On every authenticated request, add header: `Authorization: Bearer <access_token>`
4. When you get a `401`, call **Refresh** with your `refresh` token to get a new `access`
5. If refresh also fails → redirect user to login

> ⚠️ **DO NOT** send `credentials: 'include'` or use cookies — that's for the web app only.

---

### 1. Login

```
POST /api/v1/fr/accounts/auth/login/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "username": "agent007",
  "password": "MySecurePass123!"
}
```

**✅ Success response (200):**
```json
{
  "message": "Connexion réussie",
  "user": {
    "id": 5,
    "username": "agent007",
    "email": "agent@example.com",
    "first_name": "Achraf",
    "last_name": "Benali",
    "full_name": "Achraf Benali",
    "phone": "+212612345678",
    "avatar": null,
    "agency_name": "ProStar Agency",
    "license_number": "FIFA-2024-001",
    "fifa_certified": true,
    "certification_date": "2024-03-15",
    "certification_document_url": "/api/v1/fr/accounts/agents/5/certification-document/",
    "country": "Maroc",
    "city": "Casablanca",
    "total_players": 8,
    "total_deals": 3,
    "total_revenue": "4500000.00",
    "status": "approved",
    "status_display": "Approuvé",
    "rejection_reason": "",
    "suspension_reason": null,
    "is_staff": false,
    "is_superuser": false,
    "is_active": true,
    "created_at": "2025-01-15T10:30:00Z",
    "updated_at": "2025-06-20T14:00:00Z"
  },
  "tokens": {
    "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

> 💡 **Save `tokens.access` and `tokens.refresh`** — you'll need them for all subsequent requests.

**❌ Error responses:**

| Status | Body | When |
|--------|------|------|
| 400 | `{"error": "username et mot de passe sont obligatoires."}` | Missing field |
| 401 | `{"error": "Identifiants invalides"}` | Wrong username or password |
| 403 | `{"error": "Votre compte est en attente de validation", "status": "pending", "reason": "..."}` | Account pending |
| 403 | `{"error": "Votre compte a été rejeté", "status": "rejected", "reason": "..."}` | Account rejected |
| 403 | `{"error": "Votre compte a été suspendu", "status": "suspended", "reason": "..."}` | Account suspended |

> 💡 Use the `status` field (`"pending"`, `"rejected"`, `"suspended"`) to show different UI screens.

---

### 2. Refresh Token

```
POST /api/v1/fr/accounts/auth/refresh/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**✅ Success response (200):**
```json
{
  "message": "Token rafraîchi",
  "tokens": {
    "access": "eyJ_NEW_ACCESS_TOKEN..."
  }
}
```

> Replace your stored access token with this new one.

**❌ Error responses:**

| Status | Body | When |
|--------|------|------|
| 401 | `{"error": "Refresh token manquant"}` | No refresh token sent |
| 401 | `{"error": "Token invalide ou expiré"}` | Expired/invalid refresh token → re-login |

**Token lifetimes:**
- Access token: **24 hours**
- Refresh token: **7 days**

---

### 3. Register (Sign Up)

```
POST /api/v1/fr/accounts/agents/register/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: multipart/form-data
```

> ⚠️ This endpoint uses `multipart/form-data` because it includes a file upload (`certification_document`).

**Request body (form-data):**

| Field | Type | Required | Example |
|-------|------|----------|---------|
| `username` | string | ✅ | `"agent007"` |
| `email` | string | ✅ | `"agent@example.com"` |
| `password` | string | ✅ | `"MySecurePass123!"` |
| `confirm_password` | string | ✅ | `"MySecurePass123!"` |
| `first_name` | string | ✅ | `"Achraf"` |
| `last_name` | string | ✅ | `"Benali"` |
| `phone` | string | ✅ | `"+212612345678"` |
| `agency_name` | string | ✅ | `"ProStar Agency"` |
| `license_number` | string | ✅ | `"FIFA-2024-001"` |
| `certification_document` | file | ✅ | PDF, JPG, JPEG, or PNG |

**✅ Success response (201):**
```json
{
  "message": "Inscription réussie"
}
```

> ⚠️ The account is created with `status: "pending"`. The user **cannot login** until an admin approves the account.

**❌ Error responses (400):**
```json
{
  "email": ["Cet email est déjà utilisé."],
  "license_number": ["Ce numéro de licence est déjà enregistré."],
  "confirm_password": ["Les mots de passe ne correspondent pas."],
  "password": ["This password is too common."]
}
```

> Errors are returned as field → messages mapping. Display them inline per field.

---

### 4. Logout

```
POST /api/v1/fr/accounts/auth/logout/
```

**Auth required:** ✅ Yes

**Headers:**
```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request body:** `{}` (empty)

**✅ Success response (200):**
```json
{
  "message": "Logged out"
}
```

> On mobile, just delete the stored tokens locally after calling this.

---

### 5. Forgot Password (Request OTP)

```
POST /api/v1/fr/accounts/auth/forgot-password/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "email": "agent@example.com"
}
```

**✅ Success response (200):**
```json
{
  "message": "Si cet email existe dans notre système, un code OTP a été envoyé.",
  "email": "agent@example.com"
}
```

> ⚠️ The response is always the same whether the email exists or not (security best practice — prevents email enumeration).

> 📧 The agent receives a **6-digit OTP code** via email, valid for **10 minutes**.

---

### 6. Verify OTP

```
POST /api/v1/fr/accounts/auth/verify-otp/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "email": "agent@example.com",
  "otp": "482937"
}
```

**✅ Success response (200):**
```json
{
  "message": "Code OTP vérifié avec succès.",
  "reset_token": "a1b2c3d4e5f6...long_hash...",
  "email": "agent@example.com"
}
```

> 💡 Save `reset_token` — you'll need it conceptually to confirm the user verified.
> In practice, the backend tracks verification state server-side, so just proceed to step 7.

**❌ Error responses:**

| Status | Body | When |
|--------|------|------|
| 400 | `{"error": "Email et code OTP sont obligatoires."}` | Missing fields |
| 400 | `{"error": "Code OTP invalide ou expiré."}` | Wrong code or expired (>10 min) |

---

### 7. Resend OTP

```
POST /api/v1/fr/accounts/auth/resend-otp/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "email": "agent@example.com"
}
```

**✅ Success response (200):**
```json
{
  "message": "Un nouveau code OTP a été envoyé à votre email.",
  "cooldown": 60
}
```

> 🔄 **Rate Limited:** Only 1 resend every 60 seconds per email.

**❌ Error responses:**

| Status | Body | When |
|--------|------|------|
| 400 | `{"error": "L'email est obligatoire."}` | Missing email |
| 429 | `{"error": "Veuillez patienter 45 secondes avant de renvoyer un code.", "cooldown": 45}` | Too many requests |

> 💡 Use the `cooldown` value to show a countdown timer on your "Resend OTP" button.

---

### 8. Reset Password

```
POST /api/v1/fr/accounts/auth/reset-password/
```

**Auth required:** ❌ No

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "email": "agent@example.com",
  "otp": "482937",
  "new_password": "NewSecurePass123!",
  "confirm_password": "NewSecurePass123!"
}
```

**✅ Success response (200):**
```json
{
  "message": "Mot de passe réinitialisé avec succès. Vous pouvez maintenant vous connecter."
}
```

> ✅ After this, redirect user to the **Login screen**.

**❌ Error responses:**

| Status | Body | When |
|--------|------|------|
| 400 | `{"error": "Email, code OTP et nouveau mot de passe sont obligatoires."}` | Missing fields |
| 400 | `{"error": "Les mots de passe ne correspondent pas."}` | Mismatch |
| 400 | `{"error": ["This password is too common.", ...]}` | Weak password |
| 400 | `{"error": "Session de réinitialisation expirée. Veuillez recommencer."}` | OTP not verified or expired |

### Forgot Password Flow (3 steps + optional resend)

```
┌──────────┐   1. POST /forgot-password/  ┌──────────┐
│  Mobile  │ ─────────────────────────▶   │  Server  │
│   App    │   { email }                  │          │
│          │ ◀─────────────────────────   │          │
│          │   { message, email }         │  📧 OTP  │
└──────────┘                              └──────────┘
     │
     │  User checks email → enters 6-digit code
     │  (Optional: resend if not received)
     ▼
┌──────────┐   2. POST /verify-otp/       ┌──────────┐
│  Mobile  │ ─────────────────────────▶   │  Server  │
│   App    │   { email, otp }             │          │
│          │ ◀─────────────────────────   │          │
│          │   { message, reset_token }   │          │
└──────────┘                              └──────────┘
     │              │
     │              │ 2a. POST /resend-otp/
     │              └─────────────────────────▶ (if needed)
     │                  { email }
     │              ◀─────────────────────────
     │                { message, cooldown: 60 }
     ▼
┌──────────┐   3. POST /reset-password/   ┌──────────┐
│  Mobile  │ ─────────────────────────▶   │  Server  │
│   App    │   { email, otp,              │          │
│          │     new_password,            │          │
│          │     confirm_password }       │          │
│          │ ◀─────────────────────────   │          │
│          │   { message: "success" }     │          │
└──────────┘                              └──────────┘
     │
     │  → Redirect to Login screen
```

---

### 9. Get My Profile

```
GET /api/v1/fr/accounts/agents/me/
```

**Auth required:** ✅ Yes

**Headers:**
```
Authorization: Bearer <access_token>
```

**✅ Success response (200):**
```json
{
  "id": 5,
  "username": "agent007",
  "email": "agent@example.com",
  "first_name": "Achraf",
  "last_name": "Benali",
  "full_name": "Achraf Benali",
  "phone": "+212612345678",
  "avatar": null,
  "agency_name": "ProStar Agency",
  "license_number": "FIFA-2024-001",
  "fifa_certified": true,
  "certification_date": "2024-03-15",
  "certification_document_url": "/api/v1/fr/accounts/agents/5/certification-document/",
  "country": "Maroc",
  "city": "Casablanca",
  "total_players": 8,
  "total_deals": 3,
  "total_revenue": "4500000.00",
  "status": "approved",
  "status_display": "Approuvé",
  "rejection_reason": "",
  "suspension_reason": null,
  "is_staff": false,
  "is_superuser": false,
  "is_active": true,
  "created_at": "2025-01-15T10:30:00Z",
  "updated_at": "2025-06-20T14:00:00Z"
}
```

---

### 10. Update My Profile

```
PATCH /api/v1/fr/accounts/agents/me/
```

**Auth required:** ✅ Yes

**Headers:**
```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request body (partial — send only fields you want to change):**
```json
{
  "first_name": "Achraf",
  "last_name": "Benali",
  "phone": "+212698765432",
  "agency_name": "New Agency Name",
  "country": "Maroc",
  "city": "Rabat"
}
```

**Editable fields:** `first_name`, `last_name`, `phone`, `agency_name`, `country`, `city`, `avatar`

**✅ Success response (200):** Full agent object (same as login `user` object).

---

## ⚽ PLAYERS

### 11. List All Players (paginated + filters)

```
GET /api/v1/fr/players/players/
```

**Auth required:** ❌ No (public endpoint)

**Query parameters:**

| Param | Type | Description | Example |
|-------|------|-------------|---------|
| `page` | int | Page number (20 per page) | `?page=2` |
| `search` | string | Search by name or club | `?search=mbappe` |
| `position` | string | Exact position | `?position=Attaquant` |
| `nationality_code` | string | ISO country code | `?nationality_code=MA` |
| `agent__isnull` | bool | Only free agents | `?agent__isnull=true` |
| `min_value` | number | Min market value | `?min_value=10000000` |
| `max_value` | number | Max market value | `?max_value=50000000` |
| `ordering` | string | Sort field | `?ordering=-market_value` |

**Position values:** `Gardien`, `Défenseur`, `Milieu`, `Attaquant`

**Ordering options:** `market_value`, `-market_value`, `overall_rating`, `-overall_rating`, `date_of_birth`, `-date_of_birth`

**✅ Success response (200):**
```json
{
  "count": 41,
  "next": "http://localhost:8000/api/v1/fr/players/players/?page=2",
  "previous": null,
  "results": [
    {
      "id": 16,
      "first_name": "Lamine",
      "last_name": "Yamal",
      "full_name": "Lamine Yamal",
      "position": "Attaquant",
      "nationality_code": "ES",
      "nationality_name": "Spain",
      "club_name": "FC Barcelona",
      "club_logo": "https://media.api-sports.io/football/teams/529.png",
      "market_value": "150000000.00",
      "overall_rating": "82.50",
      "photo": "https://media.api-sports.io/football/players/12345.png",
      "date_of_birth": "2007-07-13",
      "age": 18,
      "agent_name": null,
      "agent_id": null,
      "created_at": "2025-10-01T12:00:00Z"
    }
  ]
}
```

**Example with filters:**
```
GET /api/v1/fr/players/players/?position=Attaquant&min_value=50000000&ordering=-overall_rating&page=1
```

---

### 12. Get Player Detail

```
GET /api/v1/fr/players/players/{id}/
```

**Auth required:** ❌ No

**✅ Success response (200):**
```json
{
  "id": 16,
  "api_id": 12345,
  "first_name": "Lamine",
  "last_name": "Yamal",
  "date_of_birth": "2007-07-13",
  "age": 18,
  "nationality_code": "ES",
  "nationality_name": "Spain",
  "position": "Attaquant",
  "current_club": {
    "id": 5,
    "name": "FC Barcelona",
    "logo": "https://media.api-sports.io/football/teams/529.png",
    "country_name": "Spain",
    "country_code": "ES"
  },
  "height": 180,
  "weight": 72,
  "preferred_foot": "left",
  "market_value": "150000000.00",
  "market_value_currency": "EUR",
  "agent": {
    "id": 5,
    "username": "agent007",
    "email": "agent@example.com",
    "full_name": "Achraf Benali",
    "agency_name": "ProStar Agency",
    "fifa_certified": true
  },
  "overall_rating": "82.50",
  "photo": "https://media.api-sports.io/football/players/12345.png",
  "value_history": [
    { "id": 1, "player": 16, "value": "145269434.13", "currency": "EUR", "date": "2026-01-01" },
    { "id": 2, "player": 16, "value": "166614598.68", "currency": "EUR", "date": "2025-12-02" }
  ],
  "season_stats": [
    {
      "id": 1,
      "season": "2025",
      "appearances": 30,
      "lineups": 28,
      "minutes": 2520,
      "goals": 15,
      "assists": 10,
      "shots_total": 80,
      "shots_on": 45,
      "passes_total": 1200,
      "passes_key": 40,
      "passes_accuracy": 85,
      "duels_total": 300,
      "duels_won": 160,
      "dribbles_attempts": 100,
      "dribbles_success": 65,
      "tackles_total": 20,
      "blocks": 5,
      "interceptions": 15,
      "fouls_drawn": 30,
      "fouls_committed": 10,
      "yellow": 3,
      "red": 0,
      "rating": "7.80"
    }
  ],
  "match_history": [],
  "created_at": "2025-10-01T12:00:00Z",
  "updated_at": "2026-01-15T08:00:00Z"
}
```

---

### 13. Get Player Stats (dedicated endpoint)

```
GET /api/v1/fr/players/players/{id}/stats/
```

**Auth required:** ❌ No (but if authenticated, includes `is_in_watchlist`)

**✅ Success response (200):**
```json
{
  "overall_rating": 82.5,
  "current_stats": {
    "id": 1,
    "season": "2025",
    "appearances": 30,
    "lineups": 28,
    "minutes": 2520,
    "goals": 15,
    "assists": 10,
    "shots_total": 80,
    "shots_on": 45,
    "passes_total": 1200,
    "passes_key": 40,
    "passes_accuracy": 85,
    "duels_total": 300,
    "duels_won": 160,
    "dribbles_attempts": 100,
    "dribbles_success": 65,
    "tackles_total": 20,
    "blocks": 5,
    "interceptions": 15,
    "fouls_drawn": 30,
    "fouls_committed": 10,
    "yellow": 3,
    "red": 0,
    "rating": "7.80"
  },
  "market_history": [
    { "id": 1, "player": 16, "value": "145269434.13", "currency": "EUR", "date": "2026-01-01" },
    { "id": 2, "player": 16, "value": "166614598.68", "currency": "EUR", "date": "2025-12-02" }
  ],
  "match_history": [
    {
      "id": 1,
      "match_date": "2026-01-05",
      "opponent": "Real Madrid",
      "competition": "La Liga",
      "performance_rating": "8.20"
    }
  ],
  "is_in_watchlist": false
}
```

> `current_stats` is `null` if no stats are available for that player.

---

### 14. Get My Players (agent's portfolio)

```
GET /api/v1/fr/players/players/my_players/
```

**Auth required:** ✅ Yes

**Headers:**
```
Authorization: Bearer <access_token>
```

**✅ Success response (200):** Array of player list objects (same shape as list endpoint `results`).

---

### 15. Assign Players to Agent

```
POST /api/v1/fr/players/players/assign_to_agent/
```

**Auth required:** ✅ Yes

**Headers:**
```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request body:**
```json
{
  "player_ids": [16, 21, 34]
}
```

Optional: `"force_reassign": true` to take players from other agents.

**✅ Success response (200):**
```json
{
  "assigned": 2,
  "already_yours": 1,
  "already_assigned_others": 0,
  "message": "2 joueur(s) assigné(s) à votre portefeuille"
}
```

---

### 16. Create Player

```
POST /api/v1/fr/players/players/
```

**Auth required:** ❌ No (AllowAny)

**Headers:**
```
Content-Type: application/json
```

**Request body:**
```json
{
  "first_name": "Youssef",
  "last_name": "En-Nesyri",
  "date_of_birth": "1997-06-01",
  "nationality_code": "MA",
  "nationality_name": "Morocco",
  "position": "Attaquant",
  "current_club_id": 5,
  "height": 189,
  "weight": 78,
  "preferred_foot": "right",
  "market_value": 25000000,
  "market_value_currency": "EUR",
  "photo": "https://example.com/photo.jpg",
  "overall_rating": 78.5
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `first_name` | string | ✅ | |
| `last_name` | string | ✅ | |
| `position` | string | ✅ | `Gardien`, `Défenseur`, `Milieu`, `Attaquant` |
| `date_of_birth` | date | ❌ | Format: `YYYY-MM-DD` |
| `nationality_code` | string | ❌ | ISO 2-letter code |
| `nationality_name` | string | ❌ | Full country name |
| `current_club_id` | int/null | ❌ | Club FK, `null` = free agent |
| `agent_id` | int/null | ❌ | Agent FK |
| `height` | int | ❌ | In cm |
| `weight` | int | ❌ | In kg |
| `preferred_foot` | string | ❌ | `right`, `left`, `both` |
| `market_value` | decimal | ❌ | In EUR |
| `photo` | URL | ❌ | |
| `overall_rating` | decimal | ❌ | 0–100 |

**✅ Success response (201):** Full player detail object.

---

### 17. Add to Watchlist

```
POST /api/v1/fr/players/players/{id}/add_to_watchlist/
```

**Auth required:** ✅ Yes

**Headers:**
```
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request body:**
```json
{
  "priority": "high",
  "notes": "Interesting target for summer window"
}
```

**Priority values:** `low`, `medium`, `high`, `critical`

**✅ Success response (201 or 200):**
```json
{
  "status": "created",
  "watchlist_id": 12,
  "message": "Joueur ajouté à votre watchlist"
}
```

---

### 18. Remove from Watchlist

```
DELETE /api/v1/fr/players/players/{id}/remove_from_watchlist/
```

**Auth required:** ✅ Yes

**Headers:**
```
Authorization: Bearer <access_token>
```

**✅ Success response (200):**
```json
{
  "status": "removed",
  "message": "Joueur retiré de votre watchlist"
}
```

---

### 19. Market Value Stats (global)

```
GET /api/v1/fr/players/players/market_value_stats/
```

**Auth required:** ❌ No

**✅ Success response (200):**
```json
{
  "total_players": 41,
  "avg_value": 45000000.00,
  "max_value": 150000000.00,
  "min_value": 500000.00,
  "avg_rating": 74.20
}
```

---

### 20. Players with Expiring Contracts

```
GET /api/v1/fr/players/players/expiring_contracts/?days=90
```

**Auth required:** ❌ No

**Query params:** `days` (default: 90)

**✅ Success response (200):** Array of player list objects.

---

## 🔄 QUICK REFERENCE

### Auth Header (for all protected endpoints)

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Auth Flow Diagram

```
┌──────────┐     POST /auth/login/      ┌──────────┐
│  Mobile  │ ────────────────────────▶   │  Server  │
│   App    │   { username, password }    │          │
│          │ ◀────────────────────────   │          │
│          │   { tokens: { access,       │          │
│          │     refresh }, user }       │          │
└──────────┘                             └──────────┘
     │
     │  Store tokens securely
     ▼
┌──────────┐     GET /any-endpoint/      ┌──────────┐
│  Mobile  │ ────────────────────────▶   │  Server  │
│   App    │   Authorization: Bearer     │          │
│          │   <access_token>            │          │
│          │ ◀────────────────────────   │          │
│          │   { data... }               │          │
└──────────┘                             └──────────┘
     │
     │  If 401 error...
     ▼
┌──────────┐     POST /auth/refresh/     ┌──────────┐
│  Mobile  │ ────────────────────────▶   │  Server  │
│   App    │   { refresh: "..." }        │          │
│          │ ◀────────────────────────   │          │
│          │   { tokens: { access } }    │          │
└──────────┘                             └──────────┘
     │
     │  If refresh also 401 → Go to Login screen
```

### Endpoints Summary Table

| # | Method | Endpoint | Auth | Description |
|---|--------|----------|------|-------------|
| 1 | POST | `/accounts/auth/login/` | ❌ | Login → get tokens |
| 2 | POST | `/accounts/auth/refresh/` | ❌ | Refresh access token |
| 3 | POST | `/accounts/agents/register/` | ❌ | Register (multipart) |
| 4 | POST | `/accounts/auth/logout/` | ✅ | Logout |
| 5 | POST | `/accounts/auth/forgot-password/` | ❌ | Request OTP via email |
| 6 | POST | `/accounts/auth/verify-otp/` | ❌ | Verify OTP code |
| 7 | POST | `/accounts/auth/reset-password/` | ❌ | Set new password |
| 8 | GET | `/accounts/agents/me/` | ✅ | Get my profile |
| 9 | PATCH | `/accounts/agents/me/` | ✅ | Update my profile |
| 10 | GET | `/players/players/` | ❌ | List all players |
| 11 | GET | `/players/players/{id}/` | ❌ | Player detail |
| 12 | GET | `/players/players/{id}/stats/` | ❌ | Player stats |
| 13 | GET | `/players/players/my_players/` | ✅ | My players |
| 14 | POST | `/players/players/assign_to_agent/` | ✅ | Assign players |
| 15 | POST | `/players/players/` | ❌ | Create player |
| 16 | POST | `/players/players/{id}/add_to_watchlist/` | ✅ | Add to watchlist |
| 17 | DELETE | `/players/players/{id}/remove_from_watchlist/` | ✅ | Remove from watchlist |
| 18 | GET | `/players/players/market_value_stats/` | ❌ | Global market stats |
| 19 | GET | `/players/players/expiring_contracts/` | ❌ | Expiring contracts |

> All endpoints are prefixed with `/api/v1/fr`

---

## 🧪 POSTMAN TESTING

### Step 1: Login
- Method: `POST`
- URL: `http://localhost:8000/api/v1/fr/accounts/auth/login/`
- Body → raw → JSON:
```json
{ "username": "your_user", "password": "your_pass" }
```
- Copy `tokens.access` from response

### Step 2: Use token on protected endpoints
- Go to **Authorization** tab
- Type: **Bearer Token**
- Token: paste the access token

### Step 3: Test refresh
- Method: `POST`
- URL: `http://localhost:8000/api/v1/fr/accounts/auth/refresh/`
- Body → raw → JSON:
```json
{ "refresh": "paste_your_refresh_token_here" }
```

---

### 21. AI Player Valuation (Claude API)

```
POST /api/v1/fr/players/players/{id}/ai_valuation/
```

**Auth required:** ✅ Yes (Bearer token)

**Description:**
Uses Anthropic Claude API to generate a deep, contextual market value estimation for a player. The backend collects the player's full profile (stats, market history, contract info) and sends it to Claude for expert-level analysis.

**Requirements:** `CLAUDE_API_KEY` must be set in backend `.env` + `pip install anthropic`

**Request:** No body required (player ID in URL)

**Headers:**
```
Authorization: Bearer <access_token>
Content-Type: application/json
```

**✅ Success response (200):**
```json
{
  "status": "success",
  "ai_estimate": 45000000,
  "confidence": 78,
  "reasoning": "Ce joueur de 24 ans présente un profil très intéressant avec une note de 7.2 et 12 buts en 30 matchs. Sa trajectoire de valeur est en hausse constante...",
  "key_factors": [
    { "factor": "Âge et potentiel", "impact": "positif", "detail": "24 ans, en pleine ascension" },
    { "factor": "Stats offensives", "impact": "positif", "detail": "12 buts, 0.65 G+A/90" },
    { "factor": "Situation contractuelle", "impact": "négatif", "detail": "Contrat expire dans 8 mois" }
  ],
  "comparables": [
    { "name": "Marcus Rashford", "value": 55000000, "why": "Profil offensif similaire, même tranche d'âge" },
    { "name": "Donyell Malen", "value": 35000000, "why": "Stats comparables en championnat" }
  ],
  "recommendation": "CONSERVER",
  "recommendation_detail": "Valeur en hausse, recommandé de prolonger le contrat avant expiration pour maximiser la plus-value.",
  "player_context": {
    "id": 42,
    "name": "John Doe",
    "position": "Attaquant",
    "current_value": 35000000,
    "photo": "/media/player_photos/photo.jpg"
  }
}
```

**❌ Error response (API key missing):**
```json
{
  "status": "error",
  "error": "Clé API Anthropic invalide ou manquante.",
  "ai_estimate": null
}
```

**Flutter example:**
```dart
final response = await http.post(
  Uri.parse('$baseUrl/players/players/42/ai_valuation/'),
  headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
);
final data = jsonDecode(response.body);
print('AI Estimate: ${data['ai_estimate']}');
print('Confidence: ${data['confidence']}%');
print('Recommendation: ${data['recommendation']}');
```

---

*Last updated: February 2026 — AgentPro v1*
